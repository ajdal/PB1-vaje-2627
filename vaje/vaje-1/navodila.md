# Git in GitHub

## 1. Priprava

Če ste z gitom že delali ali pa uporabljate šolski računalnik, boste morda katerega od prihodnjih delov preskočili.

Če že imate račun na [GitHub](https://github.com), se prijavite vanj, sicer ustvarite nov račun. Priporočam, da za uporabniško ime izberete ime, za katerega vam ne bo nerodno, če si bo vaš profil kdaj v prihodnosti ogledoval potencialni delodajalec.

### Namestitev GIT

- Če uporabljate Windowse, s spletne strani [https://git-scm.com/downloads](https://git-scm.com/downloads) prenesite namestitveno datoteko za svoj sistem. Pri namestitvi lahko klikate "Next", saj so prednastavljene nastavitve dovolj dobre.
- Če uporabljate Linux, sledite navodilom, kako git namestite s pomočjo upravljalca paketov.
- Če uporabljate macOS, je najlažji način za namestitev preko [homebrew](https://brew.sh/) (če ga še nimate, ga najprej namestite z navodili na spletni strani) z ukazom `brew install git`.


### Preverite, da namestitev deluje.

- V ukazno vrstico vpišite ukaz `git --version`, ki mora izpisati nekaj v smislu: `git version 2.XX.Y (ime sistema)`.
- Na Windowsih preverite tudi delovanje aplikacije Git GUI. Lahko jo najdete med vsemi programi, najlažje pa jo zaženete iz raziskovalca. Držite tipko `shift` in na prazno območje kliknite z desnim miškinim gumbom, kjer potem izberite Git GUI.

### SSH Ključi

Za enostavnejšo uporabo gita si ustvarite svoj SSH ključ. Pri tem si lahko pomagamo z GitGUI, kjer pod zavihkom `Help` najdemo možnost `Show SSH Key`, kjer lahko ključ generiramo (ali pa uporabimo obstoječega). Predlagamo, da ne nastavite gesla za ključ (nastavite prazno geslo), saj ima VSCode občasno težave z gesli.

Če ne uporabljate operacijskega sistema Windows (ali pa vas zabava delo v ukazni vrstici), v terminal vpišite `ssh-keygen -t rsa -C "your_email@example.com"` (kjer email zamenjate s tistim, ki ste ga uporabili za Github račun) in pritisnete `enter`, da ključ generirajo na privzeti lokaciji. Javni ključ se nahaja na `~/.ssh/id_rsa.pub` - odprite ga in skopirajte.

Ključ dodamo na uporabniški račun s primernim imenom (npr. `osebni-racunalnik`).

Če želite zamenjati geslo, s katerim ste zaščitili privatni ključ (ali ga odstraniti), lahko to storite z ukazom `ssh-keygen -p`. V prvem koraku izberete lokacijo datoteke s ključem. Če ste ključ generirali z GitGUI, lahko za lokacijo izberete kar prazno, saj bo sam izbral privzeto mesto.

## 2. Vaje

Vaje bomo izvajali vodeno in sočasno (prosim, ne prehitevajte), da lahko skupaj obdelamo najpogostejše scenarije dela z gitom.

V okviru teh vaj bomo na repozitoriju naredili popoln kaos (ker nas je ogromno in vsi delamo hkrati!) in stvari bodo verjetno šle narobe - ampak jih bomo rešili. Upam, da bodo vse težave, na katerem naletite pri delu v parih na seminarski nalogi, v primerjavi s tem minimalne.


### Za dostop

Na GitHub odprite zavihek "Issues" in izberite težavo z naslovom "Dodaj sodelavce". V odgovoru zapišite svoje GitHub uporabniško ime in me označite (`@ajdal`). Počakajte, da vam dodelim dostop za urejanje repozitorija in sprejmite povabilo.

### Kloniranje repozitorija

Na svoj računalnik klonirajte tale repozitorij.


### Beleženje zgodovine v gitu

V imeniku `vaje/vaje1/sodelavci` ustvarite datoteko z imenom `<up_ime>.md`, kjer `<up_ime>` nadomešča vaše uporabniško ime. Zame bo to `ajdal.md`, vi pa vstavite svoje uporabniško ime. 

V datoteko kot naslov zapišite svoje uporabniško ime, nato pa po točkah odgovore na vprašanja:

```
1. Najljubši programski jezik:
2. Izkušnje z gitom:
3. Koliko mi je všeč git (1-10):
```

Na konec datoteke dodajte še 4. vprašanje, ki se nanaša na preference glede katerekoli poljubne stvari in nanj **ŠE NE** odgovorite (npr. `"Kava ali čaj:"`, `"Najljubša barva:"`, `"Počitnice na morju ali v hribih:"`)

Datoteko nato dodajte v git in jo pošljite na strežnik. Se pri tem pojavi kakšna težava? Kako bi jo rešili?


### Reševanje konflikta 😱
Izberite si enega od kolegov s katerim bosta simulirala konflikt. Dogovorita se, kdo bo prvi reševal konflikt (v nadaljevanju `Š1`) in kdo bo mešal štrene (v nadaljevanju `Š2`):

1. `Š1` odpre Markdown datoteko v imeniku `sodelavci`, ki jo je ustvaril `Š2` in odgovorite na 4. vprašanje. `Š1` ustvari nov "commit" (in mu doda neko smiselno sporočilo).
2. `Š2` odgovori na isto vprašanje, a z drugačnim odgovorom. Tudi `Š2` ustvari nov "commit" s smiselnim sporočilom.
3. `Š1` 'potisne' spremembo na GitHub (pull+push/sync).
4. `Š2` poskusi spremembo naložiti na GitHub.
5. Če pri tem pride do napake, jo s pomočjo urejevalnika odpravi, ponovno naredi "commit" in kodo 'potisne' na GitHub.
6. Nato zamenjata vlogi in ponovita postopek.


### Delo z vejami (branch) in težavami (issue)

1. Na GitHubu odprite zavihek Issues in si izberite eno izmed težav (issue), ki je še nihče ni izbral in si jo dodelite (assign yourself).
2. V VS Code ustvarite novo vejo (branch). Izbrano težavo rešite z dvema ločenima "commitoma". Tj.: rešite 1. točko, ustvarite commit in nato še 2. točko, za katero prav tako ustvarite commit. Na oddaljeni repozitorij (GitHub) ju lahko "potisnete" ločeno ali pa naenkrat.
3. Ko zaključite z reševanjem težave, ustvarite Pull Request (v ime dodajte besedilo `Closes #st`, kjer `st` nadomestite s številko težave, ki ste jo rešili). Po potrebi razrešite konflikte in vejo združite z glavno (`main`).

Če zmanjka "težav" (issues), si lahko izmislite svojo, vezano na "projekt" v imeniku `koda` ali pa dopolnite ta navodila s kakšnimi ukazi ali težavami. Lahko pa tudi pomagate komu od kolegov.


## 3. Git ukazi

Sem bomo (verjetno) dodali uporabne ukaze za delo z gitom (in posnetke zaslona za VSCode gui).



## 4. Git prva pomoč

Če se vam pojavi kakšna (predvsem nepričakovana) težava, naredite posnetek zaslona in ga dodajte v imenik `tezave-screenshots` in jo vključite v tem dokumentu (glej zgled). Če težave niste znali rešiti sami, ustvarite Issue. To velja tudi za vse nadaljnje delo z Gitom.