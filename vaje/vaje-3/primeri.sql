SELECT leto, AVG(ocena), SUM(dolzina)
FROM filmi;

SELECT leto, AVG(ocena), SUM(dolzina)
FROM filmi
WHERE leto = 2000;

SELECT leto, AVG(ocena), SUM(dolzina)
FROM filmi
GROUP BY leto;

SELECT leto, naslov, AVG(ocena), SUM(dolzina) -- TO NIMA SMISLA, dobimo pač en naslov iz tega leta
FROM filmi
GROUP BY leto;

-- Sešteje dolžine vseh filmov posameznih režiserjev v posameznih letih
SELECT leto, reziser, SUM(dolzina)
FROM filmi
GROUP BY leto, reziser;

SELECT leto, reziser, SUM(dolzina) as skupna_dolzina
FROM filmi
GROUP BY leto, reziser
ORDER BY skupna_dolzina DESC;


SELECT leto, COUNT(naslov) AS st_filmov
FROM filmi
GROUP BY leto
HAVING st_filmov > 10;

SELECT leto, COUNT(naslov) AS st_filmov
FROM filmi
WHERE ocena > 7
GROUP BY leto;
--HAVING st_filmov > 10;

SELECT leto, COUNT(naslov) AS st_filmov, AVG(ocena) AS povp_ocena
FROM filmi
GROUP BY leto
HAVING povp_ocena > 7;


