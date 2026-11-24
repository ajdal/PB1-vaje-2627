Poskusni izpit


INSERT INTO predmeti (ime, smer)
SELECT p1.ime, '0Mate'
FROM predmeti AS p1
    JOIN predmeti AS p2 ON p1.ime = p2.ime
WHERE p1.smer LIKE '1%' AND p2.smer LIKE '2%';

SELECT * FROM predmeti WHERE smer = '0Mate';


SELECT *
FROM skupine
WHERE tip = 'S' AND tip NOT IN ('V', 'L');

SELECT predmeti.id, ime, smer
FROM predmeti
    JOIN dodelitve ON predmet = predmeti.id
    JOIN skupine ON skupine.id = skupina
GROUP BY predmeti.id, ime, smer
HAVING 
    SUM(CASE WHEN tip = 'S' THEN 1 ELSE 0 END) > 0 
    AND SUM(CASE WHEN tip IN ('V', 'L') THEN 1 ELSE 0 END) = 0;

SELECT id, ime, smer
FROM predmeti
WHERE id IN (
        SELECT predmet
        FROM dodelitve JOIN skupine ON skupine.id = skupina
        WHERE tip = 'S'
    )
    AND id NOT IN (
        SELECT predmet
        FROM dodelitve JOIN skupine ON skupine.id = skupina
        WHERE tip IN ('V', 'L')
    );


