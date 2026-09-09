SELECT
    dd.week_start,
    f.channel,
    ROUND(
        100.0 *
        SUM(CASE WHEN f.status = 'declined' THEN 1 ELSE 0 END)
        / NULLIF(
            SUM(CASE WHEN f.status IN ('approved', 'declined')
                    THEN 1 ELSE 0 END),
            0
        ),
        2
    ) AS declined_share_pct
FROM marts.fct_transactions f
JOIN marts.dim_date dd
    ON dd.date_sk = f.date_sk
WHERE dd.date_actual BETWEEN DATE '2026-08-01' AND DATE '2026-08-31'
AND f.status IN ('approved', 'declined')
GROUP BY dd.week_start, f.channel
ORDER BY dd.week_start, f.channel

