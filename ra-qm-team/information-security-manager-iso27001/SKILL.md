---
name: "information-security-manager-iso27001"
description: Implementação de ISMS ISO 27001 e governança de cibersegurança para empresas HealthTech e MedTech. Use para design de ISMS, avaliação de riscos de segurança, implementação de controles, certificação ISO 27001, auditorias de segurança, resposta a incidentes e verificação de conformidade. Cobre ISO 27001, ISO 27002, segurança em saúde e cibersegurança de dispositivos médicos — com foco no mercado brasileiro.
---

# Information Security Manager - ISO 27001

Implementar e gerenciar Sistemas de Gestão de Segurança da Informação (ISMS) alinhados com a ISO 27001:2022 e requisitos regulatórios de saúde.

---

## Sumário

- [Frases Gatilho](#frases-gatilho)
- [Início Rápido](#início-rápido)
- [Ferramentas](#ferramentas)
- [Fluxos de Trabalho](#fluxos-de-trabalho)
- [Guias de Referência](#guias-de-referência)
- [Checkpoints de Validação](#checkpoints-de-validação)

---

## Frases Gatilho

Use esta skill quando ouvir:
- "implementar ISO 27001"
- "implementação de ISMS"
- "avaliação de riscos de segurança"
- "política de segurança da informação"
- "certificação ISO 27001"
- "implementação de controles de segurança"
- "plano de resposta a incidentes"
- "segurança de dados de saúde"
- "cibersegurança de dispositivos médicos"
- "auditoria de conformidade de segurança"

---

## Início Rápido

### Executar Avaliação de Riscos de Segurança

```bash
python scripts/risk_assessment.py --scope "patient-data-system" --output risk_register.json
```

### Verificar Status de Conformidade

```bash
python scripts/compliance_checker.py --standard iso27001 --controls-file controls.csv
```

### Gerar Relatório de Análise de Lacunas

```bash
python scripts/compliance_checker.py --standard iso27001 --gap-analysis --output gaps.md
```

---

## Ferramentas

### risk_assessment.py

Avaliação automatizada de riscos de segurança seguindo a metodologia da Cláusula 6.1.2 da ISO 27001.

**Uso:**

```bash
# Avaliação de risco completa
python scripts/risk_assessment.py --scope "cloud-infrastructure" --output risks.json

# Avaliação específica para saúde
python scripts/risk_assessment.py --scope "ehr-system" --template healthcare --output risks.json

# Avaliação rápida baseada em ativos
python scripts/risk_assessment.py --assets assets.csv --output risks.json
```

**Parâmetros:**

| Parâmetro | Obrigatório | Descrição |
|-----------|----------|-------------|
| `--scope` | Sim | Sistema ou área a ser avaliada |
| `--template` | Não | Template de avaliação: `general`, `healthcare`, `cloud` |
| `--assets` | Não | Arquivo CSV com inventário de ativos |
| `--output` | Não | Arquivo de saída (padrão: stdout) |
| `--format` | Não | Formato de saída: `json`, `csv`, `markdown` |

**Saída:**
- Inventário de ativos com classificação
- Mapeamento de ameaças e vulnerabilidades
- Pontuações de risco (probabilidade × impacto)
- Recomendações de tratamento
- Cálculos de risco residual

### compliance_checker.py

Verificar o status de implementação dos controles ISO 27001/27002.

**Uso:**

```bash
# Verificar todos os controles ISO 27001
python scripts/compliance_checker.py --standard iso27001

# Análise de lacunas com recomendações
python scripts/compliance_checker.py --standard iso27001 --gap-analysis

# Verificar domínios de controle específicos
python scripts/compliance_checker.py --standard iso27001 --domains "access-control,cryptography"

# Exportar relatório de conformidade
python scripts/compliance_checker.py --standard iso27001 --output compliance_report.md
```

**Parâmetros:**

| Parâmetro | Obrigatório | Descrição |
|-----------|----------|-------------|
| `--standard` | Sim | Norma a verificar: `iso27001`, `iso27002`, `hipaa` |
| `--controls-file` | Não | CSV com status atual dos controles |
| `--gap-analysis` | Não | Incluir recomendações de remediação |
| `--domains` | Não | Domínios de controle específicos a verificar |
| `--output` | Não | Caminho do arquivo de saída |

**Saída:**
- Status de implementação dos controles
- Percentual de conformidade por domínio
- Análise de lacunas com prioridades
- Recomendações de remediação

---

## Fluxos de Trabalho

### Fluxo de Trabalho 1: Implementação do ISMS

**Passo 1: Definir Escopo e Contexto**

Documentar o contexto organizacional e os limites do ISMS:
- Identificar partes interessadas e seus requisitos
- Definir escopo e limites do ISMS
- Documentar questões internas/externas

**Validação:** Declaração de escopo revisada e aprovada pela gestão.

**Passo 2: Conduzir Avaliação de Riscos**

```bash
python scripts/risk_assessment.py --scope "full-organization" --template general --output initial_risks.json
```

- Identificar ativos de informação
- Avaliar ameaças e vulnerabilidades
- Calcular níveis de risco
- Determinar opções de tratamento de risco

**Validação:** Registro de riscos contém todos os ativos críticos com donos atribuídos.

**Passo 3: Selecionar e Implementar Controles**

Mapear riscos para controles ISO 27002:

```bash
python scripts/compliance_checker.py --standard iso27002 --gap-analysis --output control_gaps.md
```

Categorias de controles:
- Organizacionais (políticas, funções, responsabilidades)
- Pessoal (triagem, conscientização, treinamento)
- Físicos (perímetros, equipamentos, mídia)
- Tecnológicos (acesso, criptografia, rede, aplicação)

**Validação:** Declaração de Aplicabilidade (SoA) documenta todos os controles com justificativa.

**Passo 4: Estabelecer Monitoramento**

Definir métricas de segurança:
- Contagem e tendências de severidade de incidentes
- Pontuações de eficácia dos controles
- Taxas de conclusão de treinamento
- Taxa de encerramento de achados de auditoria

**Validação:** Painel mostra status de conformidade em tempo real.

### Fluxo de Trabalho 2: Avaliação de Riscos de Segurança

**Passo 1: Identificação de Ativos**

Criar inventário de ativos:

| Tipo de Ativo | Exemplos | Classificação |
|------------|----------|----------------|
| Informação | Registros de pacientes, código-fonte | Confidencial |
| Software | Sistema EHR, APIs | Crítico |
| Hardware | Servidores, dispositivos médicos | Alto |
| Serviços | Hospedagem em nuvem, backup | Alto |
| Pessoas | Contas de admin, desenvolvedores | Variável |

**Validação:** Todos os ativos têm donos e classificações atribuídos.

**Passo 2: Análise de Ameaças**

Identificar ameaças por categoria de ativo:

| Ativo | Ameaças | Probabilidade |
|-------|---------|------------|
| Dados do paciente | Acesso não autorizado, violação | Alta |
| Dispositivos médicos | Malware, adulteração | Média |
| Serviços em nuvem | Configuração incorreta, indisponibilidade | Média |
| Credenciais | Phishing, força bruta | Alta |

**Validação:** Modelo de ameaça cobre as 10 principais ameaças do setor.

**Passo 3: Avaliação de Vulnerabilidades**

```bash
python scripts/risk_assessment.py --scope "network-infrastructure" --output vuln_risks.json
```

Documentar vulnerabilidades:
- Técnicas (sistemas sem patches, configurações fracas)
- Processuais (procedimentos ausentes, lacunas)
- Humanas (falta de treinamento, risco interno)

**Validação:** Resultados de varredura de vulnerabilidades mapeados ao registro de riscos.

**Passo 4: Avaliação e Tratamento de Riscos**

Calcular risco: `Risco = Probabilidade × Impacto`

| Nível de Risco | Pontuação | Tratamento |
|------------|-------|-----------|
| Crítico | 20-25 | Ação imediata necessária |
| Alto | 15-19 | Plano de tratamento em 30 dias |
| Médio | 10-14 | Plano de tratamento em 90 dias |
| Baixo | 5-9 | Aceitar ou monitorar |
| Mínimo | 1-4 | Aceitar |

**Validação:** Todos os riscos altos/críticos têm planos de tratamento aprovados.

### Fluxo de Trabalho 3: Resposta a Incidentes

**Passo 1: Detecção e Reporte**

Categorias de incidentes:
- Violação de segurança (acesso não autorizado)
- Infecção por malware
- Vazamento de dados
- Comprometimento de sistema
- Violação de política

**Validação:** Incidente registrado em até 15 minutos da detecção.

**Passo 2: Triagem e Classificação**

| Severidade | Critério | Tempo de Resposta |
|----------|----------|---------------|
| Crítico | Violação de dados, sistema fora | Imediato |
| Alto | Ameaça ativa, risco significativo | 1 hora |
| Médio | Ameaça contida, impacto limitado | 4 horas |
| Baixo | Violação menor, sem impacto | 24 horas |

**Validação:** Severidade atribuída e escalonamento acionado se necessário.

**Passo 3: Contenção e Erradicação**

Ações imediatas:
1. Isolar sistemas afetados
2. Preservar evidências
3. Bloquear vetores de ameaça
4. Remover artefatos maliciosos

**Validação:** Contenção confirmada, sem comprometimento em andamento.

**Passo 4: Recuperação e Lições Aprendidas**

Atividades pós-incidente:
1. Restaurar sistemas a partir de backups limpos
2. Verificar integridade antes da reconexão
3. Documentar linha do tempo e ações
4. Conduzir revisão pós-incidente
5. Atualizar controles e procedimentos

**Validação:** Relatório pós-incidente concluído em até 5 dias úteis.

---

## Guias de Referência

### Quando Usar Cada Referência

**references/iso27001-controls.md**
- Seleção de controles para SoA
- Orientação de implementação
- Requisitos de evidência
- Preparação para auditoria

**references/risk-assessment-guide.md**
- Seleção de metodologia de risco
- Critérios de classificação de ativos
- Abordagens de modelagem de ameaças
- Métodos de cálculo de risco

**references/incidente-response.md**
- Procedimentos de resposta
- Matrizes de escalonamento
- Templates de comunicação
- Listas de verificação de recuperação

---

## Checkpoints de Validação

### Validação de Implementação do ISMS

| Fase | Checkpoint | Evidência Obrigatória |
|-------|------------|-------------------|
| Escopo | Escopo aprovado | Documento de escopo assinado |
| Risco | Registro completo | Registro de riscos com donos |
| Controles | SoA aprovada | Declaração de Aplicabilidade |
| Operação | Métricas ativas | Capturas de tela do painel |
| Auditoria | Auditoria interna realizada | Relatório de auditoria |

### Prontidão para Certificação

Antes do audit Estágio 1:
- [ ] Escopo do ISMS documentado e aprovado
- [ ] Política de segurança da informação publicada
- [ ] Avaliação de riscos concluída
- [ ] Declaração de Aplicabilidade finalizada
- [ ] Auditoria interna realizada
- [ ] Revisão gerencial concluída
- [ ] Não conformidades tratadas

Antes do audit Estágio 2:
- [ ] Controles implementados e operacionais
- [ ] Evidência de eficácia disponível
- [ ] Pessoal treinado e conscientizado
- [ ] Incidentes registrados e gerenciados
- [ ] Métricas coletadas por 3+ meses

### Verificação de Conformidade

Executar verificações periódicas:

```bash
# Verificação mensal de conformidade
python scripts/compliance_checker.py --standard iso27001 --output monthly_$(date +%Y%m).md

# Análise de lacunas trimestral
python scripts/compliance_checker.py --standard iso27001 --gap-analysis --output quarterly_gaps.md
```

---

## Exemplo Prático: Avaliação de Riscos em Saúde

**Cenário:** Avaliar riscos de segurança para um sistema de gestão de dados de pacientes.

### Passo 1: Definir Ativos

```bash
python scripts/risk_assessment.py --scope "patient-data-system" --template healthcare
```

**Saída do inventário de ativos:**

| ID do Ativo | Ativo | Tipo | Dono | Classificação |
|----------|-------|------|-------|----------------|
| A001 | Banco de dados de pacientes | Informação | Equipe DBA | Confidencial |
| A002 | Aplicação EHR | Software | Equipe de App | Crítico |
| A003 | Servidor de banco de dados | Hardware | Equipe de Infra | Alto |
| A004 | Credenciais de admin | Acesso | Segurança | Crítico |

### Passo 2: Identificar Riscos

**Saída do registro de riscos:**

| ID do Risco | Ativo | Ameaça | Vulnerabilidade | P | I | Pontuação |
|---------|-------|--------|---------------|---|---|-------|
| R001 | A001 | Violação de dados | Criptografia fraca | 3 | 5 | 15 |
| R002 | A002 | Injeção SQL | Validação de entrada | 4 | 4 | 16 |
| R003 | A004 | Roubo de credenciais | Sem MFA | 4 | 5 | 20 |

### Passo 3: Determinar Tratamento

| Risco | Tratamento | Controle | Prazo |
|------|-----------|---------|----------|
| R001 | Mitigar | Implementar criptografia AES-256 | 30 dias |
| R002 | Mitigar | Adicionar validação de entrada, WAF | 14 dias |
| R003 | Mitigar | Enforçar MFA para todos admins | 7 dias |

### Passo 4: Verificar Implementação

```bash
python scripts/compliance_checker.py --controls-file implemented_controls.csv
```

**Saída de verificação:**

```
Status de Implementação dos Controles
=============================
Criptografia (A.8.24): IMPLEMENTADO
  - AES-256 em repouso: SIM
  - TLS 1.3 em trânsito: SIM

Controle de Acesso (A.8.5): IMPLEMENTADO
  - MFA habilitado: SIM
  - Contas de admin: 100% de cobertura

Segurança de Aplicação (A.8.26): PARCIAL
  - Validação de entrada: SIM
  - WAF implantado: PENDENTE

Conformidade Geral: 87%
```
