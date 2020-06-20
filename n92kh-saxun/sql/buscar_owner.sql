--SELECT o.owner_number, Count(r.conference_id)
--FROM owner o
--  JOIN reservation r ON (o.owner_number = r.owner_number AND
--                         o.disabled = 0 AND
--                         o.terminated = 0)
--GROUP BY o.owner_number
--HAVING Count(r.conference_id) > 100

--SELECT r.owner_number, Count(r.conference_id)
--FROM reservation r
--GROUP BY r.owner_number

SELECT o.owner_number, o.disabled, o.terminated
FROM owner o
WHERE o.owner_number = 36738
