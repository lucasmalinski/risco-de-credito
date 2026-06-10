-- Cria a tabela staging para o dataset de risco de credito.
-- Ajuste os tipos se o CSV de origem tiver variacoes de precisao.

DROP TABLE IF EXISTS staging_credit_risk;

CREATE TABLE staging_credit_risk (
    person_age INTEGER,
    person_income NUMERIC(12, 2),
    person_home_ownership VARCHAR(50),
    person_emp_length NUMERIC(4, 1),
    loan_intent VARCHAR(50),
    loan_grade VARCHAR(10),
    loan_amnt NUMERIC(12, 2),
    loan_int_rate NUMERIC(6, 3),
    loan_status INTEGER,
    loan_percent_income NUMERIC(6, 4),
    cb_person_default_on_file VARCHAR(3),
    cb_person_cred_hist_length INTEGER
);