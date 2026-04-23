---
name: "red-team"
description: "Use quando planejar ou executar engajamentos de red team autorizados, análise de caminho de ataque ou simulações de segurança ofensiva. Cobre planejamento de kill-chain com MITRE ATT&CK, pontuação de técnicas, identificação de pontos críticos, avaliação de risco OPSEC e identificação de alvos de alto valor."
author: Ric Neves - Flowgrammers
agents:
  - claude-code
---

# Red Team

Skill de planejamento de engajamento de red team e análise de caminho de ataque para simulações de segurança ofensiva autorizadas. Isto NÃO é varredura de vulnerabilidades (veja security-pen-testing) ou resposta a incidentes (veja incidente-response) — trata-se de simulação adversária estruturada para testar detecção, resposta e eficácia dos controles.

---

## Sumário

- [Visão Geral](#visão-geral)
- [Ferramenta de Planejamento de Engajamento](#ferramenta-de-planejamento-de-engajamento)
- [Metodologia de Fases da Kill-Chain](#metodologia-de-fases-da-kill-chain)
- [Pontuação e Priorização de Técnicas](#pontuação-e-priorização-de-técnicas)
- [Análise de Pontos Críticos](#análise-de-pontos-críticos)
- [Avaliação de Risco OPSEC](#avaliação-de-risco-opsec)
- [Identificação de Alvos de Alto Valor](#identificação-de-alvos-de-alto-valor)
- [Metodologia de Caminho de Ataque](#metodologia-de-caminho-de-ataque)
- [Fluxos de Trabalho](#fluxos-de-trabalho)
- [Anti-Padrões](#anti-padrões)
- [Referências Cruzadas](#referências-cruzadas)

---

## Visão Geral

### O que esta Skill Faz

Esta skill fornece a metodologia e as ferramentas para **planejamento de engajamento de red team** — construção de planos de ataque estruturados a partir da seleção de técnicas MITRE ATT&CK, nível de acesso e alvos de alto valor. Ela pontua técnicas por esforço e risco de detecção, monta fases de kill-chain, identifica pontos críticos e sinaliza riscos OPSEC.

### Distinção de Outras Skills de Segurança

| Skill | Foco | Abordagem |
|-------|-------|----------|
| **red-team** (esta) | Simulação adversária | Ofensiva — planejamento e execução de ataques estruturados |
| security-pen-testing | Descoberta de vulnerabilidades | Ofensiva — exploração sistemática de fraquezas específicas |
| threat-detection | Encontrar atividade de atacante | Proativa — detectar TTPs na telemetria |
| incidente-response | Gestão de incidentes ativos | Reativa — conter e investigar incidentes confirmados |

### Requisito de Autorização

**Todas as atividades de red team descritas aqui exigem autorização por escrito.** Isso inclui um documento de Regras de Engajamento (RoE) assinado, escopo definido e aprovação executiva explícita. A ferramenta `engagement_planner.py` não gerará saída sem o flag `--authorized`. O uso não autorizado dessas técnicas é ilegal sob o CFAA, Computer Misuse Act e legislações equivalentes em todo o mundo.

---

## Ferramenta de Planejamento de Engajamento

A ferramenta `engagement_planner.py` constrói um plano de ataque pontuado e ordenado por kill-chain a partir da seleção de técnicas, nível de acesso e alvos de alto valor.

```bash
# Plano básico — acesso externo, técnicas específicas
python3 scripts/engagement_planner.py \
  --techniques T1059,T1078,T1003 \
  --access-level external \
  --authorized --json

# Acesso à rede interna com identificação de alvos de alto valor
python3 scripts/engagement_planner.py \
  --techniques T1059,T1078,T1021,T1550,T1003 \
  --access-level internal \
  --crown-jewels "Database,Active Directory,Payment Systems" \
  --authorized --json

# Cenário com credenciais (assumed breach) em escala
python3 scripts/engagement_planner.py \
  --techniques T1059,T1078,T1021,T1550,T1003,T1486,T1048 \
  --access-level credentialed \
  --crown-jewels "Domain Controller,S3 Data Lake" \
  --target-count 50 \
  --authorized --json

# Listar todas as 29 técnicas MITRE ATT&CK suportadas
python3 scripts/engagement_planner.py --list-techniques
```

### Definições de Nível de Acesso

| Nível | Posição Inicial | Técnicas Disponíveis |
|-------|-----------------|----------------------|
| external | Sem acesso interno — apenas internet | Técnicas voltadas ao exterior (T1190, T1566, etc.) |
| internal | Ponto de apoio na rede — sem credenciais | Reconhecimento interno + preparação para movimento lateral |
| credentialed | Credenciais válidas obtidas | Kill-chain completa incluindo escalonamento de privilégio, movimento lateral, impacto |

### Códigos de Saída

| Código | Significado |
|--------|-------------|
| 0 | Plano de engajamento gerado com sucesso |
| 1 | Autorização ausente ou técnica inválida |
| 2 | Violação de escopo — técnica fora das restrições do nível de acesso |

---

## Metodologia de Fases da Kill-Chain

O planejador de engajamento organiza técnicas em oito fases da kill-chain e ordena o plano de execução conforme.

### Ordem das Fases da Kill-Chain

| Fase | Ordem | Tática MITRE | Exemplos |
|-------|-------|--------------|----------|
| Reconhecimento | 1 | TA0043 | T1595, T1596, T1598 |
| Desenvolvimento de Recursos | 2 | TA0042 | T1583, T1588 |
| Acesso Inicial | 3 | TA0001 | T1190, T1566, T1078 |
| Execução | 4 | TA0002 | T1059, T1047, T1204 |
| Persistência | 5 | TA0003 | T1053, T1543, T1136 |
| Escalonamento de Privilégio | 6 | TA0004 | T1055, T1548, T1134 |
| Acesso a Credenciais | 7 | TA0006 | T1003, T1110, T1558 |
| Movimento Lateral | 8 | TA0008 | T1021, T1550, T1534 |
| Coleta | 9 | TA0009 | T1074, T1560, T1114 |
| Exfiltração | 10 | TA0010 | T1048, T1041, T1567 |
| Impacto | 11 | TA0040 | T1486, T1491, T1498 |

### Princípios de Execução por Fase

Cada fase deve ser concluída antes de avançar para a próxima, a menos que o escopo do engajamento especifique assumed breach (pular para uma fase posterior). Não pule a persistência antes de tentar movimento lateral — a persistência garante continuidade operacional caso um único ponto de apoio seja detectado e removido.

---

## Pontuação e Priorização de Técnicas

As técnicas são pontuadas por esforço (dificuldade de executar sem detecção) e priorizadas no plano de engajamento.

### Fórmula de Pontuação de Esforço

```
effort_score = detection_risk × (len(prerequisites) + 1)
```

Menor pontuação de esforço = mais fácil executar sem acionar detecção.

### Referência de Pontuação de Técnicas

| Técnica | Risco de Detecção | Pré-requisitos | Pontuação de Esforço | MITRE ID |
|-----------|---------------|---------------|-------------|---------|
| Execução via PowerShell | 0.7 | initial_access | 1.4 | T1059.001 |
| Persistência via tarefa agendada | 0.5 | execution | 1.0 | T1053.005 |
| Pass-the-Hash | 0.6 | credential_access, internal_network | 1.8 | T1550.002 |
| Dump de credenciais LSASS | 0.8 | local_admin | 1.6 | T1003.001 |
| Link de spearphishing | 0.4 | none | 0.4 | T1566.001 |
| Implantação de ransomware | 0.9 | persistence, lateral_movement | 2.7 | T1486 |

---

## Análise de Pontos Críticos

Pontos críticos são técnicas exigidas por múltiplos caminhos até os ativos de alto valor. Detectar uma técnica de ponto crítico detecta todos os caminhos de ataque que passam por ela.

### Identificação de Pontos Críticos

O planejador de engajamento identifica pontos críticos encontrando técnicas nas táticas `credential_access` e `privilege_escalation` que servem como pré-requisitos para múltiplas técnicas subsequentes visando alvos de alto valor.

Priorize o desenvolvimento de regras de detecção e a densidade de monitoramento em torno das técnicas de ponto crítico — fortalecer um ponto crítico tem valor defensivo multiplicado.

### Pontos Críticos Comuns por Ambiente

| Tipo de Ambiente | Pontos Críticos Comuns | Prioridade de Detecção |
|-----------------|--------------------|--------------------|
| Domínio Active Directory | T1003 (dump de credenciais), T1558 (Kerberoasting) | Mais alta |
| Ambiente AWS | T1078.004 (conta cloud), cadeias iam:PassRole | Mais alta |
| Cloud híbrida | T1550.002 (PtH), T1021.006 (WinRM) | Alta |
| Aplicações em containers | T1610 (deploy container), T1611 (escape de container) | Alta |

Metodologia completa: `references/attack-path-methodology.md`

---

## Avaliação de Risco OPSEC

Itens de risco OPSEC identificam ações que provavelmente acionarão detecção ou deixarão artefatos persistentes.

### Categorias de Risco OPSEC

| Tática | Principal Risco OPSEC | Mitigação |
|--------|------------------|------------|
| Acesso a Credenciais | Acesso à memória LSASS aciona EDR | Use técnicas sem LSASS (DCSync, Kerberoasting) quando possível |
| Execução | Registro de linha de comando PowerShell | Use bypass AMSI ou métodos alternativos de execução dentro do escopo |
| Movimento Lateral | Movimento lateral via NTLM gera evento 4624 tipo 3 | Use Kerberos quando possível; evite NTLM pela rede |
| Persistência | Tarefas agendadas geram evento 4698 | Use mecanismos de persistência menos monitorados dentro do escopo |
| Exfiltração | Grandes transferências de saída acionam DLP | Prepare os dados e use exfiltração lenta se furtividade for necessária |

### Checklist OPSEC Antes de Cada Fase

1. A técnica está dentro do escopo conforme o RoE?
2. Ela gerará logs que o blue team monitora ativamente?
3. Existe uma alternativa menos detectável que atinge o mesmo objetivo?
4. Se detectada, revelará toda a operação ou apenas o ponto de apoio atual?
5. Os artefatos de limpeza estão definidos para remoção pós-exercício?

---

## Identificação de Alvos de Alto Valor

Os ativos de alto valor são os alvos de grande valor que definem os critérios de sucesso de um engajamento de red team.

### Classificação de Alvos de Alto Valor

| Tipo de Alvo | Indicadores | Caminhos de Ataque |
|-----------------|------------------|--------------|
| Controlador de Domínio | AD DS, NTDS.dit, SYSVOL | Kerberoasting → DCSync → Golden Ticket |
| Servidores de banco de dados | SQL de produção, NoSQL, data warehouse | Movimento lateral → conta DBA → staging de dados |
| Sistemas de pagamento | Rede com escopo PCI, cofre de dados de cartão | Pivô de rede → conta de serviço → exfiltração |
| Repositórios de código-fonte | Git interno, sistemas de build | VPN → git interno → chaves de assinatura de código |
| Plano de gerenciamento cloud | Console AWS, IAM admin | Phishing → credencial → cadeia AssumeRole |

A definição do alvo de alto valor é acordada no RoE — o sucesso do engajamento é medido por se o red team alcança os alvos definidos, não pelo número de vulnerabilidades encontradas.

---

## Metodologia de Caminho de Ataque

A análise de caminho de ataque identifica todas as rotas viáveis do nível de acesso inicial até cada alvo de alto valor.

### Pontuação de Caminho

Cada caminho é pontuado por:
- **Pontuação total de esforço** (soma das pontuações de esforço por técnica)
- **Contagem de pontos críticos** (quantos pontos críticos o caminho atravessa)
- **Probabilidade de detecção** (produto dos riscos de detecção por técnica)

Menor esforço + menos pontos críticos = caminho de menor resistência para o atacante.

### Construção do Grafo de Caminho de Ataque

```
external
  └─ T1566.001 (spearphishing) → initial_access
       └─ T1059.001 (PowerShell) → execution
            └─ T1003.001 (dump LSASS) → credential_access [PONTO CRÍTICO]
                 └─ T1550.002 (Pass-the-Hash) → lateral_movement
                      └─ T1078.002 (conta de domínio) → privilege_escalation
                           └─ Alvo de Alto Valor: Controlador de Domínio
```

Para o algoritmo completo de pontuação, ponderação de pontos críticos e matriz esforço-vs-impacto, consulte `references/attack-path-methodology.md`.

---

## Fluxos de Trabalho

### Fluxo de Trabalho 1: Escopo Rápido de Engajamento (30 Minutos)

Para escopar um exercício de red team focado em um alvo específico:

```bash
# 1. Gerar lista inicial de técnicas a partir de lacunas de cobertura da kill-chain
python3 scripts/engagement_planner.py --list-techniques

# 2. Construir plano para cenário externo sem acesso
python3 scripts/engagement_planner.py \
  --techniques T1566,T1190,T1059,T1003,T1021 \
  --access-level external \
  --crown-jewels "Database Server" \
  --authorized --json

# 3. Revisar choke_points e opsec_risks na saída
# 4. Apresentar fases da kill-chain aos stakeholders para aprovação do escopo
```

**Decisão**: Se choke_points já estão cobertos por regras de detecção, foque nas lacunas. Se não, esses são os alvos de maior valor para o exercício.

### Fluxo de Trabalho 2: Engajamento Completo de Red Team (Múltiplas Semanas)

**Semana 1 — Planejamento:**
1. Definir alvos de alto valor e critérios de sucesso com stakeholders
2. Assinar RoE com escopo definido, cronograma e exclusões fora do escopo
3. Construir plano de engajamento com engagement_planner.py
4. Revisar riscos OPSEC para cada fase

**Semana 2 — Execução (Fase Externa):**
1. Reconhecimento e perfilagem do alvo
2. Tentativas de acesso inicial (phishing, exploração de serviços expostos)
3. Documentar cada técnica executada com timestamps
4. Registrar todos os eventos de detecção para validar a cobertura do blue team

**Semana 3 — Execução (Fase Interna):**
1. Estabelecer persistência se o acesso inicial for obtido
2. Executar técnicas de acesso a credenciais (pontos críticos)
3. Movimento lateral em direção aos alvos de alto valor
4. Documentar quando e como os alvos de alto valor foram alcançados

**Semana 4 — Relatório:**
1. Compilar achados — técnicas executadas, taxas de detecção, alvos alcançados
2. Mapear achados para lacunas de detecção
3. Produzir recomendações de remediação priorizadas por impacto nos pontos críticos
4. Entregar apresentação para a liderança de segurança

### Fluxo de Trabalho 3: Tabletop de Assumed Breach

Simular um cenário de credencial comprometida para teste rápido de detecção:

```bash
# Assumed breach — posição inicial com acesso credenciado
python3 scripts/engagement_planner.py \
  --techniques T1059,T1078,T1021,T1550,T1003,T1048 \
  --access-level credentialed \
  --crown-jewels "Active Directory,S3 Data Bucket" \
  --target-count 20 \
  --authorized --json | jq '.phases, .choke_points, .opsec_risks'

# Executar em múltiplos níveis de acesso para comparar opções de caminho
for level in external internal credentialed; do
  echo "=== ${level} ==="
  python3 scripts/engagement_planner.py \
    --techniques T1059,T1078,T1003,T1021 \
    --access-level "${level}" \
    --authorized --json | jq '.total_effort_score, .phases | keys'
done
```

---

## Anti-Padrões

1. **Operar sem autorização por escrito** — Atividade de red team não autorizada contra qualquer sistema que você não possui ou não tem permissão explícita para testar é crime. O flag `--authorized` deve refletir um RoE real e assinado, não apenas executar a ferramenta para contornar a verificação. A autorização deve anteceder a execução.
2. **Pular a ordem das fases da kill-chain** — Ir diretamente para o movimento lateral sem estabelecer persistência significa que uma única detecção elimina todo o ponto de apoio. Siga a ordem das fases da kill-chain — cada fase constrói a base para a próxima.
3. **Não definir alvos de alto valor antes de começar** — Engajamentos sem critérios de sucesso definidos derivam para caça aberta a vulnerabilidades. Os alvos de alto valor e as condições de sucesso devem ser acordados no RoE antes que a primeira técnica seja executada.
4. **Ignorar os riscos OPSEC no plano** — Exercícios de red team testam a detecção do blue team. Evitar deliberadamente todas as técnicas detectáveis produz um engajamento irreal que não valida a cobertura de detecção. Use riscos OPSEC para entender a exposição à detecção, não para evitá-la completamente.
5. **Não documentar técnicas executadas em tempo real** — A documentação retroativa do que foi executado é não confiável. Registre cada técnica, timestamp e resultado conforme acontece. O relatório pós-engajamento deve ser baseado em registros contemporâneos.
6. **Não limpar artefatos após o exercício** — Mecanismos de persistência, novas contas, configurações modificadas e dados preparados devem ser removidos após a conclusão do engajamento. Deixar artefatos de red team cria riscos de segurança permanentes e pode ser confundido com atividade real de atacante.
7. **Tratar o caminho de menor resistência como o único caminho** — Atacantes se adaptam. Teste múltiplos caminhos de ataque incluindo rotas de maior esforço que podem evadir a detecção. Validar que o caminho mais fácil é detectado é necessário mas não suficiente.

---

## Referências Cruzadas

| Skill | Relação |
|-------|-------------|
| [threat-detection](../threat-detection/SKILL.md) | A execução de técnicas do red team gera TTPs realistas que validam hipóteses de threat hunting |
| [incidente-response](../incidente-response/SKILL.md) | Atividade de red team deve acionar procedimentos de resposta a incidentes — qualidade de detecção e resposta é uma métrica primária de sucesso |
| [cloud-security](../cloud-security/SKILL.md) | Achados de postura cloud (IAM mal configurado, exposição S3) se tornam alvos de caminho de ataque do red team |
| [security-pen-testing](../security-pen-testing/SKILL.md) | Pen testing foca na exploração de vulnerabilidades específicas; red team foca na simulação completa de kill-chain até os alvos de alto valor |
