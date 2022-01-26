WITH vac_stat AS (SELECT EXTRACT(MONTH FROM create_date) as month
                  FROM resume
                  GROUP BY month
                  ORDER BY count(*) DESC
                  LIMIT 1)
SELECT EXTRACT(MONTH FROM create_date) as vacancy_top_month, (SELECT month FROM vac_stat) resume_top_month
FROM vacancy
GROUP BY vacancy_top_month
ORDER BY count(*) DESC
LIMIT 1;