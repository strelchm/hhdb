SELECT area_id,
       AVG(compensation_from)                         compensation_from_avg,
       AVG(compensation_to)                           compensation_to_avg,
       AVG((compensation_to + compensation_from) / 2) compensation_to_compensation_from_avg
FROM vacancy
GROUP BY area_id;