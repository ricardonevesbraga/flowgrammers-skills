---
name: "ms365-tenant-manager"
description: Administração de tenant Microsoft 365 para Administradores Globais. Automatize configuração de tenant M365, tarefas de administração do Office 365, gerenciamento de usuários Azure AD, configuração do Exchange Online, administração do Teams e políticas de segurança. Gere scripts PowerShell para operações em massa, políticas de Acesso Condicional, gerenciamento de licenças e relatórios de conformidade. Use para gerenciamento de tenant M365, admin Office 365, usuários Azure AD, Administrador Global, configuração de tenant ou automação Microsoft 365.
author: Ric Neves - Flowgrammers
agents:
  - claude-code
---

# Microsoft 365 Tenant Manager

Orientação especializada e automação para Administradores Globais Microsoft 365 gerenciando configuração de tenant, ciclo de vida de usuários, políticas de segurança e otimização organizacional.

---

## Início Rápido

### Executar uma Auditoria de Segurança

```powershell
Connect-MgGraph -Scopes "Directory.Read.All","Policy.Read.All","AuditLog.Read.All"
Get-MgSubscribedSku | Select-Object SkuPartNumber, ConsumedUnits, @{N="Total";E={$_.PrepaidUnits.Enabled}}
Get-MgPolicyAuthorizationPolicy | Select-Object AllowInvitesFrom, DefaultUserRolePermissions
```

### Provisionar Usuários em Massa a partir de CSV

```powershell
# Colunas CSV: DisplayName, UserPrincipalName, Department, LicenseSku
Import-Csv .\new_users.csv | ForEach-Object {
    $passwordProfile = @{ Password = (New-Guid).ToString().Substring(0,16) + "!"; ForceChangePasswordNextSignIn = $true }
    New-MgUser -DisplayName $_.DisplayName -UserPrincipalName $_.UserPrincipalName `
               -Department $_.Department -AccountEnabled -PasswordProfile $passwordProfile
}
```

### Criar uma Política de Acesso Condicional (MFA para Admins)

```powershell
$adminRoles = (Get-MgDirectoryRole | Where-Object { $_.DisplayName -match "Admin" }).Id
$policy = @{
    DisplayName = "Require MFA for Admins"
    State = "enabledForReportingButNotEnforced"   # Iniciar em modo de relatório apenas
    Conditions = @{ Users = @{ IncludeRoles = $adminRoles } }
    GrantControls = @{ Operator = "OR"; BuiltInControls = @("mfa") }
}
New-MgIdentityConditionalAccessPolicy -BodyParameter $policy
```

---

## Fluxos de Trabalho

### Fluxo de Trabalho 1: Configuração de Novo Tenant

**Passo 1: Gerar Lista de Verificação de Configuração**

Confirmar pré-requisitos antes do provisionamento:
- Conta de Administrador Global criada e protegida com MFA
- Domínio personalizado adquirido e acessível para edições de DNS
- SKUs de licença confirmados (requisitos de funcionalidades E3 vs E5 anotados)

**Passo 2: Configurar e Verificar Registros DNS**

```powershell
# Após adicionar o domínio no centro de administração M365, verifique a propagação antes de prosseguir
$domain = "company.com"
Resolve-DnsName -Name "_msdcs.$domain" -Type NS -ErrorAction SilentlyContinue
# Execute também a partir de um prompt de shell:
# nslookup -type=MX company.com
# nslookup -type=TXT company.com   # confirmar registro SPF
```

Aguardar a propagação de DNS (até 48h) antes da criação de usuários em massa.

**Passo 3: Aplicar Baseline de Segurança**

```powershell
# Desabilitar autenticação legada (bloqueia protocolos de Autenticação Básica)
$policy = @{
    DisplayName = "Block Legacy Authentication"
    State = "enabled"
    Conditions = @{ ClientAppTypes = @("exchangeActiveSync","other") }
    GrantControls = @{ Operator = "OR"; BuiltInControls = @("block") }
}
New-MgIdentityConditionalAccessPolicy -BodyParameter $policy

# Habilitar log de auditoria unificado
Set-AdminAuditLogConfig -UnifiedAuditLogIngestionEnabled $true
```

**Passo 4: Provisionar Usuários**

```powershell
$licenseSku = (Get-MgSubscribedSku | Where-Object { $_.SkuPartNumber -eq "ENTERPRISEPACK" }).SkuId

Import-Csv .\employees.csv | ForEach-Object {
    try {
        $user = New-MgUser -DisplayName $_.DisplayName -UserPrincipalName $_.UserPrincipalName `
                           -AccountEnabled -PasswordProfile @{ Password = (New-Guid).ToString().Substring(0,12)+"!"; ForceChangePasswordNextSignIn = $true }
        Set-MgUserLicense -UserId $user.Id -AddLicenses @(@{ SkuId = $licenseSku }) -RemoveLicenses @()
        Write-Host "Provisionado: $($_.UserPrincipalName)"
    } catch {
        Write-Warning "Falhou $($_.UserPrincipalName): $_"
    }
}
```

**Validação:** Verificar 3–5 contas no portal de administração M365; confirmar que as licenças mostram "Ativo."

---

### Fluxo de Trabalho 2: Hardening de Segurança

**Passo 1: Executar Auditoria de Segurança**

```powershell
Connect-MgGraph -Scopes "Directory.Read.All","Policy.Read.All","AuditLog.Read.All","Reports.Read.All"

# Exportar inventário de políticas de Acesso Condicional
Get-MgIdentityConditionalAccessPolicy | Select-Object DisplayName, State |
    Export-Csv .\ca_policies.csv -NoTypeInformation

# Encontrar contas sem MFA registrado
$report = Get-MgReportAuthenticationMethodUserRegistrationDetail
$report | Where-Object { -not $_.IsMfaRegistered } |
    Select-Object UserPrincipalName, IsMfaRegistered |
    Export-Csv .\no_mfa_users.csv -NoTypeInformation

Write-Host "Auditoria concluída. Revise ca_policies.csv e no_mfa_users.csv."
```

**Passo 2: Criar Política MFA (relatório apenas primeiro)**

```powershell
$policy = @{
    DisplayName = "Require MFA All Users"
    State = "enabledForReportingButNotEnforced"
    Conditions = @{ Users = @{ IncludeUsers = @("All") } }
    GrantControls = @{ Operator = "OR"; BuiltInControls = @("mfa") }
}
New-MgIdentityConditionalAccessPolicy -BodyParameter $policy
```

**Validação:** Após 48h, revise os logs de entrada no Entra ID; confirme que os usuários esperados seriam desafiados, então altere `State` para `"enabled"`.

**Passo 3: Revisar Secure Score**

```powershell
# Recuperar Secure Score atual e principais ações de melhoria
Get-MgSecuritySecureScore -Top 1 | Select-Object CurrentScore, MaxScore, ActiveUserCount
Get-MgSecuritySecureScoreControlProfile | Sort-Object -Property ActionType |
    Select-Object Title, ImplementationStatus, MaxScore | Format-Table -AutoSize
```

---

### Fluxo de Trabalho 3: Desligamento de Usuário

**Passo 1: Bloquear Login e Revogar Sessões**

```powershell
$upn = "departing.user@company.com"
$user = Get-MgUser -Filter "userPrincipalName eq '$upn'"

# Bloquear login imediatamente
Update-MgUser -UserId $user.Id -AccountEnabled:$false

# Revogar todos os tokens ativos
Invoke-MgInvalidateAllUserRefreshToken -UserId $user.Id
Write-Host "Login bloqueado e sessões revogadas para $upn"
```

**Passo 2: Preview com -WhatIf (remoção de licença)**

```powershell
# Identificar licenças atribuídas
$licenses = (Get-MgUserLicenseDetail -UserId $user.Id).SkuId

# Execução simulada: imprimir o que seria removido
$licenses | ForEach-Object { Write-Host "[WhatIf] Would remove SKU: $_" }
```

**Passo 3: Executar Desligamento**

```powershell
# Remover licenças
Set-MgUserLicense -UserId $user.Id -AddLicenses @() -RemoveLicenses $licenses

# Converter mailbox para compartilhado (requer módulo ExchangeOnlineManagement)
Set-Mailbox -Identity $upn -Type Shared

# Remover de todos os grupos
Get-MgUserMemberOf -UserId $user.Id | ForEach-Object {
    try { Remove-MgGroupMemberByRef -GroupId $_.Id -DirectoryObjectId $user.Id } catch {}
}
Write-Host "Desligamento concluído para $upn"
```

**Validação:** Confirmar no portal de administração M365 que a conta mostra "Bloqueado", não tem licenças ativas e o tipo de mailbox é "Compartilhado."

---

## Melhores Práticas

### Configuração do Tenant

1. Habilitar MFA antes de adicionar usuários
2. Configurar named locations para Acesso Condicional
3. Usar contas de admin separadas com PIM
4. Verificar domínios personalizados (e propagação de DNS) antes da criação em massa de usuários
5. Aplicar recomendações do Microsoft Secure Score

### Operações de Segurança

1. Iniciar políticas de Acesso Condicional em modo de relatório apenas
2. Revisar logs de entrada por 48h antes de aplicar uma nova política
3. Nunca codificar credenciais em scripts — use Azure Key Vault ou `Get-Credential`
4. Habilitar registro de auditoria unificado para todas as operações
5. Realizar revisões de segurança trimestrais e check-ins de Secure Score

### Automação PowerShell

1. Preferir Microsoft Graph (módulo `Microsoft.Graph`) ao legado MSOnline
2. Incluir blocos `try/catch` para tratamento de erros
3. Implementar logging `Write-Host`/`Write-Warning` para trilhas de auditoria
4. Usar `-WhatIf` ou saída de execução simulada antes de operações destrutivas em massa
5. Testar em um tenant não-produção primeiro

---

## Guias de Referência

**references/powershell-templates.md**
- Templates de script prontos para uso
- Exemplos de políticas de Acesso Condicional
- Scripts de provisionamento em massa de usuários
- Scripts de auditoria de segurança

**references/security-policies.md**
- Configuração de Acesso Condicional
- Estratégias de aplicação de MFA
- Políticas DLP e de retenção
- Configurações de baseline de segurança

**references/troubleshooting.md**
- Resoluções de erros comuns
- Problemas de módulo PowerShell
- Solução de problemas de permissão
- Problemas de propagação de DNS

---

## Limitações

| Restrição | Impacto |
|------------|--------|
| Administrador Global necessário | A configuração completa do tenant requer o privilégio mais alto |
| Limites de taxa de API | Operações em massa podem sofrer throttling |
| Dependências de licença | E3/E5 necessário para recursos avançados |
| Cenários híbridos | AD on-premises requer configuração adicional |
| Pré-requisitos PowerShell | Módulo Microsoft.Graph necessário |

### Módulos PowerShell Obrigatórios

```powershell
Install-Module Microsoft.Graph -Scope CurrentUser
Install-Module ExchangeOnlineManagement -Scope CurrentUser
Install-Module MicrosoftTeams -Scope CurrentUser
```

### Permissões Obrigatórias

- **Administrador Global** — Configuração completa do tenant
- **Administrador de Usuários** — Gerenciamento de usuários
- **Administrador de Segurança** — Políticas de segurança
- **Administrador do Exchange** — Gerenciamento de mailbox
