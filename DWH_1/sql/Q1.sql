SELECT
    dc.federal_district,
    ROUND(SUM(f.amount_rub), 2) AS turnover_rub
FROM marts.fct_transactions f
JOIN marts.dim_client dc
    ON dc.client_sk = f.client_sk
JOIN marts.dim_date dd
    ON dd.date_sk = f.date_sk
WHERE dd.date_actual BETWEEN DATE '2026-07-01' AND DATE '2026-07-31'
  AND f.status = 'approved'
  AND f.channel IN ('pos', 'ecom')
GROUP BY dc.federal_district
ORDER BY turnover_rub DESC
