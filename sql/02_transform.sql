-- Modelagem dimensional em Star Schema a partir da staging_credit_risk.
-- A carga assume que a tabela staging ja foi populada com o CSV bruto.

DROP TABLE IF EXISTS analytics.fato_emprestimo;
DROP TABLE IF EXISTS analytics.dim_historico_credito;
DROP TABLE IF EXISTS analytics.dim_perfil_emprestimo;
DROP TABLE IF EXISTS analytics.dim_cliente;

CREATE TABLE analytics.dim_cliente (
    id_cliente SERIAL PRIMARY KEY,
    idade INTEGER,
    renda_anual NUMERIC(12, 2),
    posse_residencia VARCHAR(50),
    tempo_empregada NUMERIC(4, 1),
    CONSTRAINT uq_dim_cliente UNIQUE (idade, renda_anual, posse_residencia, tempo_empregada)
);

CREATE TABLE analytics.dim_perfil_emprestimo (
    id_perfil_emprestimo SERIAL PRIMARY KEY,
    finalidade_emprestimo VARCHAR(50),
    classificacao_emprestimo VARCHAR(10),
    CONSTRAINT uq_dim_perfil_emprestimo UNIQUE (finalidade_emprestimo, classificacao_emprestimo)
);

CREATE TABLE analytics.dim_historico_credito (
    id_historico_credito SERIAL PRIMARY KEY,
    inadimplencia_historica VARCHAR(3),
    duracao_historico_credito INTEGER,
    CONSTRAINT uq_dim_historico_credito UNIQUE (inadimplencia_historica, duracao_historico_credito)
);

CREATE TABLE analytics.fato_emprestimo (
    id_aplicacao SERIAL PRIMARY KEY,
    id_cliente INTEGER NOT NULL REFERENCES analytics.dim_cliente (id_cliente),
    id_perfil_emprestimo INTEGER NOT NULL REFERENCES analytics.dim_perfil_emprestimo (id_perfil_emprestimo),
    id_historico_credito INTEGER NOT NULL REFERENCES analytics.dim_historico_credito (id_historico_credito),
    montante_emprestimo NUMERIC(12, 2),
    juros_aplicado NUMERIC(6, 3),
    porcentagem_renda NUMERIC(6, 4),
    status_emprestimo INTEGER
);

INSERT INTO analytics.dim_cliente (idade, renda_anual, posse_residencia, tempo_empregada)
SELECT DISTINCT
    person_age,
    person_income,
    person_home_ownership,
    person_emp_length
FROM bronze.staging_credit_risk
ORDER BY 1, 2, 3, 4;

INSERT INTO analytics.dim_perfil_emprestimo (finalidade_emprestimo, classificacao_emprestimo)
SELECT DISTINCT
    loan_intent,
    loan_grade
FROM bronze.staging_credit_risk
ORDER BY 1, 2;

INSERT INTO analytics.dim_historico_credito (inadimplencia_historica, duracao_historico_credito)
SELECT DISTINCT
    cb_person_default_on_file,
    cb_person_cred_hist_length
FROM bronze.staging_credit_risk
ORDER BY 1, 2;

INSERT INTO analytics.fato_emprestimo (
    id_cliente,
    id_perfil_emprestimo,
    id_historico_credito,
    montante_emprestimo,
    juros_aplicado,
    porcentagem_renda,
    status_emprestimo
)
SELECT
    c.id_cliente,
    p.id_perfil_emprestimo,
    h.id_historico_credito,
    s.loan_amnt,
    s.loan_int_rate,
    s.loan_percent_income,
    s.loan_status
FROM bronze.staging_credit_risk s
JOIN analytics.dim_cliente c
    ON c.idade = s.person_age
   AND c.renda_anual = s.person_income
   AND c.posse_residencia = s.person_home_ownership
   AND c.tempo_empregada IS NOT DISTINCT FROM s.person_emp_length 
JOIN analytics.dim_perfil_emprestimo p
    ON p.finalidade_emprestimo = s.loan_intent
   AND p.classificacao_emprestimo = s.loan_grade
JOIN analytics.dim_historico_credito h
    ON h.inadimplencia_historica = s.cb_person_default_on_file
   AND h.duracao_historico_credito = s.cb_person_cred_hist_length;