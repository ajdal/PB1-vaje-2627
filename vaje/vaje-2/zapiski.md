# Osnove SQL

Oblika osnovne SQL poizvedbe:
```sql
SELECT stolpec1, stolpec2, stolpec3 / 1000 AS ime_stolpca, ROUND(stolpec4, 3), stolpec5
FROM tabela
WHERE (stolpec1 = 'vrednost1' AND ime_stolpca LIKE '%vrednost_' OR ime_stolpca > 25) AND stolpec6 IN ('vzhod', 'zahod')
ORDER BY stolpec1 DESC, stolpec4
LIMIT 32;
```

Vrstni red je pomemben! Ne moremo, na primer, urejanja (`ORDER BY`) opraviti pred izbiro (`WHERE`).

## Ogrevanje z bazo `filmi`:

1. Izpišimo vse naslove filmov
```sql
TODO
```

2. Izpišimo vse naslove, dolžine in ocene
```sql
TODO
```

3. Uredimo izpis padajoče po ocenah
```sql
TODO
```

4. Zanimajo nas le filmi, ki so dolgi največ 2,5h
```sql
TODO
```


5. A taki, ki niso krajši od 2h
```sql
TODO
```

6. Zanima nas le prvih 20 takšnih filmov.
```sql
TODO
```

7. Dodatno filme uredimo še naraščajoče po trajanju
```sql
TODO
```

8. Stolpce uredimo po številu glasov na minuto filma.
```sql
TODO
```


9. Koliko glasov so skupno prejeli vsi filmi, katerih naslovi se začnejo z veliko tiskano črko A?
```sql
TODO
```


## Podpoizvedbe




### Primeri z bazo `filmi`

1. Filmi, ocenjeni bolje od povprečja.

```sql

```

2. Filmi z boljšo oceno kot najbolje ocenjen del Vojne zvezd.

```sql

```


3. Najbolje ocenjen film vsakega leta.

```sql

```

4. Filmi, ki so ocenjeni bolje od povprečja preteklih let.

```sql
TODO
```

5. Film, ki je najboljši in najbolje ocenjen v svojem letu.

```sql
TODO
```