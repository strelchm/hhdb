SELECT v.id, v.title, COUNT(*) resp_count
FROM vacancy v
         INNER JOIN response r ON v.id = r.vacancy_id
WHERE (r.create_date - v.create_date) < interval '7' DAY
GROUP BY v.id, v.title
HAVING COUNT(*) > 5;