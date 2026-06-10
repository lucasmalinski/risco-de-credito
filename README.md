# Credit Risk Warehouse + Machine Learning

Projeto final da disciplina de Desenvolvimento para Ciencia de Dados II. O objetivo e construir uma pipeline completa com PostgreSQL, Data Warehouse em Star Schema, analise exploratoria em Python e modelos de Machine Learning para classificacao e regressao.

## Visao Geral

O dataset principal deve ficar em `data/raw/credit_risk_dataset.csv`. Se o CSV ainda estiver na raiz do workspace, copie-o para esse caminho antes de executar os scripts. A estrutura do projeto segue a organizacao abaixo:

```text
/
├── data/raw/
├── notebooks/
├── sql/
├── .env
├── .env.example
├── README.md
├── requirements.txt
└── rubrica_professor.md
```

## Como iniciar

1. Crie e configure o banco PostgreSQL local.
2. Execute `sql/01_staging.sql` para criar a tabela crua.
3. Importe o CSV de `data/raw/credit_risk_dataset.csv` para a tabela `staging_credit_risk`.
4. Execute `sql/02_transform.sql` para criar dimensoes, fato e cargas.
5. Execute `sql/03_views.sql` para criar as visoes analiticas.
6. Preencha o arquivo `.env` com as credenciais do banco com base em `.env.example`.
7. Instale as dependencias com `pip install -r requirements.txt`.
8. Abra os notebooks em `notebooks/` para executar EDA e Machine Learning.

## Entregaveis

- `sql/01_staging.sql`: DDL da tabela staging.
- `sql/02_transform.sql`: DDL do DW e inserts.
- `sql/03_views.sql`: visoes analiticas.
- `notebooks/01_eda.ipynb`: analise exploratoria.
- `notebooks/02_ml_models.ipynb`: classificacao e regressao.

## Proximos passos

- Criar o schema fisico no PostgreSQL.
- Carregar os dados brutos.
- Validar as dimensoes e a fato.
- Completar as metricas e os insights de negocio.
