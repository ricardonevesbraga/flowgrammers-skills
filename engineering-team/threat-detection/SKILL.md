---
name: "threat-detection"
description: "Use ao caçar ameaças em um ambiente, analisar IOCs ou detectar anomalias comportamentais em telemetria. Cobre threat hunting orientado a hipóteses, geração de varredura de IOC, detecção de anomalias por z-score e priorização de sinais mapeados ao MITRE ATT&CK."
author: Ric Neves - Flowgrammers
agents:
  - claude-code
---

# Detecção de Ameaças

Skill de detecção de ameaças para descoberta proativa de atividade de atacante por meio de hunting orientado a hipóteses, análise de IOC e detecção estatística de anomalias. Esta skill NÃO é resposta a incidentes (veja incident-response) nem operações de red team (veja red-team) — trata-se de encontrar ameaças que escaparam dos controles automatizados.

---

## Sumário

- [Visão Geral](#visão-geral)
- [Analisador de Sinal de Ameaça](#threat-signal-analyzer)
- [Metodologia de Threat Hunting](#threat-hunting-methodology)
- [Análise de IOC](#ioc-analysis)
- [Detecção de Anomalias](#anomaly-detection)
- [Priorização de Sinal MITRE ATT&CK](#mitre-attck-signal-prioritization)
- [Integração de Decepção e Honeypot](#deception-e-honeypot-integration)
- [Workflows](#workflows)
- [Anti-Padrões](#anti-patterns)
- [Cross-Referências](#cross-referências)

---

## Visão Geral

### O que Esta Skill Faz

Esta skill fornece a metodologia e as ferramentas para **detecção proativa de ameaças** — encontrar atividade de atacante por meio de hipóteses de hunting estruturadas, análise de IOC e detecção estatística de anomalias antes que os alertas disparem.

### Distinção de Outras Skills de Segurança

| Skill | Foco | Abordagem |
|-------|-------|----------|
| **threat-detection** (esta) | Encontrar ameaças ocultas | Proativa — caçar antes dos alertas |
| incident-response | Incidentes ativos | Reativa — conter e investigar incidentes declarados |
| red-team | Simulação ofensiva | Ofensiva — testar defesas pela perspectiva do atacante |
| cloud-security | Configurações incorretas em cloud | Postura — IAM, S3, exposição de rede |

### Pré-requisitos

Acesso de leitura à telemetria SIEM/EDR, logs de endpoint e dados de fluxo de rede. Feeds de IOC requerem atualização dentro de 30 dias para evitar falsos positivos. Hipóteses de hunting devem ser escopadas ao ambiente antes da execução.

---

## Analisador de Sinal de Ameaça

A ferramenta `threat_signal_analyzer.py` suporta três modos: `hunt` (pontuação de hipótese), `ioc` (geração de varredura) e `anomaly` (detecção estatística).

```bash
# Modo hunt: pontuar uma hipótese contra cobertura MITRE ATT&CK
python3 scripts/threat_signal_analyzer.py --mode hunt \
  --hypothesis "Lateral movement via PtH using compromised service account" \
  --actor-relevance 3 --control-gap 2 --data-availability 2 --json

# Modo ioc: gerar alvos de varredura a partir de um arquivo de feed IOC
python3 scripts/threat_signal_analyzer.py --mode ioc \
  --ioc-file iocs.json --json

# Modo anomaly: detectar outliers estatísticos em eventos de telemetria
python3 scripts/threat_signal_analyzer.py --mode anomaly \
  --events-file telemetry.json \
  --baseline-mean 100 --baseline-std 25 --json

# Listar todas as técnicas MITRE ATT&CK suportadas
python3 scripts/threat_signal_analyzer.py --list-techniques
```

### Formato do arquivo IOC

```json
{
  "ips": ["1.2.3.4", "5.6.7.8"],
  "domains": ["malicious.example.com"],
  "hashes": ["abc123def456..."]
}
```

### Formato do arquivo de eventos de telemetria

```json
[
  {"timestamp": "2024-01-15T14:32:00Z", "entity": "host-01", "action": "dns_query", "volume": 450},
  {"timestamp": "2024-01-15T14:33:00Z", "entity": "host-02", "action": "dns_query", "volume": 95}
]
```

### Códigos de saída

| Código | Significado |
|------|---------|
| 0 | Sem achados de alta prioridade |
| 1 | Sinais de prioridade média detectados |
| 2 | Achados confirmados de alta prioridade |

---

## Metodologia de Threat Hunting

O threat hunting estruturado segue um loop de cinco etapas: hipótese → identificação de fonte de dados → execução de query → triagem de achados → feedback para engenharia de detecção.

### Pontuação de Hipótese

| Fator | Peso | Descrição |
|--------|--------|-------------|
| Relevância do ator | ×3 | Com que proximidade esta TTP corresponde a atores de ameaça conhecidos no seu setor? |
| Lacuna de controle | ×2 | Quantos dos seus controles existentes perderiam este comportamento? |
| Disponibilidade de dados | ×1 | Você tem os dados de telemetria necessários para testar esta hipótese? |

Score de prioridade = (actor_relevance × 3) + (control_gap × 2) + (data_availability × 1)

### Hipóteses de Hunt de Alto Valor por Tática

| Hipótese | MITRE ID | Fontes de Dados | Sinal de Prioridade |
|-----------|----------|--------------|-----------------|
| Movimento lateral via WMI por execução remota | T1047 | Logs WMI, telemetria de processo EDR | Processo WMI gerado a partir de WINRM, cadeia pai-filho incomum |
| Execução LOLBin para evasão de defesa | T1218 | Criação de processo, args de linha de comando | certutil.exe, regsvr32.exe, mshta.exe com atividade de rede |
| Beacon C2 via intervalos com jitter | T1071.001 | Logs proxy, logs DNS | Conexões regulares de saída com jitter de ±10% |
| Movimento lateral Pass-the-Hash | T1550.002 | Evento de segurança Windows 4624 tipo 3 | Auth NTLM de host de origem inesperado para share admin |
| Acesso à memória LSASS | T1003.001 | Eventos de acesso à memória EDR | OpenProcess em lsass.exe a partir de processo não-sistema |
| Kerberoasting | T1558.003 | Evento Windows 4769 | Alto volume de requisições TGS para contas de serviço |
| Persistência via tarefa agendada | T1053.005 | Sysmon Event 1/11, Windows 4698 | Tarefa agendada criada em diretório não padrão |

---

## Análise de IOC

A análise de IOC determina se os indicadores são frescos, mapeia-os para alvos de varredura necessários e filtra dados obsoletos que geram falsos positivos.

### Tipos de IOC e Prioridade de Varredura

| Tipo de IOC | Threshold de Obsolescência | Meta de Varredura | Cobertura MITRE |
|---------|--------------------|--------------|----|
| Endereços IP | 30 dias | Logs de firewall, NetFlow, logs proxy | T1071, T1105 |
| Domínios | 30 dias | Logs de resolvedores DNS, logs proxy | T1568, T1583 |
| Hashes de arquivo | 90 dias | Criação de arquivo EDR, logs de AV | T1105, T1027 |
| URLs | 14 dias | Logs de acesso proxy, histórico do navegador | T1566.002 |
| Nomes de mutex | 180 dias | Artefatos de runtime EDR | T1055 |

### Tratamento de Obsolescência de IOC

IOCs mais antigos que seu threshold são sinalizados como `stale` e excluídos da geração de alvos de varredura. Executar varreduras contra IOCs obsoletos infla taxas de falso positivo e reduz a credibilidade do SOC. Atualize feeds de IOC de plataformas de inteligência de ameaças (MISP, OpenCTI, TI comercial) antes de cada ciclo de hunt.

---

## Detecção de Anomalias

A detecção estatística de anomalias identifica comportamento que desvia das baselines estabelecidas sem depender de assinaturas conhecidas como más.

### Thresholds de Z-Score

| Z-Score | Classificação | Resposta |
|---------|---------------|----------|
| < 2,0 | Normal | Nenhuma ação necessária |
| 2,0–2,9 | Anomalia suave | Registrar e monitorar — aumentar amostragem |
| ≥ 3,0 | Anomalia forte | Escalar para analista de hunt — investigar entidade |

### Requisitos de Baseline

A detecção eficaz de anomalias requer pelo menos 14 dias de telemetria histórica para estabelecer uma baseline válida. Baselines devem ser recomputadas após:
- Incidentes de segurança (mudança de comportamento pós-incidente)
- Grandes mudanças de infraestrutura (migrações cloud, novas implantações SaaS)
- Mudanças sazonais de padrão de uso (fim de trimestre, períodos de férias)

### Metas de Anomalia de Alto Valor

| Tipo de Entidade | Métrica | Indicador de Anomalia |
|-------------|--------|--------------------|
| Resolvedor DNS | Queries por hora por host | Beaconing, tunneling, DGA |
| Endpoint | Execuções únicas de processo por dia | Instalação de malware, abuso de LOLBin |
| Conta de serviço | Eventos de auth por hora | Credential stuffing, movimento lateral |
| Gateway de email | Tipos de anexo por hora | Pico de campanha de phishing |
| Cloud IAM | Chamadas de API por identidade por hora | Comprometimento de credencial, exfiltração |

---

## Priorização de Sinal MITRE ATT&CK

Cada hipótese de hunting mapeia para uma ou mais técnicas ATT&CK. Técnicas com múltiplos sinais confirmados no seu ambiente têm prioridade mais alta.

### Matriz de Cobertura de Tática

| Tática | Técnicas Principais | Fonte de Dados Primária |
|--------|---------------|--------------------|-|
| Acesso Inicial | T1190, T1566, T1078 | Logs de acesso web, gateway de email, logs de auth |
| Execução | T1059, T1047, T1218 | Criação de processo, linha de comando, execução de script |
| Persistência | T1053, T1543, T1098 | Tarefas agendadas, serviços, mudanças de conta |
| Evasão de Defesa | T1027, T1562, T1070 | Process hollowing, limpeza de log, codificação |
| Acesso a Credenciais | T1003, T1558, T1110 | LSASS, Kerberos, falhas de auth |
| Movimento Lateral | T1550, T1021, T1534 | Auth NTLM, serviços remotos, spearphish interno |
| Coleta | T1074, T1560, T1114 | Diretórios de staging, criação de arquivo, acesso a email |
| Exfiltração | T1048, T1041, T1567 | Volume de saída incomum, DNS tunneling, armazenamento cloud |
| Comando e Controle | T1071, T1572, T1568 | Beaconing, protocol tunneling, DNS C2 |

---

## Integração de Decepção e Honeypot

Ativos de decepção geram alertas de alta fidelidade — qualquer interação com um honeypot é um sinal inequívoco que requer investigação.

### Tipos de Ativos de Decepção e Posicionamento

| Tipo de Ativo | Posicionamento | Sinal | Técnica ATT&CK |
|-----------|-----------|--------|-----------------|
| Credenciais honeypot em cofre de senhas | Armazenamento de segredos do cofre | Tentativa de acesso a credenciais | T1555 |
| Honey tokens (chaves de acesso AWS falsas) | Repos Git, objetos S3 | Reconhecimento ou exfiltração | T1552.004 |
| Honey files (nomeados: passwords.xlsx) | Compartilhamentos de arquivo, endpoints | Staging de coleta | T1074 |
| Honey accounts (usuários AD dormentes) | Active Directory | Pivô de movimento lateral | T1078.002 |
| Serviços de rede honeypot | DMZ, segmentos de rede plana | Escaneamento de rede, exploração de serviço | T1046, T1190 |

Alertas de honeypot contornam o pipeline de pontuação padrão — qualquer hit é automaticamente SEV2 até prova em contrário.

---

## Workflows

### Workflow 1: Hunt Rápido (30 Minutos)

Para responder a um novo relatório de inteligência de ameaças ou alerta de CVE:

```bash
# 1. Pontuar hipótese contra contexto do ambiente
python3 scripts/threat_signal_analyzer.py --mode hunt \
  --hypothesis "Exploitation of CVE-YYYY-NNNNN in Apache" \
  --actor-relevance 2 --control-gap 3 --data-availability 2 --json

# 2. Construir lista de varredura de IOC a partir de threat intel
echo '{"ips": ["1.2.3.4"], "domains": ["malicious.tld"], "hashes": []}' > iocs.json
python3 scripts/threat_signal_analyzer.py --mode ioc --ioc-file iocs.json --json

# 3. Verificar anomalias na telemetria de servidor web das últimas 24h
python3 scripts/threat_signal_analyzer.py --mode anomaly \
  --events-file web_events_24h.json --baseline-mean 80 --baseline-std 20 --json
```

**Decisão**: Se prioridade de hunt ≥ 7 ou qualquer hit de varredura IOC, escalar para hunt completo.

### Workflow 2: Hunt Completo de Ameaças (Vários Dias)

**Dia 1 — Geração de Hipóteses:**
1. Revisar feeds de inteligência de ameaças para TTPs relevantes ao setor
2. Mapear últimos 30 dias de alertas de segurança para táticas ATT&CK para identificar lacunas
3. Pontuar as 5 principais hipóteses com o modo hunt do threat_signal_analyzer.py
4. Priorizar por score — começar pelo mais alto

**Dia 2 — Coleta de Dados e Execução de Queries:**
1. Puxar telemetria relevante do SIEM (intervalo de datas: últimos 14 dias)
2. Executar detecção de anomalias nas baselines de entidade
3. Executar varreduras de IOC para todos os feeds frescos dentro de 30 dias
4. Revisar playbooks de hunt em `references/hunt-playbooks.md`

**Dia 3 — Triagem e Relatórios:**
1. Triar todos os achados de anomalia — confirmar ou descartar
2. Escalar atividade confirmada para incident-response
3. Documentar novas regras de detecção a partir dos achados do hunt
4. Enviar IOCs falso-positivos de volta ao provedor de TI

### Workflow 3: Monitoramento Contínuo (Automatizado)

Configure detecção de anomalias recorrente contra baselines de entidades-chave em cadência de 6 horas:

```bash
# Executar como cron job a cada 6 horas — auto-escalar no código de saída 2
python3 scripts/threat_signal_analyzer.py --mode anomaly \
  --events-file /var/log/telemetry/events_6h.json \
  --baseline-mean "${BASELINE_MEAN}" \
  --baseline-std "${BASELINE_STD}" \
  --json > /var/log/threat-detection/$(date +%Y%m%d_%H%M%S).json

# Alertar no código de saída 2 (anomalia forte)
if [ $? -eq 2 ]; then
  send_alert "Anomalia forte detectada — threat_signal_analyzer"
fi
```

---

## Anti-Padrões

1. **Caçar sem hipótese** — Executar queries amplas em toda a telemetria sem uma questão focada gera ruído, não sinal. Todo hunt deve começar com uma hipótese testável escopada para uma ou duas técnicas ATT&CK.
2. **Usar IOCs obsoletos** — IOCs com mais de 30 dias geram falsos positivos que treinam analistas a ignorar alertas. Sempre verifique a atualidade dos IOCs antes de varrer; exclua indicadores obsoletos de varreduras automatizadas.
3. **Pular estabelecimento de baseline** — Detecção de anomalias sem uma baseline válida produz alertas em dias normais de alto volume. Exija 14+ dias de dados de baseline antes de habilitar alertas estatísticos em qualquer tipo de entidade.
4. **Caçar apenas técnicas conhecidas** — Caçar exclusivamente contra técnicas ATT&CK documentadas perde comportamento adversário novo. Inclua regularmente análise de anomalias em aberto que pode identificar TTPs desconhecidas.
5. **Não fechar o loop de feedback para engenharia de detecção** — Achados de hunt que confirmam atividade maliciosa devem produzir novas regras de detecção. Hunting que não melhora a cobertura de detecção não tem valor duradouro.
6. **Tratar toda anomalia como ameaça confirmada** — Scores z altos indicam desvio da baseline, não malícia confirmada. Todas as anomalias requerem triagem humana para confirmar ou descartar antes da escalação.
7. **Ignorar alertas de honeypot** — Qualquer interação com um ativo de decepção é um sinal de alta fidelidade. Tratar alertas de honeypot como ruído invalida todo o investimento em decepção.

---

## Cross-Referências

| Skill | Relação |
|-------|-------------|
| [incident-response](../incident-response/SKILL.md) | Ameaças confirmadas pelo hunting são escaladas para incident-response para triagem e contenção |
| [red-team](../red-team/SKILL.md) | Exercícios de red team geram TTPs realistas que informam a priorização de hipóteses de hunt |
| [cloud-security](../cloud-security/SKILL.md) | Achados de postura cloud (S3 aberto, wildcards IAM) criam alvos de hunting para TTPs de exfiltração de dados |
| [security-pen-testing](../security-pen-testing/SKILL.md) | Achados de pen test identificam superfícies de ataque que o threat hunting deve monitorar pós-remediação |
