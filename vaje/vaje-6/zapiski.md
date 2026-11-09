# Ustvarjanje tabel

```sql
CREATE TABLE tabela (
  -- Lastnosti stoplcev
  stolpec1 tip
    [PRIMARY KEY]                       -- glavni ključ
    [NOT NULL]                          -- prepovedana vrednost NULL
    [UNIQUE]                            -- enolične vrednosti v stolpcu
    [CHECK (pogoj)]                     -- pogoj, ki mora veljati za stolpec
    [DEFAULT (vrednost)]                -- privzeta vrednost
    [REFERENCES druga_tabela(stolpec)], -- tuji ključ
  -- Ostale lastnosti tabele (če zadevajo več stolpcev)
  [PRIMARY KEY (st1, st2, ...),]        -- glavni ključ iz več stolpcev
  [UNIQUE (st1, st2, ...),]             -- enolične vrednosti v več stolpcih
  [CHECK (pogoj),]                      -- pogoj, ki vključuje več stolpcev
  [FOREIGN KEY (st1, st2, ...)          -- tuji ključ iz več stolpcev
     REFERENCES druga_tabela(s1, s2, ...),]
  ...
);
```

Določila v oglatih oklepajih so opcijska. Nabor, imena ter delovanje določil se lahko razlikujejo med različnimi tipi podatkovnih baz (RDBMS - npr. SQLite, MySQL, PostgreSQL, MariaDB, Microsoft SQL Server, Oracle Database, ...).

Tipi v `SQLite`:
* `INTEGER` - celo ševilo
* `REAL` - realno število
* `NUMERIC(p, s)`, `DECIMAL(p, s)` - decimalno število z določeno dolžino (`p` števk in `s` decimalnih mest).
* `TEXT` - niz
* `CHAR(n)`, `VARCHAR(n)` - omejena dolžina niza


Tipi za delo z datumom in časom v SQLite ne obstajajo
* `DATE` - datum (`YYYY-MM-DD`)
* `TIME` - čas (`hh:mm:ss`)
* `DATETIME` - datum in čas (`YYYY-MM-DD hh:mm:ss`)

Možne implementacije za delo z datumom in časom
* `TEXT` kot niz, npr. `"YYYY-MM-DD HH:MM:SS.SSS"` (pametno je uporabiti zapis skladen z ISO standardom).
* `REAL` kot število dni od poldneva na Greenwichu 24. 11. 4714 B.C. po Julijanskem koledarju.
* `INTEGER` kot število sekund od 1. 1. 1970 00:00:00 UTC (Unix Time).

Opombe (za SQLite):
* Določilo `PRIMARY KEY` vključuje določili `NOT NULL` in `UNIQUE`. Če gre za celoštevilski primarni ključ (`INTEGER`) avtomatsko poskrbi za prirejanje/povečevanje vrednosti, zato določilo `AUTOINCREMENT` za celoševilske primarne ključe ni potrebno. ([več o tem](https://www.sqlitetutorial.net/sqlite-primary-key/))
* Določili `FOREIGN KEY` in `REFERENCES` dovoljujeta manjkajoče vrednosti. Če jih želimo prepovedati, je potrebno dodati še `NOT NULL`.
* Če se tuji ključi (oz. njihove omejitve) ne obnašajo pravilno, je morda treba vključiti delo s tujimi ključi: `PRAGMA foreign_keys = ON`.