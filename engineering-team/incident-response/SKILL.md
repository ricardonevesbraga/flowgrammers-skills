---
name: "incident-response"
description: "Use quando um incidente de segurança foi detectado ou declarado e precisa de classificação, triagem, determinação de caminho de escalação e coleta de evidências forenses. Cobre classificação SEV1-SEV4, filtragem de falsos positivos, taxonomia de incidentes e ciclo de vida NIST SP 800-61."
author: Ric Neves - Flowgrammers
agents:
  - claude-code
---

# Resposta a Incidentes

Skill de resposta a incidentes para o ciclo de vida completo desde a triagem inicial até a coleta forense, declaração de severidade e roteamento de escalação. Esta skill NÃO cobre caça a ameaças (veja threat-detection) ou mapeamento de conformidade pós-incidente (veja governance/compliance-mapping) — trata de classificar, triar e gerenciar incidentes de segurança declarados.

---

## Sumário

- [Visão Geral](#visão-geral)
- [Ferramenta de Triagem de Incidentes](#ferramenta-de-triagem-de-incidentes)
- [Classificação de Incidentes](#classificação-de-incidentes)
- [Framework de Severidade](#framework-de-severidade)
- [Filtragem de Falsos Positivos](#filtragem-de-falsos-positivos)
- [Coleta de Evidências Forenses](#coleta-de-evidências-forenses)
- [Caminhos de Escalação](#caminhos-de-escalação)
- [Obrigações de Notificação Regulatória](#obrigações-de-notificação-regulatória)
- [Fluxos de Trabalho](#fluxos-de-trabalho)
- [Anti-Padrões](#anti-padrões)
- [Referências Cruzadas](#referências-cruzadas)

---

## Visão Geral

### O que Esta Skill Faz

Esta skill fornece a metodologia e ferramentas para **triagem e resposta a incidentes** — classificando eventos de segurança em incidentes tipificados, pontuando severidade, filtrando falsos positivos, determinando caminhos de escalação e iniciando coleta de evidências forenses sob controles de cadeia de custódia.

### Distinção de Outras Skills de Segurança

| Skill | Foco | Abordagem |
|-------|-------|----------|
| **incident-response** (esta) | Incidentes ativos | Reativa — classificar, escalar, coletar evidências |
| threat-detection | Caça pré-incidente | Proativa — encontrar ameaças antes que os alertas disparem |
| cloud-security | Avaliação de postura de nuvem | Preventiva — IAM, S3, configuração incorreta de rede |
| red-team | Simulação ofensiva | Ofensiva — testar capacidade de detecção e resposta |

### Pré-requisitos

Um evento de segurança deve ser ingerido antes da triagem. Os eventos podem vir de alertas SIEM, detecções EDR, feeds de inteligência de ameaças ou relatórios de usuários. A ferramenta de triagem aceita payloads de eventos JSON; consulte o schema de entrada abaixo.

---

## Ferramenta de Triagem de Incidentes

A ferramenta `incident_triage.py` classifica eventos, verifica falsos positivos, pontua severidade, determina escalação e realiza pré-análise forense.

```bash
# Classificar um evento a partir de arquivo JSON
python3 scripts/incident_triage.py --input event.json --classify --json

# Classificar com filtragem de falsos positivos habilitada
python3 scripts/incident_triage.py --input event.json --classify --false-positive-check --json

# Forçar um nível de severidade para exercícios de tabletop
python3 scripts/incident_triage.py --input event.json --severity sev1 --json

# Ler evento do stdin
echo '{"event_type": "ransomware", "host": "prod-db-01", "raw_payload": {}}' | \
  python3 scripts/incident_triage.py --classify --false-positive-check --json
```

### Schema do Evento de Entrada

```json
{
  "event_type": "ransomware",
  "host": "prod-db-01",
  "user": "svc_backup",
  "source_ip": "10.1.2.3",
  "timestamp": "2024-01-15T14:32:00Z",
  "raw_payload": {}
}
```

### Códigos de Saída

| Código | Significado | Resposta Obrigatória |
|------|---------|-------------------|
| 0 | SEV3/SEV4 ou limpo | Tratamento padrão por ticket |
| 1 | SEV2 — elevado | Chamada de bridge de 1 hora, coordenação assíncrona |
| 2 | SEV1 — crítico | War room imediato de 15 minutos, todos os recursos |

---

## Classificação de Incidentes

Eventos de segurança são classificados em 14 tipos de incidentes. A classificação orienta a severidade padrão, o mapeamento de técnica MITRE e o SLA de resposta.

### Taxonomia de Incidentes

| Tipo de Incidente | Severidade Padrão | Técnica MITRE | SLA de Resposta |
|--------------|-----------------|-----------------|--------------|
| ransomware | SEV1 | T1486 | 15 minutos |
| data_exfiltration | SEV1 | T1048 | 15 minutos |
| apt_intrusion | SEV1 | T1566 | 15 minutos |
| supply_chain_compromise | SEV1 | T1195 | 15 minutos |
| domain_controller_breach | SEV1 | T1078.002 | 15 minutos |
| credential_compromise | SEV2 | T1110 | 1 hora |
| lateral_movement | SEV2 | T1021 | 1 hora |
| malware_infection | SEV2 | T1204 | 1 hora |
| insider_threat | SEV2 | T1078 | 1 hora |
| cloud_account_compromise | SEV2 | T1078.004 | 1 hora |
| unauthorized_access | SEV3 | T1190 | 4 horas |
| policy_violation | SEV3 | N/A | 4 horas |
| phishing_attempt | SEV4 | T1566.001 | 24 horas |
| security_alert | SEV4 | N/A | 24 horas |

### Gatilhos de Escalação de Severidade

Qualquer um dos seguintes re-declara automaticamente uma severidade maior:

| Gatilho | Nova Severidade |
|---------|-------------|
| Nota de ransomware encontrada | SEV1 |
| Exfiltração ativa confirmada | SEV1 |
| CloudTrail ou SIEM desabilitado | SEV1 |
| Acesso ao controlador de domínio confirmado | SEV1 |
| Segundo sistema comprometido | SEV1 |
| Volume de exfiltração excede 1 GB | SEV2 mínimo |
| Conta da alta diretoria acessada | SEV2 mínimo |

---

## Framework de Severidade

### Matriz de Nível de Severidade

| Nível | Nome | Critérios | Skills Invocadas | Caminho de Escalação |
|-------|------|----------|---------------|-----------------|
| SEV1 | Crítico | Ransomware confirmado; exfiltração ativa de PII/PHI (>10K registros); violação do controlador de domínio; evasão de defesa (CloudTrail desabilitado); comprometimento da cadeia de suprimentos | Todas as skills (em paralelo) | Líder do SOC → CISO → CEO → Presidente do Conselho |
| SEV2 | Alto | Acesso não autorizado confirmado a sistemas sensíveis; comprometimento de credenciais com privilégios elevados; movimento lateral confirmado; indicadores de ransomware sem execução confirmada | triagem + contenção + forense | Líder do SOC → CISO |
| SEV3 | Médio | Acesso não autorizado suspeito (não confirmado); malware detectado e contido; comprometimento de conta única (sem escalada de priv) | triagem + contenção | Líder do SOC → Gerente de Segurança |
| SEV4 | Baixo | Alerta de segurança sem impacto confirmado; indicador informacional; violação de política sem risco de dados | apenas triagem | Fila de Analista L3 |

---

## Filtragem de Falsos Positivos

A ferramenta de triagem aplica cinco filtros antes de escalar para prevenir inflação de falsos positivos.

### Tipos de Filtro de Falsos Positivos

| Filtro | Descrição | Padrão de Exemplo |
|--------|-------------|----------------|
| Atividade de agente CI/CD | Agentes de build/deploy conhecidos sinalizados como anomalias | jenkins, github-actions, circleci, gitlab-runner |
| Tag de ambiente de teste | Assets marcados como não-produção | test-, staging-, dev-, sandbox- |
| Padrões de job agendado | Processos em lote esperados acionando alertas | cron, scheduled_task, batch_job, backup_ |
| Identidades na whitelist | Contas de serviço explicitamente aprovadas | svc_monitoring, svc_backup, datadog-agent |
| Atividade de scanner | Scanners de segurança conhecidos e ferramentas de vulnerabilidade | nessus, qualys, rapid7, aws_inspector |

Um falso positivo confirmado suprime a escalação e registra o motivo da supressão para fins de auditoria. Falsos positivos recorrentes da mesma fonte devem ser ajustados na camada de detecção, não filtrados repetidamente na triagem.

---

## Coleta de Evidências Forenses

A coleta de evidências segue o framework de seis fases do DFRWS e o princípio da aquisição volátil primeiro.

### Seis Fases do DFRWS

| Fase | Atividade | Prioridade |
|-------|----------|----------|
| Identificação | Identificar quais evidências existem e onde | Imediata |
| Preservação | Prevenir modificação — bloqueio de escrita, snapshot, retenção legal | Imediata |
| Coleta | Adquirir evidências em ordem de volatilidade | Imediata |
| Exame | Análise técnica das evidências coletadas | Dentro de 2 horas |
| Análise | Interpretar resultados no contexto investigativo | Dentro de 4 horas |
| Apresentação | Produzir relatório de resultados com cadeia de custódia | Antes do fechamento do incidente |

### Evidências Voláteis — Coletar Primeiro

1. Memória ao vivo (dump de RAM) — perdida ao reiniciar
2. Processos em execução e conexões de rede abertas (`netstat`, `ps`)
3. Usuários logados e sessões ativas
4. Uptime do sistema e hora atual (para ancoragem de linha do tempo)
5. Variáveis de ambiente e módulos de kernel carregados

### Requisitos de Cadeia de Custódia

Cada item de evidência deve ser registrado com:
- Hash SHA-256 no momento da aquisição
- Timestamp de aquisição em UTC com offset de fuso horário
- Proveniência da ferramenta (FTK Imager, Volatility, dd, exportação do AWS CloudTrail)
- Identidade do investigador
- Log de transferência (quem teve custódia e quando)

---

## Caminhos de Escalação

### Por Severidade

| Severidade | Contato Imediato | Chamada de Bridge | Notificação Externa |
|----------|------------------|-------------|----------------------|
| SEV1 | Líder do SOC + CISO (15 min) | War room imediato | Jurídico + PR em standby; notificação regulatória conforme tabela de prazos |
| SEV2 | Líder do SOC (30 min assíncrono) | Bridge de 1 hora | Notificação jurídica se PII envolvido |
| SEV3 | Gerente de Segurança (4 horas) | Apenas assíncrono | Nenhum a menos que o escopo se expanda |
| SEV4 | Fila de Analista L3 (24 horas) | Nenhum | Nenhum |

### Por Tipo de Incidente

| Tipo de Incidente | Escalação Primária | Secundária |
|--------------|-------------------|-----------|
| Ransomware / APT | CISO + CEO | Conselho se dados em risco |
| Violação de PII/PHI | Jurídico + CISO | Órgão regulatório (conforme tabela de prazos) |
| Comprometimento de conta de nuvem | Equipe de segurança de nuvem | CISO |
| Ameaça interna | RH + Jurídico + CISO | Aplicação da lei se criminal |
| Cadeia de suprimentos | CISO + Gestão de fornecedores | Conselho |

---

## Obrigações de Notificação Regulatória

O relógio de notificação começa na declaração do incidente, não na conclusão da investigação.

| Framework | Tipo de Incidente | Prazo | Penalidade |
|-----------|--------------|----------|---------|
| LGPD/GDPR (EU 2016/679) | Violação de dados pessoais | 72 horas após descoberta | Até 4% da receita global |
| PCI-DSS v4.0 | Violação de dados de titular de cartão | 24 horas para o adquirente | Multas das bandeiras de cartão |
| ANVISA/LGPD (Lei 13.709/18) | Violação de dados de saúde (dados sensíveis) | Sem atraso injustificado; notificar ANPD | Multa de até R$50M por infração |
| LGPD / CPRA | Violação de PI sensível | Sem atraso injustificado | Aplicação pelo AG; ação privada |
| NIS2 (EU 2022/2555) | Incidente significativo (serviços essenciais) | Aviso antecipado de 24 horas; notificação de 72 horas | Sanções da autoridade nacional |

**Regra operacional:** Se o escopo não estiver claro na declaração, assuma o prazo aplicável mais restritivo e confirme o escopo dentro da primeira janela de resposta.

Referência completa de prazos: `references/regulatory-deadlines.md`

---

## Fluxos de Trabalho

### Fluxo de Trabalho 1: Triagem Rápida (15 Minutos)

Para um único alerta que requer classificação antes da decisão de escalação:

```bash
# 1. Classificar o evento com filtragem de falsos positivos
python3 scripts/incident_triage.py --input alert.json \
  --classify --false-positive-check --json

# 2. Revisar severidade, escalation_path e false_positive_flag na saída
# 3. Se severidade = sev1 ou sev2, acionar o Líder do SOC imediatamente
# 4. Se false_positive_flag = true, documentar e fechar
```

**Decisão**: Código de saída 2 = war room SEV1 agora. Código de saída 1 = chamada de bridge SEV2 em 30 minutos.

### Fluxo de Trabalho 2: Resposta Completa a Incidente (SEV1)

```
T+0   Detecção chega (alerta SIEM, EDR, relatório de usuário)
T+5   Classificar com incident_triage.py --classify --false-positive-check
T+10  Se SEV1: acionar CISO, abrir war room, iniciar relógio regulatório
T+15  Iniciar coleta forense (evidências voláteis primeiro)
T+15  Avaliação de contenção (em paralelo com forense)
T+30  Gate de aprovação humana para qualquer ação de contenção
T+45  Executar contenção aprovada
T+60  Avaliar eficácia da contenção, informar Jurídico se escopo PII/PHI
T+4h  Pacote final de evidências forenses, estimativa de tempo de permanência
T+8h  Plano de erradicação e recuperação
T+72h Submissão de notificação regulatória (se LGPD/NIS2 acionado)
```

```bash
# Classificação completa com contexto forense
python3 scripts/incident_triage.py --input incident.json \
  --classify --false-positive-check --severity sev1 --json > incident_triage_output.json

# Pré-análise forense
python3 scripts/incident_triage.py --input incident.json --json | \
  jq '.forensic_findings, .chain_of_custody_steps'
```

### Fluxo de Trabalho 3: Simulação de Exercício de Tabletop

Simular incidentes em níveis específicos de severidade sem eventos reais:

```bash
# Simular incidente de ransomware SEV1
echo '{"event_type": "ransomware", "host": "prod-db-01", "user": "svc_backup"}' | \
  python3 scripts/incident_triage.py --classify --severity sev1 --json

# Simular comprometimento de credenciais SEV2
echo '{"event_type": "credential_compromise", "user": "admin_user", "source_ip": "203.0.113.5"}' | \
  python3 scripts/incident_triage.py --classify --false-positive-check --json

# Verificar caminhos de escalação para todos os 14 tipos de incidente
for type in ransomware data_exfiltration credential_compromise lateral_movement; do
  echo "{\"event_type\": \"$type\"}" | python3 scripts/incident_triage.py --classify --json
done
```

---

## Anti-Padrões

1. **Iniciar o relógio de notificação na conclusão da investigação** — Os relógios regulatórios (LGPD 72 horas, PCI 24 horas) começam na descoberta, não na conclusão da investigação. Declarar tarde expõe a organização às penalidades máximas mesmo que o incidente em si tenha sido menor.
2. **Conter antes de coletar evidências voláteis** — Reiniciar ou isolar um sistema destrói RAM, processos em execução e conexões ativas. A coleta forense de evidências voláteis deve acontecer em paralelo com a contenção, nunca depois.
3. **Pular a verificação de falsos positivos antes da escalação** — Escalar cada alerta para SEV1 degrada a credibilidade do SOC e causa fadiga de alertas. Sempre execute filtros de falsos positivos antes de acionar o CISO.
4. **Decisões de comando de incidente não documentadas** — Toda decisão tomada durante um SEV1, incluindo decisões tomadas sob incerteza, deve ser registrada na cadeia de evidências com timestamp e justificativa. Decisões não documentadas não podem ser defendidas em investigações regulatórias.
5. **Tratar o fechamento do incidente como conclusão da investigação** — Incidentes são fechados quando a erradicação e recuperação estão completas, não quando a investigação termina. O relatório forense e as submissões regulatórias podem continuar após o fechamento operacional.
6. **Classificação de fonte única** — Classificar um incidente a partir de uma única fonte de dados (um alerta SIEM) sem evidências corroborativas frequentemente leva à classificação incorreta. Colete pelo menos dois sinais independentes antes de declarar SEV1.
7. **Ignorar gates de aprovação humana para contenção** — Ações de contenção automatizadas (isolamento de rede, revogação de credenciais) tomadas sem aprovação humana podem causar interrupções em produção, destruir evidências e criar responsabilidade. A aprovação humana é inegociável para todas as ações de contenção mutantes.

---

## Referências Cruzadas

| Skill | Relação |
|-------|-------------|
| [threat-detection](../threat-detection/SKILL.md) | Resultados confirmados de caça escalam para incident-response para triagem e classificação |
| [cloud-security](../cloud-security/SKILL.md) | Resultados de postura de nuvem (comprometimento de IAM, exposição de S3) podem acionar classificação de incidente |
| [red-team](../red-team/SKILL.md) | Resultados do red team validam cobertura de detecção; lacunas confirmadas tornam-se hipóteses de caça |
| [security-pen-testing](../security-pen-testing/SKILL.md) | Vulnerabilidades de pen test exploradas em produção escalam para incident-response para tratamento de incidente ativo |
