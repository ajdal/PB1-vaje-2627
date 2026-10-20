SELECT naslov, ocena, dolzina, ocena / dolzina AS krneki
FROM filmi
WHERE ocena >= 7.5
ORDER BY krneki, ocena DESC, dolzina
LIMIT 30;

SELECT naslov, ocena
FROM filmi
WHERE naslov = "M" OR ocena <> 8.4;

SELECT naslov, ocena
FROM filmi
WHERE naslov LIKE "%M%";

SELECT *
FROM filmi
WHERE ocena > (SELECT AVG(ocena) FROM filmi);

-- 
SELECT *
FROM filmi
WHERE ocena > (
    SELECT AVG(ocena) 
    FROM filmi
    WHERE leto = 2010
);

-- Nadpovprečni filmi v svojem letu.
SELECT *
FROM filmi AS f1
WHERE ocena > (
    SELECT AVG(ocena) 
    FROM filmi AS f2
    WHERE f1.leto = f2.leto
);


SELECT leto / 10, leto / 10.0, leto
FROM filmi;