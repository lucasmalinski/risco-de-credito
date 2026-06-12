# Credit Risk Warehouse + Machine Learning

Projeto prático final da disciplina de Desenvolvimento para Ciência de Dados II. O objetivo é construir uma solução completa de dados de ponta a ponta: desde a ingestão bruta, modelagem dimensional em Star Schema utilizando conceitos avançados de arquitetura em camadas (Medalhão), até a entrega de visões analíticas e modelos preditivos de Machine Learning (Classificação e Regressão).

## Arquitetura de Dados (Camadas & Star Schema)

O projeto adota uma abordagem **ELT (Extract, Load, Transform)** estruturada em duas camadas lógicas de banco de dados (schemas) dentro do PostgreSQL para garantir governança, isolamento e performance:

1. **Camada Bronze:** Hospeda a tabela `bronze.staging_credit_risk`, que recebe o carregamento direto, íntegro e bruto do arquivo CSV original.
2. **Camada Analytics:** Onde reside o ecossistema descritivo e preditivo. Os dados brutos são limpos, traduzidos para o português e normalizados em um **Star Schema** otimizado contendo:
   - `analytics.dim_cliente` (Dados demográficos e financeiros do tomador)
   - `analytics.dim_perfil_emprestimo` (Finalidade e classificação do crédito solicitado)
   - `analytics.dim_historico_credito` (Registro de inadimplências prévias e tempo de histórico)
   - `analytics.fato_emprestimo` (Tabela fato contendo as métricas financeiras e a chave degenerada `id_aplicacao`).

---

## Estrutura do Repositório

```text
/
├── data/
│   └── raw/               # Diretório local para o arquivo credit_risk_dataset.csv
├── notebooks/
│   ├── 01_eda.ipynb       # Análise Exploratória de Dados (Pandas & Matplotlib)
│   └── 02_modelos_ml.ipynb # Modelagem Preditiva com Scikit-Learn
├── sql/
│   ├── 01_staging.sql     # Criação do Schema Bronze e tabela Staging
│   ├── 02_transform.sql   # Criação do Schema Analytics, Star Schema e carga (ETL)
│   └── 03_views.sql       # Criação das Views Analíticas obrigatórias
├── .env                   # Arquivo local com as credenciais confidenciais do DB
├── .env.example           # Modelo para configuração das credenciais do banco
├── requirements.txt       # Dependências do projeto (travadas para Python 3.13)
└── rubrica_professor.md   # Arquivo com os critérios de avaliação originais
```

---

## Como Iniciar

### 1. Preparação do Banco de Dados (PostgreSQL)

1. Certifique-se de que o seu servidor PostgreSQL (ou container Docker) está ativo.
2. Crie um banco de dados chamado `credit_risk`.
3. Abra o seu cliente SQL (pgAdmin / DBeaver) conectado a este banco e execute os scripts da pasta `sql/` na seguinte ordem cronológica:
   - Executar `sql/01_staging.sql` para instanciar o ambiente `bronze`.
   - *Ação Manual via pgAdmin:* Clique com o botão direito na tabela `bronze.staging_credit_risk`, selecione **Import/Export Data**, mude para **Import**, selecione o arquivo CSV `data/raw/credit_risk_dataset.csv` e configure as opções: `Header = True` e `Delimiter = ,`.
   - Executar `sql/02_transform.sql` para gerar o schema `analytics`, normalizar as dimensões e popular o Star Schema (usando a proteção técnica `IS NOT DISTINCT FROM` para preservar registros com valores nulos).
   - Executar `sql/03_views.sql` para criar as visões analíticas obrigatórias de negócio.

### 2. Configuração do Ambiente Python

1. Copie o arquivo `.env.example` para um novo arquivo chamado `.env` na raiz do projeto e preencha com as suas credenciais locais de acesso.
2. Certifique-se de estar utilizando um ambiente virtual limpo (Recomendado: Python 3.13) para evitar conflitos de compilação binária no Matplotlib.
3. Instale as dependências executando:

   ```bash
   uv pip install -r requirements.txt
   # ou tradicionalmente, sem UV: pip install -r requirements.txt
   ```

4. Inicialize o seu servidor de Notebooks e execute as células do `01_eda.ipynb` e do `02_modelos_ml.ipynb` para gerar as análises e métricas estatísticas.

---

## Resultados de Machine Learning

### Classificação (Target: `status_emprestimo`)

Modelos de aprendizado supervisionado treinados para prever a probabilidade de inadimplência de crédito (0 = Adimplente, 1 = Inadimplente).

*Nota: Preencha as métricas reais da tabela abaixo assim que rodar as células do notebook `02_modelos_ml.ipynb`.*

| Modelo | Acurácia | Precision (Classe 1) | Recall (Classe 1) | F1-Score (Classe 1) |
| :--- | :---: | :---: | :---: | :---: |
| **KNN** | 0.00% | 0.00% | 0.00% | 0.00% |
| **Decision Tree** | 0.00% | 0.00% | 0.00% | 0.00% |
| **Random Forest** | 0.00% | 0.00% | 0.00% | 0.00% |
| **Logistic Regression** | 0.00% | 0.00% | 0.00% | 0.00% |

### Regressão (Target: `juros_aplicado`)

Modelo estatístico linear desenvolvido para estimar e prever a taxa de juros justa que deve ser aplicada a uma proposta de crédito com base nas características de risco do tomador.

- **Métrica RMSE (Root Mean Squared Error):** *[Preencher]*
- **Métrica R² Score (Coeficiente de Determinação):** *[Preencher]*

---

## Insights de Negócio e Decisões Práticas

1. **Insight 1 (Análise Descritiva da Renda):** *[Exemplo: During a EDA, identificamos que a distribuição da renda anual possui uma assimetria severa à direita devido a outliers extremos de até R$ 6 milhões. Filtros estatísticos baseados no percentil 99 revelaram o comportamento real do público-alvo geral...]*
2. **Insight 2 (Análise de Inadimplência por Categoria):** *[Exemplo: A View analítica de posse de residência demonstrada no gráfico de barras comprova que clientes que moram de aluguel (RENT) possuem taxas de inadimplência expressivamente maiores do que proprietários com hipotecas ativas...]*
3. **Insight 3 (Mitigação de Risco com Foco em Recall):** *[Exemplo: Como o custo financeiro de um Falso Negativo (aprovar crédito para um cliente inadimplente) é massivamente maior do que um Falso Positivo para o banco, a escolha do modelo ideal deve priorizar a métrica de Recall. O modelo X demonstrou-se mais seguro para implementação em esteiras automáticas de concessão...]*

---

## Entregáveis Acadêmicos

- **Scripts SQL:** Infraestrutura física de cargas e Views analíticas organizadas em schemas segregados.
- **Notebooks Python:** Código modularizado documentando o pipeline de engenharia de features, pré-processamento e modelagem preditiva.
- **Apresentação:** Slides complementares (PowerPoint/Gamma) voltados para a defesa presencial do projeto.
