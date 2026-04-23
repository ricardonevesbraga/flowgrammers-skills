---
name: "mdr-745-specialist"
description: Especialista em conformidade EU MDR 2017/745 para classificação de dispositivos médicos, documentação técnica, evidência clínica e vigilância pós-mercado. Cobre regras de classificação do Anexo VIII, arquivos técnicos dos Anexos II/III, avaliação clínica do Anexo XIV e integração EUDAMED.
triggers:
  - MDR compliance
  - EU MDR
  - medical device classification
  - Annex VIII
  - technical documentation
  - clinical evaluation
  - PMCF
  - EUDAMED
  - UDI
  - notified body
---

# MDR 2017/745 Specialist

Padrões de conformidade EU MDR para classificação de dispositivos médicos, documentação técnica e evidência clínica.

---

## Sumário

- [Fluxo de Trabalho de Classificação do Dispositivo](#fluxo-de-trabalho-de-classificação-do-dispositivo)
- [Documentação Técnica](#documentação-técnica)
- [Evidência Clínica](#evidência-clínica)
- [Vigilância Pós-Mercado](#vigilância-pós-mercado)
- [EUDAMED e UDI](#eudamed-e-udi)
- [Documentação de Referência](#documentação-de-referência)
- [Ferramentas](#ferramentas)

---

## Fluxo de Trabalho de Classificação do Dispositivo

Classificar o dispositivo conforme o Anexo VIII do MDR:

1. Identificar a duração do dispositivo (transiente, curto prazo, longo prazo)
2. Determinar o nível de invasividade (não invasivo, orifício corporal, cirúrgico)
3. Avaliar o contato com sistemas corporais (SNC, cardíaco, outros)
4. Verificar se é dispositivo ativo (dependente de energia)
5. Aplicar regras de classificação 1-22
6. Para software, aplicar o algoritmo MDCG 2019-11
7. Documentar a justificativa da classificação
8. **Validação:** Classificação confirmada com o Organismo Notificado

### Matriz de Classificação

| Fator | Classe I | Classe IIa | Classe IIb | Classe III |
|--------|---------|-----------|-----------|-----------|
| Duração | Qualquer | Curto prazo | Longo prazo | Longo prazo |
| Invasividade | Não invasivo | Orifício corporal | Cirúrgico | Implantável |
| Sistema | Qualquer | Não crítico | Órgãos críticos | SNC/cardíaco |
| Risco | Menor | Baixo-médio | Médio-alto | Maior |

### Classificação de Software (MDCG 2019-11)

| Uso da Informação | Gravidade da Condição | Classe |
|-----------------|-------------------|-------|
| Informa decisão | Não grave | IIa |
| Informa decisão | Grave | IIb |
| Conduz/trata | Crítico | III |

### Exemplos de Classificação

**Exemplo 1: Sutura Cirúrgica Absorvível**
- Regra 8 (implantável, longo prazo)
- Duração: > 30 dias (absorvida)
- Contato: Tecido geral
- Classificação: **Classe IIb**

**Exemplo 2: Software de Diagnóstico por IA**
- Regra 11 + MDCG 2019-11
- Função: Diagnostica condição grave
- Classificação: **Classe IIb**

**Exemplo 3: Marcapasso Cardíaco**
- Regra 8 (implantável)
- Contato: Sistema circulatório central
- Classificação: **Classe III**

---

## Documentação Técnica

Preparar o dossiê técnico conforme os Anexos II e III:

1. Criar descrição do dispositivo (variantes, acessórios, propósito pretendido)
2. Desenvolver rotulagem (requisitos do Artigo 13, IFU)
3. Documentar projeto e processo de fabricação
4. Completar matriz de conformidade com os GSPR
5. Preparar análise benefício-risco
6. Compilar evidências de verificação e validação
7. Integrar arquivo de gestão de riscos (ISO 14971)
8. **Validação:** Arquivo técnico revisado quanto à completude

### Estrutura do Arquivo Técnico

```
DOCUMENTAÇÃO TÉCNICA DO ANEXO II
├── Descrição do dispositivo e UDI-DI
├── Rotulagem e instruções de uso
├── Informações de projeto e fabricação
├── Matriz de conformidade com GSPR
├── Análise benefício-risco
├── Verificação e validação
└── Relatório de avaliação clínica
```

### Lista de Verificação de Conformidade GSPR

| Requisito | Evidência | Status |
|-------------|----------|--------|
| Projeto seguro (GSPR 1-3) | Arquivo de gestão de riscos | ☐ |
| Propriedades químicas (GSPR 10.1) | Relatório de biocompatibilidade | ☐ |
| Risco de infecção (GSPR 10.2) | Validação de esterilização | ☐ |
| Requisitos de software (GSPR 17) | Documentação IEC 62304 | ☐ |
| Rotulagem (GSPR 23) | Arte da rotulagem, IFU | ☐ |

### Rotas de Avaliação de Conformidade

| Classe | Rota | Envolvimento do ON |
|-------|-------|----------------|
| I | Autodeclaração Anexo II | Nenhum |
| Is/Im | Anexo II + IX/XI | Aspectos estéreis/de medição |
| IIa | Anexo II + IX ou XI | Produto ou SGQ |
| IIb | Anexo IX + X ou X + XI | Exame de tipo + produção |
| III | Anexo IX + X | SGQ completo + exame de tipo |

---

## Evidência Clínica

Desenvolver estratégia de evidência clínica conforme o Anexo XIV:

1. Definir afirmações clínicas e endpoints
2. Conduzir busca sistemática de literatura
3. Avaliar a qualidade dos dados clínicos
4. Avaliar equivalência (técnica, biológica, clínica)
5. Identificar lacunas de evidência
6. Determinar se investigação clínica é necessária
7. Preparar o Relatório de Avaliação Clínica (CER)
8. **Validação:** CER revisado por avaliador qualificado

### Requisitos de Evidência por Classe

| Classe | Evidência Mínima | Investigação |
|-------|------------------|---------------|
| I | Análise benefício-risco | Normalmente não necessária |
| IIa | Literatura + pós-mercado | Pode ser necessária |
| IIb | Revisão sistemática de literatura | Frequentemente necessária |
| III | Dados clínicos abrangentes | Obrigatória (Artigo 61) |

### Estrutura do Relatório de Avaliação Clínica

```
CONTEÚDO DO CER
├── Resumo executivo
├── Escopo do dispositivo e propósito pretendido
├── Histórico clínico (estado da arte)
├── Metodologia de busca de literatura
├── Análise e apreciação de dados
├── Conclusões de segurança e desempenho
├── Determinação benefício-risco
└── Resumo do plano PMCF
```

### Requisitos do Avaliador Qualificado

- Diploma de medicina ou qualificação equivalente em saúde
- 4+ anos de experiência clínica na área relevante
- Treinamento em metodologia de avaliação clínica
- Compreensão dos requisitos do MDR

---

## Vigilância Pós-Mercado

Estabelecer sistema de PMS conforme o Capítulo VII:

1. Desenvolver plano de PMS (Artigo 84)
2. Definir métodos de coleta de dados
3. Estabelecer procedimentos de tratamento de reclamações
4. Criar processo de relatório de vigilância
5. Planejar Relatórios Periódicos de Segurança Atualizados (PSUR)
6. Integrar com atividades de PMCF
7. Definir análise de tendências e detecção de sinais
8. **Validação:** Sistema de PMS auditado anualmente

### Componentes do Sistema de PMS

| Componente | Requisito | Frequência |
|-----------|-------------|-----------|
| Plano de PMS | Artigo 84 | Manter atualizado |
| PSUR | Classe IIa e superior | Por cronograma de classe |
| Plano PMCF | Anexo XIV Parte B | Atualizar com CER |
| Relatório PMCF | Anexo XIV Parte B | Anual (Classe III) |
| Vigilância | Artigos 87-92 | Conforme eventos ocorrem |

### Cronograma do PSUR

| Classe | Frequência |
|-------|-----------|
| Classe III | Anual |
| Classe IIb implantável | Anual |
| Classe IIb | A cada 2 anos |
| Classe IIa | Quando necessário |

### Notificação de Incidentes Graves

| Prazo | Requisito |
|----------|-------------|
| 2 dias | Ameaça grave à saúde pública |
| 10 dias | Morte ou deterioração grave |
| 15 dias | Outros incidentes graves |

---

## EUDAMED e UDI

Implementar o sistema UDI conforme o Artigo 27:

1. Obter código da entidade emissora (GS1, HIBCC, ICCBBA)
2. Atribuir UDI-DI a cada variante do dispositivo
3. Atribuir UDI-PI (identificador de produção)
4. Aplicar portador UDI nas etiquetas (AIDC + HRI)
5. Registrar ator no EUDAMED
6. Registrar dispositivos no EUDAMED
7. Carregar certificados quando disponíveis
8. **Validação:** UDI verificado em etiquetas de amostra

### Módulos do EUDAMED

| Módulo | Conteúdo | Ator |
|--------|---------|-------|
| Ator | Registro da empresa | Fabricante, AR |
| UDI/Dispositivo | Dados do dispositivo e variante | Fabricante |
| Certificados | Certificados do ON | Organismo Notificado |
| Investigação Clínica | Registro do estudo | Patrocinador |
| Vigilância | Relatórios de incidentes | Fabricante |
| Vigilância de Mercado | Ações da autoridade | Autoridade Competente |

### Requisitos de Rotulagem UDI

Elementos obrigatórios conforme o Artigo 13:

- [ ] UDI-DI (identificador do dispositivo)
- [ ] UDI-PI (identificador de produção) para Classe II+
- [ ] Formato AIDC (código de barras/RFID)
- [ ] Formato HRI (legível por humanos)
- [ ] Nome e endereço do fabricante
- [ ] Número de lote/série
- [ ] Data de vencimento (se aplicável)

---

## Documentação de Referência

### Guia de Classificação MDR

`references/mdr-classification-guide.md` contém:

- Regras completas de classificação do Anexo VIII (Regras 1-22)
- Classificação de software conforme MDCG 2019-11
- Exemplos de classificação detalhados
- Seleção de rota de avaliação de conformidade

### Requisitos de Evidência Clínica

`references/clinical-evidence-requirements.md` contém:

- Framework e hierarquia de evidência clínica
- Metodologia de busca de literatura
- Estrutura do Relatório de Avaliação Clínica
- Orientações para plano e relatório PMCF

### Templates de Documentação Técnica

`references/technical-documentation-templates.md` contém:

- Requisitos de conteúdo dos Anexos II e III
- Estrutura do Arquivo de Histórico de Projeto
- Template de matriz de conformidade GSPR
- Template de Declaração de Conformidade
- Lista de verificação de submissão ao Organismo Notificado

---

## Ferramentas

### Analisador de Lacunas MDR

```bash
# Análise de lacunas rápida
python scripts/mdr_gap_analyzer.py --device "Nome do Dispositivo" --class IIa

# Saída JSON para integração
python scripts/mdr_gap_analyzer.py --device "Nome do Dispositivo" --class III --output json

# Avaliação interativa
python scripts/mdr_gap_analyzer.py --interactive
```

Analisa o dispositivo em relação aos requisitos MDR, identifica lacunas de conformidade, gera recomendações priorizadas.

**A saída inclui:**
- Lista de verificação de requisitos por categoria
- Identificação de lacunas com prioridades
- Destaque de lacunas críticas
- Recomendações de roteiro de conformidade

---

## Interface com o Organismo Notificado

### Critérios de Seleção

| Fator | Considerações |
|--------|----------------|
| Escopo de designação | Cobre seu tipo de dispositivo |
| Capacidade | Prazo para auditoria inicial |
| Alcance geográfico | Mercados que você precisa acessar |
| Expertise técnica | Experiência com sua tecnologia |
| Estrutura de taxas | Transparência e previsibilidade |

### Lista de Verificação Pré-Submissão

- [ ] Documentação técnica completa
- [ ] Matriz GSPR totalmente tratada
- [ ] Arquivo de gestão de riscos atualizado
- [ ] Relatório de avaliação clínica completo
- [ ] QMS (ISO 13485) certificado
- [ ] Rotulagem e IFU finalizados
- [ ] **Validação:** Avaliação interna de lacunas completa
