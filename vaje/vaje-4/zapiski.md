# Stikanje

```sql
SELECT stolpci
FROM tab1
   [NATURAL] [LEFT | RIGHT | FULL] JOIN tab2 [ON pogoj | USING (stolpci)]
WHERE pogoj
GROUP BY stolpci
HAVING pogoj
ORDER BY stolpci
LIMIT stevilo
```

* `ON pogoj` - poveže vrstice iz obeh tabel, kjer velja pogoj (npr. `ON oseba.id = vloga.oseba`)
* `USING` - stakne po istoimenskih stolpcih v obeh tabelah, ki jih navedemo (npr. `USING id`)
* `NATURAL JOIN` - stakne po vseh istoimenskih stolpcih v obeh tabelah. Pogoja stikanja potem ne navajamo. Moramo pa biti previdni, saj lahko poveže tudi stolpce, za katere tega ne želimo.
* stikanje se izvede pred filtriranjem z `WHERE`!


## Različni tipi stikanja

Dano imamo podatkovno bazo naročil s tabelama `stranka` in `narocilo`.

Tabela `stranka`:
| id | ime    |
|----|--------|
| 1  | Alenka |
| 2  | Branko |
| 3  | Cvetka |
| 4  | David  |

Tabela `narocilo`:
| id | kolicina | stranka |
|----|----------|---------|
| 1  | 500      | 2       |
| 2  | 300      | 6       |
| 3  | 800      | 2       |
| 4  | 150      | 1       |
| 5  | 400      | 4       |

Povezati želimo količino naročenih izdelkov z imeni strank.

### Notranji stik (INNER JOIN)

Pridobiti želimo le vrstice, za katere poznamo vnos tako v levi kot v desni tabeli.

```sql
SELECT *
FROM stranka
    JOIN narocilo ON stranka.id = narocilo.stranka
```

Če izberemo vse stolpce (`*`), poizvedba vrne vse stolpce iz prve (`stranka`), nato pa še vse stolpce iz druge tabele (`narocilo`), za vrstice, kjer se id stranke ujema s stolpcem stranka v tabeli `narocilo`:

| id | ime    | id:1 | kolicina | stranka |
|----|--------|------|----------|---------|
| 2  | Branko | 1    | 500      | 2       |
| 2  | Branko | 3    | 800      | 2       |
| 1  | Alenka | 4    | 150      | 1       |
| 4  | David  | 5    | 400      | 4       |

_Opomba:_ Pri izpisu je stolpec `id` iz tabele `narocilo` označen kot `id:1`, da ločimo enako poimenovana stolpca iz obeh tabel (tako bo izgledal tudi rezultat v SQLite Studiu).

V stavku `SELECT` lahko torej izberemo katerikoli stolpec iz te staknjene tabele.
Denimo, da želimo prikazati le ime stranke, id naročila in količino:

```sql
SELECT ime, narocilo.id AS narocilo_id, kolicina
FROM stranka
    JOIN narocilo ON stranka.id = narocilo.stranka
```
Poizvedba vrne:

| ime    | narocilo_id | kolicina |
|--------|-------------|----------|
| Alenka | 4           | 150      |
| Branko | 1           | 500      |
| Branko | 3           | 800      |
| David  | 5           | 400      |

Ker se stolpec `id` nahaja tako v tabeli `stranka`, kot v tabeli `narocilo`, moramo povedati, iz katere tabele želimo pridobiti stolpec `id` → `narocilo.id`. V izogib napakam, stolpec v rezultatu poimenujemo `narocilo_id`.

### Zunanji stik (OUTER JOIN)

Ločimo tri vrste zunanjih stikov.

**Levi zunanji stik** (`LEFT OUTER JOIN`) ohrani vse vrstice iz prve tabele – vse stranke:

```sql
SELECT *
FROM stranka
    LEFT JOIN narocilo ON stranka.id = narocilo.stranka
```

| id | ime    | id:1 | kolicina | stranka |
|----|--------|------|----------|---------|
| 1  | Alenka | 4    | 150      | 1       |
| 2  | Branko | 1    | 500      | 2       |
| 2  | Branko | 3    | 800      | 2       |
| 3  | Cvetka | NULL | NULL     | NULL    |
| 4  | David  | 5    | 400      | 4       |

Ker Cvetka ni opravila nobenega naročila, stolpci iz desne tabele (`narocilo`) dobijo vrednost `NULL`.

**Desni zunanji stik** (RIGHT OUTER JOIN) ohrani vse vrstice iz druge tabele - vsa naročila:

```sql
SELECT *
FROM stranka
    RIGHT JOIN narocilo ON stranka.id = narocilo.stranka
```

| id | ime    | id:1 | kolicina | stranka |
|----|--------|------|----------|---------|
| 1     | Alenka    |	4 |	150 | 1 |
| 2     | Branko    |	1 |	500 | 2 |
| 2     | Branko    |	3 |	800 | 2 |
| 4     | David     |	5 |	400 | 4 |
| NULL  | NULL      |	2 |	300 | 6 |

Opazimo, da se ohrani vrstni red iz leve tabele.

**Polni zunanji stik** (FULL OUTER JOIN) ohrani vse vrstice iz obeh tabel:

```sql
SELECT *
FROM stranka
    FULL JOIN narocilo ON stranka.id = narocilo.stranka
```

| id | ime    | id:1 | kolicina | stranka |
|----|--------|------|----------|---------|
| 1  | Alenka | 5    | 150      | 1       |
| 2  | Branko | 2    | 500      | 2       |
| 2  | Branko | 4    | 800      | 2       |
| 3  | Cvetka | NULL | NULL     | NULL    |
| 4  | David  | 5    | 400      | 4       |
| NULL| NULL   |	2    | 300      | 6       |



## Uporaba USING

Če želimo združiti po stolpcu, ki ima v obeh tabelah enako ime, lahko namesto pogoja `ON` uporabimo `USING`, ki mu podamo ime stolpca.

V zgornjih tabelah to nima veliko smisla. Če poskusimo takole:

```sql
SELECT ime, narocilo.id AS narocilo_id, kolicina
FROM stranka
    JOIN narocilo ON stranka.id = narocilo.stranka
```
Poizvedba vrne:

| id | ime    | kolicina | stranka |
|----|--------|----------|---------|
| 1  | Alenka | 500      | 2       |
| 2  | Branko | 300      | 6       |
| 3  | Branko | 800      | 2       |
| 4  | David  | 150      | 1       |

Povezali smo vrstice, kjer je id stranke enak id naročila - kar nima smisla.

Uporaba `USING` bi bila smiselna, če bi npr. stolpca z is stranke v obeh tabelah poimenovali `stranka_id` (ali pa `id_stranka` ali kaj podobnega):

Tabela `stranka`:
| stranka_id | ime    |
|------------|--------|
| 1          | Alenka |
| 2          | Branko |
| 3          | Cvetka |
| 4          | David  |

Tabela `narocilo`:
| id | kolicina | stranka_id |
|----|----------|------------|
| 1  | 500      | 2          |
| 2  | 300      | 6          |
| 3  | 800      | 2          |
| 4  | 150      | 1          |
| 5  | 400      | 4          |


Potem ukaz
```sql
SELECT *
FROM stranka
    FULL JOIN narocilo USING(stranka_id)
```
naredi podobno kot prej pri polnem zunanjem stiku

## Primeri z bazo `filmi`

1. Izpiši naslove filmov in njihove žanre, za vsak žanr ena vrstica

```sql
SELECT naslov, naziv
FROM film
    JOIN pripada ON film.id = pripada.film
    JOIN zanr ON pripada.zanr = zanr.id;
```

2. Izpiši naslove zgodovinskih filmov.

```sql
SELECT naslov, naziv
FROM film
    JOIN pripada ON film.id = pripada.film
    JOIN zanr ON pripada.zanr = zanr.id
WHERE naziv = 'History';
```

3. Naslovi filmov in imena glavnih igralcev (urejeno po imenih, nato pa po naslovih).

```sql
SELECT naslov, ime, ocena
FROM film
    JOIN vloga ON film.id = vloga.film
    JOIN oseba ON vloga.oseba = oseba.id
WHERE mesto = 1 AND tip = 'I'
ORDER BY ime, naslov;
```


4. Za vsakega režiserja (izpišite ga z IDjem in imenom) izpišite skupno dolžino filmov, ki jih je režiral (brez igranja). Rezultate uredite po imenu režiserja.

```sql
SELECT oseba.id, ime, SUM(dolzina)
FROM film
    JOIN vloga ON film.id = vloga.film
    JOIN oseba ON vloga.oseba = oseba.id
WHERE tip ='R'
GROUP BY oseba.id, ime
ORDER BY ime;
```


5. Za vsak žanr (izpišite ga z imenom) izpišite število različnih igralcev in število različnih režiserjev, ki so sodelovali pri filmih tega žanra. Rezultate uredite padajoče po vsoti števila igralcev in števila režiserjev (če se nekdo pojavi tako kot igralec kot režiser, se tukaj šteje dvakrat).

```sql
SELECT zanr.naziv, 
    COUNT(DISTINCT CASE WHEN vloga.tip = 'I' THEN oseba.id END) AS st_igralcev, 
    COUNT(DISTINCT CASE WHEN vloga.tip = 'R' THEN oseba.id END) AS st_reziserjev, 
    COUNT(DISTINCT oseba.id) AS st_razlicnih_oseb -- samo za preverjanje
FROM film
    JOIN vloga ON vloga.film = film.id
    JOIN oseba ON vloga.oseba = oseba.id
    JOIN pripada ON pripada.film = film.id
    JOIN zanr ON zanr.id = pripada.zanr
GROUP BY zanr.id;
```