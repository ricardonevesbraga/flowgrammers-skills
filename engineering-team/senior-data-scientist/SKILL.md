---
name: "senior-data-scientist"
description: "Skill de cientista de dados sênior de nível mundial especializada em modelagem estatística, design de experimentos, inferência causal e analytics preditivo. Cobre teste A/B (dimensionamento de amostra, testes z de duas proporções, correção de Bonferroni), difference-in-differences, pipelines de feature engineering (Scikit-learn, XGBoost), avaliação de modelo com validação cruzada (AUC-ROC, AUC-PR, SHAP) e rastreamento de experimentos MLflow — usando Python (NumPy, Pandas, Scikit-learn), R e SQL. Use quando projetar ou analisar experimentos controlados, construir e avaliar modelos de classificação ou regressão, realizar análise causal em dados observacionais, fazer feature engineering para datasets tabulares estruturados ou traduzir achados estatísticos em decisões de negócio baseadas em dados."
author: Ric Neves - Flowgrammers
agents:
  - claude-code
---

# Cientista de Dados Sênior

Skill de cientista de dados sênior de nível mundial para sistemas de IA/ML/Dados em produção.

## Fluxos de Trabalho Principais

### 1. Projetar um Teste A/B

```python
import numpy as np
from scipy import stats

def calculate_sample_size(baseline_rate, mde, alpha=0.05, power=0.8):
    """
    Calcular o tamanho de amostra necessário por variante.
    baseline_rate: taxa de conversão atual (ex.: 0.10)
    mde: efeito mínimo detectável (relativo, ex.: 0.05 = 5% de lift)
    """
    p1 = baseline_rate
    p2 = baseline_rate * (1 + mde)
    effect_size = abs(p2 - p1) / np.sqrt((p1 * (1 - p1) + p2 * (1 - p2)) / 2)
    z_alpha = stats.norm.ppf(1 - alpha / 2)
    z_beta = stats.norm.ppf(power)
    n = ((z_alpha + z_beta) / effect_size) ** 2
    return int(np.ceil(n))

def analyze_experiment(control, treatment, alpha=0.05):
    """
    Executar teste z de duas proporções e retornar resultados estruturados.
    control/treatment: dicts com 'conversions' e 'visitors'.
    """
    p_c = control["conversions"] / control["visitors"]
    p_t = treatment["conversions"] / treatment["visitors"]
    pooled = (control["conversions"] + treatment["conversions"]) / (control["visitors"] + treatment["visitors"])
    se = np.sqrt(pooled * (1 - pooled) * (1 / control["visitors"] + 1 / treatment["visitors"]))
    z = (p_t - p_c) / se
    p_value = 2 * (1 - stats.norm.cdf(abs(z)))
    ci_low = (p_t - p_c) - stats.norm.ppf(1 - alpha / 2) * se
    ci_high = (p_t - p_c) + stats.norm.ppf(1 - alpha / 2) * se
    return {
        "lift": (p_t - p_c) / p_c,
        "p_value": p_value,
        "significant": p_value < alpha,
        "ci_95": (ci_low, ci_high),
    }

# --- Checklist do experimento ---
# 1. Definir UMA métrica primária e pré-registrar métricas secundárias.
# 2. Calcular tamanho de amostra ANTES de iniciar: calculate_sample_size(0.10, 0.05)
# 3. Randomizar no nível do usuário (não da sessão) para evitar vazamento.
# 4. Executar por pelo menos 1 ciclo de negócio completo (tipicamente 2 semanas).
# 5. Verificar sample ratio mismatch: abs(n_control - n_treatment) / expected < 0.01
# 6. Analisar com analyze_experiment() e reportar lift + IC, não apenas p-value.
# 7. Aplicar correção de Bonferroni para múltiplas métricas: alpha / n_metrics
```

### 2. Construir um Pipeline de Feature Engineering

```python
import pandas as pd
import numpy as np
from sklearn.pipeline import Pipeline
from sklearn.preprocessing import StandardScaler, OneHotEncoder
from sklearn.impute import SimpleImputer
from sklearn.compose import ColumnTransformer

def build_feature_pipeline(numeric_cols, categorical_cols, date_cols=None):
    """
    Retorna um ColumnTransformer pronto para ajuste com dados tabulares estruturados.
    """
    numeric_pipeline = Pipeline([
        ("impute", SimpleImputer(strategy="median")),
        ("scale",  StandardScaler()),
    ])
    categorical_pipeline = Pipeline([
        ("impute", SimpleImputer(strategy="most_frequent")),
        ("encode", OneHotEncoder(handle_unknown="ignore", sparse_output=False)),
    ])
    transformers = [
        ("num", numeric_pipeline, numeric_cols),
        ("cat", categorical_pipeline, categorical_cols),
    ]
    return ColumnTransformer(transformers, remainder="drop")

def add_time_features(df, date_col):
    """Extrair features cíclicas e de lag de uma coluna datetime."""
    df = df.copy()
    df[date_col] = pd.to_datetime(df[date_col])
    df["dow_sin"] = np.sin(2 * np.pi * df[date_col].dt.dayofweek / 7)
    df["dow_cos"] = np.cos(2 * np.pi * df[date_col].dt.dayofweek / 7)
    df["month_sin"] = np.sin(2 * np.pi * df[date_col].dt.month / 12)
    df["month_cos"] = np.cos(2 * np.pi * df[date_col].dt.month / 12)
    df["is_weekend"] = (df[date_col].dt.dayofweek >= 5).astype(int)
    return df

# --- Checklist de feature engineering ---
# 1. Nunca ajustar transformadores no dataset completo — ajustar no treino, transformar no teste.
# 2. Aplicar transformação log em features numéricas com skewness à direita antes de escalar.
# 3. Para categóricas de alta cardinalidade (>50 níveis), use target encoding ou embeddings.
# 4. Gerar features de lag/rolling ANTES da divisão treino/teste para evitar vazamento.
# 5. Documentar o significado de negócio de cada feature ao lado do código.
```

### 3. Treinar, Avaliar e Selecionar um Modelo de Predição

```python
from sklearn.model_selection import StratifiedKFold, cross_validate
from sklearn.metrics import make_scorer, roc_auc_score, average_precision_score
import xgboost as xgb
import mlflow

SCORERS = {
    "roc_auc":  make_scorer(roc_auc_score, needs_proba=True),
    "avg_prec": make_scorer(average_precision_score, needs_proba=True),
}

def evaluate_model(model, X, y, cv=5):
    """
    Validação cruzada retornando média ± desvio padrão para cada scorer.
    Use StratifiedKFold para classificação para preservar o balanceamento de classes.
    """
    cv_results = cross_validate(
        model, X, y,
        cv=StratifiedKFold(n_splits=cv, shuffle=True, random_state=42),
        scoring=SCORERS,
        return_train_score=True,
    )
    summary = {}
    for metric in SCORERS:
        test_scores = cv_results[f"test_{metric}"]
        summary[metric] = {"mean": test_scores.mean(), "std": test_scores.std()}
        # Sinalizar overfitting: grande gap entre pontuação de treino e teste
        train_mean = cv_results[f"train_{metric}"].mean()
        summary[metric]["overfit_gap"] = train_mean - test_scores.mean()
    return summary

def train_and_log(model, X_train, y_train, X_test, y_test, run_name):
    """Treinar modelo e registrar todos os artefatos no MLflow."""
    with mlflow.start_run(run_name=run_name):
        model.fit(X_train, y_train)
        proba = model.predict_proba(X_test)[:, 1]
        metrics = {
            "roc_auc":  roc_auc_score(y_test, proba),
            "avg_prec": average_precision_score(y_test, proba),
        }
        mlflow.log_params(model.get_params())
        mlflow.log_metrics(metrics)
        mlflow.sklearn.log_model(model, "model")
        return metrics

# --- Checklist de avaliação de modelo ---
# 1. Sempre reportar AUC-PR junto com AUC-ROC para datasets desbalanceados.
# 2. Verificar overfit_gap > 0.05 como sinal de aviso de overfitting.
# 3. Calibrar probabilidades (Platt scaling / isotônico) antes do uso em produção.
# 4. Calcular valores SHAP para validar que a importância das features faz sentido para o negócio.
# 5. Executar um baseline (ex.: DummyClassifier) e verificar se o modelo o supera.
# 6. Registrar cada execução no MLflow — nunca depender da saída do notebook para comparação.
```

### 4. Inferência Causal: Difference-in-Differences

```python
import statsmodels.formula.api as smf

def diff_in_diff(df, outcome, treatment_col, post_col, controls=None):
    """
    Estimar ATT via OLS DiD com covariáveis opcionais.
    df deve ter: outcome, treatment_col (0/1), post_col (0/1).
    Retorna o coeficiente de interação (treatment × post) e seu p-value.
    """
    covariates = " + ".join(controls) if controls else ""
    formula = (
        f"{outcome} ~ {treatment_col} * {post_col}"
        + (f" + {covariates}" if covariates else "")
    )
    result = smf.ols(formula, data=df).fit(cov_type="HC3")
    interaction = f"{treatment_col}:{post_col}"
    return {
        "att":     result.params[interaction],
        "p_value": result.pvalues[interaction],
        "ci_95":   result.conf_int().loc[interaction].tolist(),
        "summary": result.summary(),
    }

# --- Checklist de inferência causal ---
# 1. Validar tendências paralelas no pré-período antes de confiar nas estimativas DiD.
# 2. Usar erros padrão robustos HC3 para lidar com heterocedasticidade.
# 3. Para dados em painel, clusterizar SEs no nível da unidade (adicionar parâmetro groups= ao fit).
# 4. Considerar propensity score matching se os grupos diferirem no baseline.
# 5. Reportar o ATT com intervalo de confiança, não apenas significância estatística.
```

## Documentação de Referência

- **Métodos Estatísticos:** `references/statistical_methods_advanced.md`
- **Frameworks de Design de Experimentos:** `references/experiment_design_frameworks.md`
- **Padrões de Feature Engineering:** `references/feature_engineering_patterns.md`

## Comandos Comuns

```bash
# Testes e linting
python -m pytest tests/ -v --cov=src/
python -m black src/ && python -m pylint src/

# Treinamento e avaliação
python scripts/train.py --config prod.yaml
python scripts/evaluate.py --model best.pth

# Implantação
docker build -t service:v1 .
kubectl apply -f k8s/
helm upgrade service ./charts/

# Monitoramento e saúde
kubectl logs -f deployment/service
python scripts/health_check.py
```
