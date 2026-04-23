---
name: "gdpr-dsgvo-expert"
description: Automação de conformidade com LGPD (Lei 13.709/2018), GDPR e DSGVO alemã. Escaneia bases de código em busca de riscos de privacidade, gera documentação DPIA, rastreia solicitações de direitos dos titulares de dados. Use para avaliações de conformidade LGPD/GDPR, auditorias de privacidade, planejamento de proteção de dados, geração de DPIA e gestão de direitos dos titulares de dados — com foco no mercado brasileiro.
---

# LGPD/GDPR/DSGVO Expert

Ferramentas e orientações para conformidade com a Lei Geral de Proteção de Dados (LGPD — Lei 13.709/2018), o Regulamento Geral de Proteção de Dados da UE (GDPR) e a lei alemã Bundesdatenschutzgesetz (BDSG).

---

## Sumário

- [Ferramentas](#ferramentas)
  - [Verificador de Conformidade LGPD/GDPR](#verificador-de-conformidade-lgpdgdpr)
  - [Gerador de DPIA](#gerador-de-dpia)
  - [Rastreador de Direitos dos Titulares de Dados](#rastreador-de-direitos-dos-titulares-de-dados)
- [Guias de Referência](#guias-de-referência)
- [Fluxos de Trabalho](#fluxos-de-trabalho)

---

## Ferramentas

### Verificador de Conformidade LGPD/GDPR

Escaneia bases de código em busca de potenciais problemas de conformidade LGPD/GDPR, incluindo padrões de dados pessoais e práticas de código arriscadas.

```bash
# Escanear um diretório de projeto
python scripts/gdpr_compliance_checker.py /path/to/project

# Saída JSON para integração CI/CD
python scripts/gdpr_compliance_checker.py . --json --output report.json
```

**Detecta:**
- Padrões de dados pessoais (e-mail, telefone, endereços IP)
- Dados de categoria especial (saúde, biométrico, religião)
- Dados financeiros (cartões de crédito, IBAN)
- Padrões de código arriscados:
  - Registro de dados pessoais em logs
  - Mecanismos de consentimento ausentes
  - Retenção de dados por prazo indefinido
  - Dados sensíveis não criptografados
  - Funcionalidade de exclusão desativada

**Saída:**
- Pontuação de conformidade (0-100)
- Categorização de risco (crítico, alto, médio)
- Recomendações priorizadas com referências aos artigos da LGPD/GDPR

---

### Gerador de DPIA

Gera documentação de Relatório de Impacto à Proteção de Dados Pessoais (RIPD/DPIA) seguindo os requisitos do Art. 35 (GDPR) e Art. 38 (LGPD).

```bash
# Obter template de entrada
python scripts/dpia_generator.py --template > input.json

# Gerar relatório DPIA
python scripts/dpia_generator.py --input input.json --output dpia_report.md
```

**Funcionalidades:**
- Avaliação automática de limiar para DPIA
- Identificação de riscos com base nas características do tratamento
- Documentação de requisitos de base legal
- Recomendações de mitigação
- Geração de relatório em Markdown

**Gatilhos de DPIA Avaliados:**
- Monitoramento sistemático (Art. 35(3)(c) GDPR)
- Dados de categoria especial em grande escala (Art. 35(3)(b) GDPR)
- Tomada de decisão automatizada (Art. 35(3)(a) GDPR)
- Critérios de alto risco do WP29
- Operações de alto risco conforme ANPD (Autoridade Nacional de Proteção de Dados)

---

### Rastreador de Direitos dos Titulares de Dados

Gerencia solicitações de direitos dos titulares de dados conforme os Arts. 15-22 do GDPR e Arts. 17-22 da LGPD.

```bash
# Adicionar nova solicitação
python scripts/data_subject_rights_tracker.py add \
  --type access --subject "João Silva" --email "joao@example.com"

# Listar todas as solicitações
python scripts/data_subject_rights_tracker.py list

# Atualizar status
python scripts/data_subject_rights_tracker.py status --id DSR-202601-0001 --update verified

# Gerar relatório de conformidade
python scripts/data_subject_rights_tracker.py report --output compliance.json

# Gerar template de resposta
python scripts/data_subject_rights_tracker.py template --id DSR-202601-0001
```

**Direitos Suportados:**

| Direito | Artigo GDPR | Artigo LGPD | Prazo |
|-------|---------|---------|--------|
| Acesso | Art. 15 | Art. 19 | 15 dias (LGPD) / 30 dias (GDPR) |
| Retificação | Art. 16 | Art. 18 | 15 dias (LGPD) / 30 dias (GDPR) |
| Eliminação | Art. 17 | Art. 18 | 15 dias (LGPD) / 30 dias (GDPR) |
| Restrição | Art. 18 | — | 30 dias |
| Portabilidade | Art. 20 | Art. 18 | 30 dias |
| Oposição | Art. 21 | Art. 18 | 30 dias |
| Decisões automatizadas | Art. 22 | Art. 20 | 30 dias |

**Funcionalidades:**
- Rastreamento de prazos com alertas de atraso
- Fluxo de trabalho de verificação de identidade
- Geração de templates de resposta
- Relatórios de conformidade

---

## Guias de Referência

### Guia de Conformidade LGPD/GDPR
`references/gdpr_compliance_guide.md`

Orientações abrangentes de implementação cobrindo:
- Bases legais para tratamento (Art. 6 GDPR / Art. 7-11 LGPD)
- Requisitos para dados de categoria especial (Art. 9 GDPR / Art. 11 LGPD)
- Implementação de direitos dos titulares de dados
- Requisitos de accountability (Art. 30 GDPR / Art. 37 LGPD)
- Transferências internacionais (Capítulo V GDPR / Art. 33 LGPD)
- Notificação de incidentes (Art. 33-34 GDPR / Art. 48 LGPD)
- Papel da ANPD (Autoridade Nacional de Proteção de Dados) no Brasil

### Requisitos BDSG Alemão
`references/german_bdsg_requirements.md`

Requisitos específicos da Alemanha incluindo:
- Limiar de nomeação de DPO (§ 38 BDSG — 20+ funcionários)
- Tratamento de dados de empregados (§ 26 BDSG)
- Regras de videovigilância (§ 4 BDSG)
- Requisitos de pontuação de crédito (§ 31 BDSG)
- Leis estaduais de proteção de dados (Landesdatenschutzgesetze)
- Direitos de co-determinação do conselho de trabalhadores

### Metodologia DPIA
`references/dpia_methodology.md`

Processo DPIA passo a passo:
- Critérios de avaliação de limiar
- Indicadores de alto risco do WP29
- Metodologia de avaliação de risco
- Categorias de medidas de mitigação
- Consulta ao DPO e à autoridade supervisora (ANPD no Brasil)
- Templates e listas de verificação

---

## Fluxos de Trabalho

### Fluxo de Trabalho 1: Avaliação de Nova Atividade de Tratamento

```
Passo 1: Executar verificador de conformidade na base de código
        → python scripts/gdpr_compliance_checker.py /path/to/code

Passo 2: Revisar achados e pontuação de conformidade
        → Tratar problemas críticos e altos

Passo 3: Determinar se DPIA é necessária
        → Verificar critérios de limiar em references/dpia_methodology.md

Passo 4: Se DPIA necessária, gerar avaliação
        → python scripts/dpia_generator.py --template > input.json
        → Preencher detalhes do tratamento
        → python scripts/dpia_generator.py --input input.json --output dpia.md

Passo 5: Documentar no registro de atividades de tratamento
```

### Fluxo de Trabalho 2: Atendimento de Solicitação de Titular de Dados

```
Passo 1: Registrar solicitação no rastreador
        → python scripts/data_subject_rights_tracker.py add --type [tipo] ...

Passo 2: Verificar identidade (medidas proporcionais)
        → python scripts/data_subject_rights_tracker.py status --id [ID] --update verified

Passo 3: Coletar dados dos sistemas
        → python scripts/data_subject_rights_tracker.py status --id [ID] --update in_progress

Passo 4: Gerar resposta
        → python scripts/data_subject_rights_tracker.py template --id [ID]

Passo 5: Enviar resposta e concluir
        → python scripts/data_subject_rights_tracker.py status --id [ID] --update completed

Passo 6: Monitorar conformidade
        → python scripts/data_subject_rights_tracker.py report
```

### Fluxo de Trabalho 3: Verificação de Conformidade BDSG Alemão

```
Passo 1: Determinar se DPO é obrigatório
        → 20+ funcionários tratando dados pessoais automaticamente
        → OU tratamento exige DPIA
        → OU negócio envolve transferência de dados/pesquisa de mercado

Passo 2: Se funcionários envolvidos, revisar § 26 BDSG
        → Documentar base legal para dados de funcionários
        → Verificar requisitos do conselho de trabalhadores

Passo 3: Se videovigilância, cumprir § 4 BDSG
        → Instalar sinalização
        → Documentar necessidade
        → Limitar retenção

Passo 4: Registrar DPO junto à autoridade supervisora
        → Veja references/german_bdsg_requirements.md para lista de autoridades
```

---

## Conceitos-Chave LGPD/GDPR

### Bases Legais (Art. 6 GDPR / Art. 7-11 LGPD)

- **Consentimento**: Marketing, newsletters, analytics (deve ser livre, específico, informado e inequívoco)
- **Contrato**: Cumprimento de pedidos, prestação de serviços
- **Obrigação legal**: Registros fiscais, legislação trabalhista
- **Interesse legítimo**: Prevenção de fraude, segurança (requer teste de balanceamento)
- **Proteção da vida** (LGPD): Tratamento necessário para proteção da vida ou segurança física
- **Tutela da saúde** (LGPD): Procedimentos realizados por profissionais da saúde

### Dados de Categoria Especial (Art. 9 GDPR / Art. 11 LGPD)

Requer consentimento explícito ou exceção específica:
- Dados de saúde
- Dados biométricos
- Origem racial ou étnica
- Opiniões políticas
- Crenças religiosas
- Filiação sindical
- Dados genéticos
- Orientação sexual
- Dados de crianças e adolescentes (proteção reforçada na LGPD)

### Direitos dos Titulares de Dados

Todos os direitos devem ser atendidos dentro dos prazos legais:
- **Acesso**: Fornecer cópia dos dados e informações sobre o tratamento
- **Retificação**: Corrigir dados inexatos
- **Eliminação**: Excluir dados (com exceções para obrigações legais)
- **Restrição**: Limitar o tratamento enquanto problemas são resolvidos
- **Portabilidade**: Fornecer dados em formato legível por máquina
- **Oposição**: Interromper o tratamento com base em interesses legítimos
- **Revisão de decisões automatizadas** (LGPD Art. 20): Direito de revisão humana de decisões automatizadas

### Acréscimos BDSG Alemão

| Tema | Seção BDSG | Requisito-Chave |
|-------|--------------|-----------------|
| Limiar DPO | § 38 | 20+ funcionários = DPO obrigatório |
| Emprego | § 26 | Regras detalhadas para dados de funcionários |
| Vídeo | § 4 | Sinalização e proporcionalidade |
| Pontuação | § 31 | Algoritmos explicáveis |
