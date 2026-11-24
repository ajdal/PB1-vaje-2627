# Načrtovanje podatkovnih baz

Okviren postopek načrtovanja podatkovne baze:

1. Opis problema in razumevanje zahtev.
2. Identifikacija entitetnih tipov in atributov.
3. Identifikacija relacij in določitev števnosti.
4. Risanje ER-diagrama.
5. Pretvorba konceptualnega modela v relacijski model.
6. Preverjanje in normalizacija relacijskega modela.
7. Določitev domen, omejitev in drugih pravil.
8. Implementacija podatkovne baze.

V vsakem koraku lahko odkrijemo nejasnosti ali težave, zaradi katerih se moramo vrniti na prejšnji korak. Načrtovanje zato ni povsem linearen postopek, temveč se model postopoma izboljšuje.

## Konceptualni model

Konceptualni model opisuje, katere podatke želimo hraniti in kako so ti podatki med seboj povezani. Pri tem se še ne ukvarjamo s podrobnostmi konkretnega sistema za upravljanje podatkovnih baz.

### Opis problema in razumevanje zahtev

Najprej moramo razumeti, kaj želimo s podatkovno bazo podpreti.

Pri analizi problema si pomagamo z dvema skupinama vprašanj:

**Funkcionalnost**
- Kaj mora sistem omogočati?
- Katere operacije bodo uporabniki izvajali?
- Katere informacije bodo uporabniki potrebovali?

**Podatki**
- Katere podatke mora sistem hraniti?
- Katere informacije morajo biti na voljo tudi po zaključku posamezne operacije?
- Katera pravila veljajo za podatke?

#### Primer: knjižnica

Manjša knjižnica želi izboljšati vodenje svoje zbirke in izposoje gradiva. Trenutno si zaposleni pomagajo z različnimi preglednicami, zato je težko ugotoviti, katero gradivo je na voljo, kdo si ga je izposodil in ali je bilo že vrnjeno.

Ob obisku knjižnice se lahko oseba včlani. Zaposleni ob vpisu zabeležijo njene podatke, da jo lahko pozneje prepoznajo in spremljajo njene izposoje.

Knjižnica ima v svoji zbirki različne knjige. Nekatere knjige ima v več izvodih, saj si lahko isto knjigo hkrati izposodi več članov. Zaposleni morajo zato vedeti, koliko izvodov posamezne knjige imajo in kje se nahajajo.

Člani si lahko izposojajo gradivo in ga pozneje vrnejo. Zaposleni želijo imeti pregled nad tem, kaj je trenutno izposojeno, kdo si je posamezno gradivo izposodil in kdaj je bilo izposojeno. Pomembno jim je tudi, da lahko preverijo pretekle izposoje, ne samo trenutnega stanja.

Pri iskanju knjig bi radi vedeli tudi, kdo jih je napisal, saj člani pogosto iščejo dela določenega avtorja. Knjižnica želi omogočiti iskanje tako po podatkih o knjigi kot po njenih avtorjih.

Na podlagi opisa pripravite predlog podatkovnega modela, ki bi knjižnici omogočal podporo opisanim dejavnostim.

**Vprašanja:**
1. Katere funkcionalnosti mora podpirati sistem?
- vpis člana
- izposoja in vračilo knjige
- pregled izposojenih knjig
- pregled preteklih izposoj
- iskanje po avtorju

2. Katere informacije bi morali shraniti, da bi lahko odgovorili na vprašanja zaposlenih?
- člani, knjige, izvodi, čas izposoje in vračila, avtorji


### Identifikacija entitetnih tipov in atributov

Ko razumemo problem, določimo, katere podatke moramo hraniti.

**Entitetni tip** predstavlja skupino objektov ali pojmov, o katerih želimo hraniti podatke. Posamezen objekt imenujemo entiteta.

Pri iskanju entitetnih tipov si pomagamo z vprašanji:
- Katere glavne pojme omenjajo zahteve?
- O katerih objektih želimo hraniti več podatkov?
- Kateri pojmi imajo lastnosti, ki jih moramo beležiti?

Za vsak entitetni tip določimo njegove **atribute** oziroma lastnosti.

Nato določimo, kako lahko posamezno entiteto enolično prepoznamo. Za to uporabimo **identifikator** (ključ).

Pri izbiri identifikatorja upoštevamo:
- identifikator mora enolično določati posamezno entiteto;
- identifikator ne sme biti odvisen od podatkov, ki se lahko pogosto spreminjajo;
- po možnosti izberemo preprost in stabilen identifikator.

V knjižnici:

Član: ime, priimek, identifikator, kontakt, št_izposojenih
    - kandidati za id: 1...n; članska številka
Knjiga: naslov, avtor, identifikator
    - kandidati za id: 1...n; ISBN
Izvod: identifikator, knjiga, status
Izposoja: član, izvod, čas izposoje, čas vračila
    - id 1...n



### Identifikacija relacij in števnosti

Entitetni tipi so med seboj povezani. Te povezave imenujemo **relacije**.

Pri vsaki relaciji določimo:
- najmanjše število povezav (minimalna števnost);
- največje število povezav (maksimalna števnost).

Minimalna števnost pove, ali je sodelovanje entitete v relaciji obvezno ali neobvezno. Maksimalna števnost pove, koliko entitet je lahko povezanih.

Običajne oznake:
- `0..1` – nič ali ena;
- `1..1` – natanko ena;
- `0..N` – nič ali več;
- `1..N` – ena ali več.

Pri določanju števnosti si pomagamo z vprašanji:
- Ali mora vsaka entiteta sodelovati v tej relaciji?
- Ali lahko sodeluje v več povezavah?
- Ali lahko obstaja brez povezave?

### Risanje ER-diagrama

Na podlagi identificiranih entitetnih tipov, atributov in relacij narišemo **ER-diagram** (diagram entitet in relacij).

ER-diagram predstavlja grafični prikaz konceptualnega modela podatkovne baze.

Pri risanju:
- entitetne tipe prikažemo kot pravokotnike;
- atribute prikažemo kot lastnosti entitetnih tipov;
- identifikatorje ustrezno označimo;
- relacije prikažemo s povezavami;
- pri povezavah označimo minimalno in maksimalno števnost.

Narišimo ER-diagram za zgornji primer knjižnice.

**Vprašanja za preverjanje modela:**
- Ali ima vsak entitetni tip ustrezen identifikator?
- Ali so vsi potrebni podatki predstavljeni?
- Ali so vse zahtevane relacije vključene?
- Ali so števnosti skladne z opisom problema?
- Ali smo kakšen pojem napačno predstavili kot atribut, čeprav bi moral biti samostojen entitetni tip?
- Ali smo kakšno relacijo napačno predstavili kot atribut?