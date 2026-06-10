-- Views analiticas do projeto.

CREATE OR REPLACE VIEW vw_taxa_inadimplencia_por_finalidade AS
SELECT
    p.finalidade_emprestimo,
    ROUND(100.0 * AVG(f.status_emprestimo), 2) AS taxa_inadimplencia_pct
FROM fato_emprestimo f
JOIN dim_perfil_emprestimo p
    ON p.id_perfil_emprestimo = f.id_perfil_emprestimo
GROUP BY p.finalidade_emprestimo
ORDER BY taxa_inadimplencia_pct DESC;

CREATE OR REPLACE VIEW vw_juros_medio_por_classificacao AS
SELECT
    p.classificacao_emprestimo,
    ROUND(AVG(f.juros_aplicado), 3) AS juros_medio_aplicado
FROM fato_emprestimo f
JOIN dim_perfil_emprestimo p
    ON p.id_perfil_emprestimo = f.id_perfil_emprestimo
GROUP BY p.classificacao_emprestimo
ORDER BY juros_medio_aplicado DESC;