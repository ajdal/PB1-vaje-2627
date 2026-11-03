# Spreminjanje podatkov

## Vstavljanje podatkov

```sql
INSERT INTO tabela
(stolpec1, stolpec2)
VALUES (5, 'oddano'), (17, 'obdelano'), ...
```

Pozor:
* Pogosto se primarni ključ nastavi avtomatsko.
* Nekateri stolpci imajo privzeto vrednost.


```sql
INSERT INTO tabela
(stolpec1, stolpec2)
SELECT st1, 'oddano'
FROM tabela2
WHERE st3 = 12
```

## Posodabljanje podatkov

```sql
UPDATE tabela
SET stolpec1 = vrednost1, stolpec2 = (SELECT vr FROM tabela2 ....)
WHERE pogoj
```

## Brisanje podatkov

```sql
DELETE FROM tabela
WHERE pogoj
```

## Vaje z bazo filmov (1 tabela)

### Vstavljanje podatkov

TODO!