# Združevanje

### Primeri z bazo `filmi ena tabela`:

1. Poiščimo povprečno oceno in skupno dolžino vseh filmov v tabeli `film`.

```sql
SELECT leto, AVG(ocena), SUM(dolzina)
FROM filmi;
```

2. Poiščimo povprečno oceno in skupno dolžino filmov, izdanih leta 2000.

```sql
SELECT leto, AVG(ocena), SUM(dolzina)
FROM filmi
WHERE leto = 2000;
```

3. Poiščimo povprečno oceno in skupno dolžino filmov za vsako leto, za katero imamo v bazi podatke.

```sql
SELECT leto, AVG(ocena), SUM(dolzina)
FROM filmi
GROUP BY leto;
```

4. Seštejmo skupno dolžino vseh filmov posameznih režiserjev za vsako leto. 
```sql
SELECT leto, reziser, SUM(dolzina)
FROM filmi
GROUP BY leto, reziser;
```

Rezultat še uredimo po dolžini padajoče, da bodo najprej pari režiserja in leta z največjim skupnim trajanjem filmov.
```sql
SELECT leto, reziser, SUM(dolzina) as skupna_dolzina
FROM filmi
GROUP BY leto, reziser
ORDER BY skupna_dolzina DESC;
```

5. Za vsako leto preštejmo število filmov z oceno višjo od 7.

```sql
SELECT leto, COUNT(naslov) AS st_filmov
FROM filmi
WHERE ocena > 7
GROUP BY leto;
```

6. Sedaj pa izberimo le leta, kjer je bilo takih filmov več kot 10.

```sql
SELECT leto, COUNT(naslov) AS st_filmov
FROM filmi
WHERE ocena > 7
GROUP BY leto
HAVING st_filmov > 10;
```

**Pozor**:
* `WHERE` filtrira vrstice pred združevanjem (`GROUP BY`).
* `HAVING` filtrira skupine (torej po združevanju)


7. Kaj vrne spodnja poizvedba?

```sql
SELECT leto, naslov, AVG(ocena), SUM(dolzina)
FROM filmi
GROUP BY leto;
```

Za vsako leto vrne povprečno oceno in skupno dolžino filmov tega leta. Poleg izpiše še naslov enega od filmov (verjetno prvega, ki je za to leto zapisan v tabeli).

***Pozor**: Ko združimo vrednosti po skupinah, bomo v rezultatu dobili samo eno vrstico za vsako skupino. Stolpce, ki niso v `GROUP BY` moramo torej agregirati, da dobimo eno vrednost na skupino (`SUM`, `AVG`, `MIN`, ...).


Opomba: SQLite deluje tudi, če zgornjega ne upoštevamo - v teh stolpcih bo pač neka vrednost iz skupine, a ponavadi rezultat ni ravno smiseln. Izjema je na primer, če ima stolpec za vsako vrednost stopca v GROUP BY (npr. id filma), natanko eno možno vrednost (npr. naslov, ki se vedno ujema z id filma). Večinoma v to situacijo pridemo pri stikanju tabel (`JOIN`), kar bomo videli na vajah 4.

V drugih RDBMS lahko takšna poizvedba privede do napake pri izvajanju. Npr:

![alt text](napaka_pri_zdruzevanju.png)

(Stolpec name ni agregiran, ko podatke združimo po kontinentih.)