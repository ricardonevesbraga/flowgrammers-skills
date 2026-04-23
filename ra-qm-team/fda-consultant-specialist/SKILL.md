---
name: "fda-consultant-specialist"
description: Consultor regulatório FDA para empresas de dispositivos médicos. Fornece orientação sobre vias 510(k)/PMA/De Novo, conformidade QSR (21 CFR 820), avaliações HIPAA e cibersegurança de dispositivos. Use quando o usuário mencionar submissão FDA, 510(k), PMA, De Novo, QSR, pré-mercado, dispositivo predicado, equivalência substancial, HIPAA para dispositivos médicos ou cibersegurança FDA.
---

# FDA Consultant Specialist

Consultoria regulatória FDA para fabricantes de dispositivos médicos, cobrindo vias de submissão, Regulação do Sistema da Qualidade (QSR), conformidade HIPAA e requisitos de cibersegurança de dispositivos.

## Sumário

- [Seleção de Via FDA](#seleção-de-via-fda)
- [Processo de Submissão 510(k)](#processo-de-submissão-510k)
- [Conformidade QSR](#conformidade-qsr)
- [HIPAA para Dispositivos Médicos](#hipaa-para-dispositivos-médicos)
- [Cibersegurança de Dispositivos](#cibersegurança-de-dispositivos)
- [Recursos](#recursos)

---

## Seleção de Via FDA

Determinar a via regulatória FDA adequada com base na classificação do dispositivo e disponibilidade de predicado.

### Framework de Decisão

```
Dispositivo predicado existe?
├── SIM → Substancialmente equivalente?
│   ├── SIM → Via 510(k)
│   │   ├── Sem mudanças de projeto → 510(k) Abreviado
│   │   ├── Apenas fabricação → 510(k) Especial
│   │   └── Projeto/desempenho → 510(k) Tradicional
│   └── NÃO → PMA ou De Novo
└── NÃO → Dispositivo inovador?
    ├── Risco baixo a moderado → De Novo
    └── Alto risco (Classe III) → PMA
```

### Comparação de Vias

| Via | Quando Usar | Prazo | Custo |
|---------|-------------|----------|------|
| 510(k) Tradicional | Predicado existe, mudanças de projeto | 90 dias | $21.760 |
| 510(k) Especial | Apenas mudanças de fabricação | 30 dias | $21.760 |
| 510(k) Abreviado | Conformidade com orientação/padrão | 30 dias | $21.760 |
| De Novo | Inovador, risco baixo-moderado | 150 dias | $134.676 |
| PMA | Classe III, sem predicado | 180+ dias | $425.000+ |

### Estratégia de Pré-Submissão

1. Identificar código de produto e classificação
2. Pesquisar banco de dados 510(k) por predicados
3. Avaliar viabilidade de equivalência substancial
4. Preparar perguntas Q-Sub para FDA
5. Agendar reunião Pré-Sub se necessário

**Referência:** Veja [fda_submission_guide.md](references/fda_submission_guide.md) para matrizes de decisão de via e requisitos de submissão.

---

## Processo de Submissão 510(k)

### Fluxo de Trabalho

```
Fase 1: Planejamento
├── Passo 1: Identificar dispositivo(s) predicado(s)
├── Passo 2: Comparar uso pretendido e tecnologia
├── Passo 3: Determinar requisitos de teste
└── Checkpoint: Argumento de ES viável?

Fase 2: Preparação
├── Passo 4: Completar testes de desempenho
├── Passo 5: Preparar descrição do dispositivo
├── Passo 6: Documentar comparação de ES
├── Passo 7: Finalizar rotulagem
└── Checkpoint: Todas as seções obrigatórias completas?

Fase 3: Submissão
├── Passo 8: Montar pacote de submissão
├── Passo 9: Submeter via eSTAR
├── Passo 10: Rastrear confirmação de recebimento
└── Checkpoint: Submissão aceita?

Fase 4: Revisão
├── Passo 11: Monitorar status de revisão
├── Passo 12: Responder a solicitações de AI
├── Passo 13: Receber decisão
└── Verificação: Carta de ES recebida?
```

### Seções Obrigatórias (21 CFR 807.87)

| Seção | Conteúdo |
|---------|---------|
| Carta de Apresentação | Tipo de submissão, ID do dispositivo, informações de contato |
| Formulário 3514 | Folha de rosto de revisão pré-mercado CDRH |
| Descrição do Dispositivo | Descrição física, princípios de operação |
| Indicações de Uso | Formulário 3881, população de pacientes, ambiente de uso |
| Comparação de ES | Comparação lado a lado com o predicado |
| Testes de Desempenho | Bancada, biocompatibilidade, segurança elétrica |
| Documentação de Software | Nível de preocupação, análise de perigos (IEC 62304) |
| Rotulagem | IFU, etiquetas de embalagem, advertências |
| Resumo 510(k) | Resumo público da submissão |

### Problemas Comuns de RTA

| Problema | Prevenção |
|-------|------------|
| Taxa de usuário ausente | Verificar pagamento antes da submissão |
| Formulário 3514 incompleto | Revisar todos os campos, garantir assinatura |
| Nenhum predicado identificado | Confirmar número K no banco de dados FDA |
| Comparação de ES inadequada | Tratar todas as características tecnológicas |

---

## Conformidade QSR

Requisitos da Regulação do Sistema da Qualidade (21 CFR Part 820) para fabricantes de dispositivos médicos.

### Subsistemas-Chave

| Seção | Título | Foco |
|---------|-------|-------|
| 820.20 | Responsabilidade Gerencial | Política da qualidade, estrutura org., revisão gerencial |
| 820.30 | Controles de Projeto | Entrada, saída, revisão, verificação, validação |
| 820.40 | Controles de Documentos | Aprovação, distribuição, controle de mudanças |
| 820.50 | Controles de Compras | Qualificação de fornecedores, dados de compra |
| 820.70 | Controles de Produção | Validação de processo, controles ambientais |
| 820.100 | CAPA | Análise de causa raiz, ações corretivas |
| 820.181 | Registro Mestre do Dispositivo | Especificações, procedimentos, critérios de aceitação |

### Fluxo de Trabalho de Controles de Projeto (820.30)

```
Passo 1: Entrada de Projeto
└── Capturar necessidades do usuário, uso pretendido, requisitos regulatórios
    Verificação: Entradas revisadas e aprovadas?

Passo 2: Saída de Projeto
└── Criar especificações, desenhos, arquitetura de software
    Verificação: Saídas rastreáveis às entradas?

Passo 3: Revisão de Projeto
└── Conduzir revisões em cada marco de fase
    Verificação: Registros de revisão com assinaturas?

Passo 4: Verificação de Projeto
└── Realizar testes em relação às especificações
    Verificação: Todos os testes atendem aos critérios de aceitação?

Passo 5: Validação de Projeto
└── Confirmar que o dispositivo atende às necessidades do usuário em condições reais de uso
    Verificação: Relatório de validação aprovado?

Passo 6: Transferência de Projeto
└── Liberar para produção com DMR completo
    Verificação: Lista de verificação de transferência completa?
```

### Processo CAPA (820.100)

1. **Identificar**: Documentar não conformidade ou problema potencial
2. **Investigar**: Realizar análise de causa raiz (5 Porquês, Ishikawa)
3. **Planejar**: Definir ações corretivas/preventivas
4. **Implementar**: Executar ações, atualizar documentação
5. **Verificar**: Confirmar implementação completa
6. **Eficácia**: Monitorar recorrência (30-90 dias)
7. **Encerrar**: Aprovação gerencial e encerramento

**Referência:** Veja [qsr_compliance_requirements.md](references/qsr_compliance_requirements.md) para orientação detalhada de implementação QSR.

---

## HIPAA para Dispositivos Médicos

Requisitos HIPAA para dispositivos que criam, armazenam, transmitem ou acessam Informações de Saúde Protegidas (PHI).

### Aplicabilidade

| Tipo de Dispositivo | HIPAA Aplicável |
|-------------|---------------|
| Diagnóstico isolado (sem transmissão de dados) | Não |
| Dispositivo conectado transmitindo dados do paciente | Sim |
| Dispositivo com integração EHR | Sim |
| SaMD armazenando informações do paciente | Sim |
| App de bem-estar (sem diagnóstico) | Apenas se armazenar PHI |

### Salvaguardas Obrigatórias

```
Administrativas (§164.308)
├── Designação de oficial de segurança
├── Análise e gestão de riscos
├── Treinamento de pessoal
├── Procedimentos de resposta a incidentes
└── Acordos de associado de negócios

Físicas (§164.310)
├── Controles de acesso às instalações
├── Segurança de estação de trabalho
└── Procedimentos de descarte de dispositivos

Técnicas (§164.312)
├── Controle de acesso (IDs únicos, logoff automático)
├── Controles de auditoria (registro de logs)
├── Controles de integridade (checksums, hashes)
├── Autenticação (MFA recomendado)
└── Segurança de transmissão (TLS 1.2+)
```

### Etapas de Avaliação de Risco

1. Inventariar todos os sistemas que tratam ePHI
2. Documentar fluxos de dados (coleta, armazenamento, transmissão)
3. Identificar ameaças e vulnerabilidades
4. Avaliar probabilidade e impacto
5. Determinar níveis de risco
6. Implementar controles
7. Documentar risco residual

**Referência:** Veja [hipaa_compliance_framework.md](references/hipaa_compliance_framework.md) para listas de verificação de implementação e templates de BAA.

---

## Cibersegurança de Dispositivos

Requisitos de cibersegurança FDA para dispositivos médicos conectados.

### Requisitos de Pré-Mercado

| Elemento | Descrição |
|---------|-------------|
| Modelo de Ameaças | Análise STRIDE, árvores de ataque, fronteiras de confiança |
| Controles de Segurança | Autenticação, criptografia, controle de acesso |
| SBOM | Software Bill of Materials (CycloneDX ou SPDX) |
| Testes de Segurança | Teste de penetração, varredura de vulnerabilidades |
| Plano de Vulnerabilidades | Processo de divulgação, gestão de patches |

### Classificação de Nível do Dispositivo

**Nível 1 (Risco Maior):**
- Conecta-se à rede/internet
- Incidente de cibersegurança poderia causar dano ao paciente

**Nível 2 (Risco Padrão):**
- Todos os outros dispositivos conectados

### Obrigações Pós-Mercado

1. Monitorar NVD e ICS-CERT por vulnerabilidades
2. Avaliar aplicabilidade aos componentes do dispositivo
3. Desenvolver e testar patches
4. Comunicar com clientes
5. Reportar à FDA conforme orientação

### Divulgação Coordenada de Vulnerabilidades

```
Relatório do Pesquisador
    ↓
Reconhecimento (48 horas)
    ↓
Avaliação Inicial (5 dias)
    ↓
Desenvolvimento de Correção
    ↓
Divulgação Pública Coordenada
```

**Referência:** Veja [device_cybersecurity_guidance.md](references/device_cybersecurity_guidance.md) para exemplos de formato SBOM e templates de modelagem de ameaças.

---

## Recursos

### scripts/

| Script | Propósito |
|--------|---------|
| `fda_submission_tracker.py` | Rastrear marcos e cronogramas de submissão 510(k)/PMA/De Novo |
| `qsr_compliance_checker.py` | Avaliar conformidade 21 CFR 820 em relação à documentação do projeto |
| `hipaa_risk_assessment.py` | Avaliar salvaguardas HIPAA em software de dispositivos médicos |

### references/

| Arquivo | Conteúdo |
|------|---------|
| `fda_submission_guide.md` | Requisitos de submissão 510(k), De Novo, PMA e listas de verificação |
| `qsr_compliance_requirements.md` | Guia de implementação 21 CFR 820 com templates |
| `hipaa_compliance_framework.md` | Salvaguardas da Regra de Segurança HIPAA e requisitos de BAA |
| `device_cybersecurity_guidance.md` | Requisitos de cibersegurança FDA, SBOM, modelagem de ameaças |
| `fda_capa_requirements.md` | Processo CAPA, análise de causa raiz, verificação de eficácia |

### Exemplos de Uso

```bash
# Rastrear status de submissão FDA
python scripts/fda_submission_tracker.py /path/to/project --type 510k

# Avaliar conformidade QSR
python scripts/qsr_compliance_checker.py /path/to/project --section 820.30

# Executar avaliação de risco HIPAA
python scripts/hipaa_risk_assessment.py /path/to/project --category technical
```
