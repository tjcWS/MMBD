SELECT
    dm.merchant_name,
    ROUND(SUM(f.amount_rub), 2) AS turnover_rub
FROM marts.fct_transactions f
JOIN marts.dim_client dc
    ON dc.client_sk = f.client_sk
JOIN marts.dim_merchant dm
    ON dm.merchant_sk = f.merchant_sk
JOIN marts.dim_date dd
    ON dd.date_sk = f.date_sk
WHERE dc.segment = 'premium'
  AND dd.date_actual BETWEEN DATE '2026-06-01' AND DATE '2026-08-31'
  AND f.status = 'approved'
  AND f.channel IN ('pos', 'ecom')
GROUP BY dm.merchant_name
ORDER BY turnover_rub DESC
LIMIT 5
