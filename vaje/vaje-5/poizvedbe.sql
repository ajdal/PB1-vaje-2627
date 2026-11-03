INSERT INTO filmi
(naslov, leto, reziser, certifikat, dolzina, ocena, opis)
SELECT naslov || ' 2', 2026, reziser, certifikat, 
    dolzina + ABS(dolzina - (
            SELECT AVG(dolzina) FROM filmi 
            WHERE leto < 1950 AND certifikat IN ('G', 'PG', 'PG-13')
    )), 
    ocena - 1, opis
FROM filmi
WHERE leto < 1950 AND certifikat IN ('G', 'PG', 'PG-13');

WITH izbrani AS (
    SELECT dolzina
    FROM filmi 
    WHERE leto < 1950 AND certifikat IN ('G', 'PG', 'PG-13')
)
INSERT INTO filmi
(naslov, leto, reziser, certifikat, dolzina, ocena, opis)
SELECT naslov || ' 2', 2026, reziser, certifikat, 
    dolzina + ABS(dolzina - (
            SELECT AVG(dolzina) FROM izbrani
    )), 
    ocena - 1, opis
FROM izbrani;