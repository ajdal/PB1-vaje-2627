# Poskusni izpit

Rešene naloge po izbiri udeležencev vaj.

## 3. b - vstavi predmete, ki so na 1. in 2. stopnji
Za vsak predmet, ki se pojavi tako na prvi kot drugi stopnji (smer se začne z 1 oz. 2), dodajte nov predmet z istim imenom in smerjo 0Mate (stolpca id ne nastavljajte, ker se bo samodejno določil).

_Opomba: pri tem ni treba, da gre za isti program na obeh stopnjah_

**Ideja**: Začnemo s poizvedbo `SELECT`, ki izbere in pripravi podatke, preden podatke vstavljamo v tabelo.

1. Tabelo `predmeti` združimo samo s seboj, da dobimo pare vrstic z istim imenom predmeta.
```sql
SELECT *
FROM predmeti AS p1
    JOIN predmeti AS p2 ON p1.ime = p2.ime
```
Del dobljene tabele:

| id   | ime                              | smer  | id:1 | ime:1                          | smer:1|
|------|----------------------------------|-------|------|--------------------------------|-------|
| 997  | Parcialne diferencialne enačbe   | 1PrMa | 997  | Parcialne diferencialne enačbe | 1PrMa |
| 997  | Parcialne diferencialne enačbe   | 1PrMa | 1021 | Parcialne diferencialne enačbe | 2Mate |
| 998  | Podatkovne baze 1                | 1PrMa | 998  | Podatkovne baze 1              | 1PrMa |
| 999  | Praktično usposabljanje          | 1PrMa | 999  | Praktično usposabljanje        | 1PrMa |
| 1005 | Matematično modeliranje          | 1PrMa | 955  | Matematično modeliranje        | 1Mate |
| 1021 | Parcialne diferencialne enačbe	  | 2Mate | 997  | Parcialne diferencialne enačbe | 1PrMa |

Med vrsticami imamo takšne, kjer:
* sta `id` in `id:1` (`id` iz prve in druge tabele) enaka - takšne vrstice nas ne zanimajo (npr. prva vrstica)
* sta predmeta z enakim imenom predmeta na različnih smereh iste stopnje (npr. Matematično modeliranje je na `1PrMa` in `1Mate` ) - tudi te niso ustrezne
* pare vrstic, kjer je predmet iz `p1` na prvi stopnji in predmet iz `p2` na drugi in obratno (npr. Parcialne diferencialne enačbe na `1PrMa` in `2Mate`) - potrebujemo le polovico teh vrstic

2. Izmed dobljenih vrstic izberemo tiste, kjer se smer predmeta iz prve tabele (`p1`) začne z 1, smer predmeta iz druge tabele (`p2`) pa z 2. 
    * Ta pogoj iz rezultata odstrani vrstice, kjer je `p1.id` enak `p2.id` ter ohrani le enega izmed parov vrstic, kjer sta podatka zamenjana.

```sql
SELECT *
FROM predmeti AS p1
    JOIN predmeti AS p2 ON p1.ime = p2.ime
WHERE p1.smer LIKE '1%' AND p2.smer LIKE '2%';
```
Najdemo 6 ustreznih predmetov:

| id   | ime                                    | smer  | id:1 | ime:1                                  | smer:1|
|------|----------------------------------------|-------|------|----------------------------------------|-------|
| 948  | Verjetnost                             | 1Mate | 1263 | Verjetnost                             | 2UpSt |
| 973  | Kombinatorika                          | 1ISRM | 1031 | Kombinatorika                          | 2Mate |
| 994  | Verjetnost                             | 1PrMa | 1263 | Verjetnost                             | 2UpSt |
| 996  | Optimizacija                           | 1PrMa | 1265 | Optimizacija                           | 2UpSt |
| 997  | Parcialne diferencialne enačbe         | 1PrMa | 1021 | Parcialne diferencialne enačbe         | 2Mate |
| 4474 | Izračunljivost in računska zahtevnost  | 1ISRM | 34   | Izračunljivost in računska zahtevnost  | 2ISRM |

3. Za vsako izmed vrstic izberemo samo ime predmeta (iz ene od tabel, saj sta obe enaki) in dodamo še stolpec, ki bo predstavljal novo smer (`0Mate`), da pripravimo vse podatke za vstavljanje.
4. Ker se Verjetnost v tabeli pojavi dvakrat, poskrbimo, da dobimo le eno vrstico: izberemo imena predmetov brez ponavljanja (`DISTINCT`). _Opomba: na ta korak smo na vajah pozabili._
5. Rezultat poizvedbe vstavimo v tabelo `predmeti`.

```sql
INSERT INTO predmeti (ime, smer)
SELECT DISTINCT p1.ime, '0Mate'
FROM predmeti AS p1
    JOIN predmeti AS p2 ON p1.ime = p2.ime
WHERE p1.smer LIKE '1%' AND p2.smer LIKE '2%';
```

Preverimo, da spodnja poizvedba vrne 5 vrstic za predmete Verjetnost, Kombinatorika, Optimizacija, Parcialne diferencialne enačbe ter Izračunljivost in računska zahtevnost:
```sql
SELECT * FROM predmeti WHERE smer = '0Mate';
```

## 4. b - predmeti s seminarjem in brez vaj

Vrnite ID-je, imena in smeri predmetov, za katere se izvaja seminar, ne pa tudi
avditorne ali laboratorijske vaje.

**Pogosta napaka**:

```sql
SELECT predmeti.id, ime, smer
FROM predmeti
    JOIN dodelitve ON predmet = predmeti.id
    JOIN skupine ON skupine.id = skupina
WHERE tip = 'S' AND tip NOT IN ('V', 'L');
```
**Pozor: `WHERE` deluje po vrsticah, vsaki vrstici (skupini) pripada natanko en tip!**
* če je enak `S`, bo prvi del pogoja resničen (`tip = 'S'`), prav tako pa tudi drugi del (`tip NOT IN ('V', 'L')`),
* če je karkoli drugega, bo prvi del pogoja neresničen (`tip <> 'S'`), drugi del pogoja zato niti ni pomemben (za `P` bi bil resničen, za `V` in `L` pa ne),
* => dobili bomo torej vse predmete, ki imajo seminar (vrstice se lahko ponavljajo)



### 1. ideja: izbira ustreznih id-jev (zapisana v uradni rešitvi na spletni učilnici)

S podpoizvedbami poiščemo id-je predmetov s seminarjem ter id-je predmetov z vajami. V glavni poizvedbi nato poiščemo tiste predmete, ki se nahajajo v prvem seznamu id-jev, ne pa tudi v drugem seznamu id-jev.

```sql
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
```

Če smo suvereni z uporabo ukaza `WITH`, lahko ekvivalenten rezultat dosežemo tudi tako, da z WITH ustvarimo dve začasni "tabeli", na kateri se potem sklicujemo v poenostavljeni glavni poizvedbi:

```sql
WITH predmeti_seminar AS (
    SELECT predmet
    FROM dodelitve JOIN skupine ON skupine.id = skupina
    WHERE tip = 'S'
), predmeti_vaje AS (
    SELECT predmet
    FROM dodelitve JOIN skupine ON skupine.id = skupina
    WHERE tip IN ('V', 'L')
)
SELECT id, ime, smer
FROM predmeti
WHERE id IN predmeti_seminar
    AND id NOT IN predmeti_vaje;
```

### 2. ideja: združevanje in izbira vrstic

Ustvarimo staknjeno tabelo predmetov (da jih lahko izpišemo z imenom in smerjo), dodelitev (povezovalna) in skupin (da lahko preverimo tip skupin). V vsaki skupini preštejemo vse skupine tipa `S` in skupine tipov `V` ali `L`. Prva vsota mora biti večja od nič (predmet ima vsaj eno skupino seminarja), druga pa mora biti enaka nič (nobena skupina ni `V` ali `L`). Izberemo le tiste skupine (`HAVING`), ki ustrezajo pogoju.

```sql
SELECT predmeti.id, ime, smer
FROM predmeti
    JOIN dodelitve ON predmet = predmeti.id
    JOIN skupine ON skupine.id = skupina
GROUP BY predmeti.id, ime, smer
HAVING 
    SUM(CASE WHEN tip = 'S' THEN 1 ELSE 0 END) > 0 
    AND SUM(CASE WHEN tip IN ('V', 'L') THEN 1 ELSE 0 END) = 0;
```

| predmeti.id | ime                        | smer  |
|-------------|----------------------------|-------|
| 887         | Seminar                    | 1FiMa |
| 890         | Diplomski seminar          | 1FiMa |
| 902         | Monetarna ekonomija        | 1FiMa |
| 927         | Komuniciranje v matematiki | 1PrMa |
| 936         | Seminar                    | 1Mate |
| 944         | Diplomski seminar          | 1Mate |
| 999         | Praktično usposabljanje    | 1PrMa |
| 1011        | Matematični seminar        | 2Mate |
| 1074        | Delovna praksa 1           | 2Mate |
| 1160        | IŠRM seminar               | 2ISRM |
| 1221        | Pedagoška praksa 1         | 2PeMa |
| 1230        | Didaktika matematike 1     | 2PeMa |
| 1232        | Seminar 1                  | 2PeMa |
| 1233        | Seminar 2                  | 2PeMa |


**Kaj se dogaja?** \
Izpišimo rezultat poizvedbe pred združevanjem (`GROUP BY`) in poglejmo vrednosti v stolpcih `CASE1` in `CASE2` v povezavi s tipom:

```sql
SELECT predmeti.id, ime, smer, skupina, tip, CASE WHEN tip = 'S' THEN 1 ELSE 0 END AS CASE1, CASE WHEN tip IN ('V', 'L') THEN 1 ELSE 0 END AS CASE2
FROM predmeti
    JOIN dodelitve ON predmet = predmeti.id
    JOIN skupine ON skupine.id = skupina
ORDER BY ime;
```

| predmeti.id | ime                                | smer  | skupina | tip | CASE1 | CASE2 |
|-------------|------------------------------------|-------|---------|-----|-------|-------|
| 890         | Diplomski seminar                  | 1FiMa | 767     | S   | 1     | 0     |
| 890         | Diplomski seminar                  | 1FiMa | 768     | S   | 1     | 0     |
| 890         | Diplomski seminar                  | 1FiMa | 769     | S   | 1     | 0     |
|-------------|------------------------------------|-------|---------|-----|-------|-------|
| 1186        | Informacijska varnost in zasebnost | 2ISRM | 3928    | P   | 0     | 0     |
| 1186        | Informacijska varnost in zasebnost | 2ISRM | 3929    | L   | 0     | 1     |
| 1186        | Informacijska varnost in zasebnost | 2ISRM | 3930    | L   | 0     | 1     |
| 1186        | Informacijska varnost in zasebnost | 2ISRM | 3931    | L   | 0     | 1     |
|-------------|------------------------------------|-------|---------|-----|-------|-------|
| 30          | Finančni praktikum                 | 1FiMa | 795     | P   | 0     | 0     |
| 30          | Finančni praktikum                 | 1FiMa | 796     | V   | 0     | 1     |
| 30          | Finančni praktikum                 | 1FiMa | 797     | S   | 1     | 0     |
|-------------|------------------------------------|-------|---------|-----|-------|-------|
| 902         | Monetarna ekonomija                | 1FiMa | 1171    | P   | 0     | 0     |
| 902         | Monetarna ekonomija                | 1FiMa | 1172    | S   | 1     | 0     |

* Diplomski seminar (1FiMa): 3 skupine seminarja, v stolpcu CASE1 so tri enice (vse vrstice imajo tip `S`), v stolpcu CASE2 pa tri ničle (nobena vrstica nima tipa `L` ali `V`). Ob združevanju po predmetu in agregaciji stolpcev CASE1 in CASE2 s funkcijo `SUM`, za prvi stolpec dobimo 3, za drugi pa 0. Pogoj v `HAVING` bo torej resničen (vsota CASE1 > 0, vsota CASE2 pa = 0), zato skupino ohranimo.
* Informacijska varnost in zasebnost: 1 skupina predavanja in 3 skupine laboratorijskih vaj. Vsota CASE1 bo 0, vsota CASE2 pa 3, zato skupina ne ustreza zahtevi v `HAVING`.
* Finančni praktikum: 3 skupine - 1 predavanje, 1 (avditorne) vaje in 1 seminar - ker ima avditorne vaje ni ustrezna.
* Monetarna ekonomija: 1 predavanje in 1 seminar - nima vaj, zato je ustrezna.

