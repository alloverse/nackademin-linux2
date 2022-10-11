---
marp: true
title: Linux 2 DEVOPS21, Lektion 11/12
theme: gaia
paginate: true
footer: Nackademin HT 2022 • Linux 2 DEVOPS21 • Alloverse AB
---
<!-- _class: - gaia -->

# <!--fit--> Linux 2 <br> DEVOPS 2021 
## Lektion 11/12

---

# Idag

* Redovisningar av gruppuppgift
* Inför tentan
* Repetitionsövningar

---
<!-- _class: - invert - gaia - lead -->
# <!--fit--> Redovisningar
# (onsdag)
---
<!-- _class: - invert - lead -->
# <!--fit--> Grupp 02
# David Heidenberg, Oliver Matta, Patrik Sörensen, Ludwig Wahl, Marcus Gudmundsson
---
<!-- _class: - invert - lead -->
# <!--fit--> Grupp 03
# Fredik Majberg, David Remahl, Fredrik Sergler

---
<!-- _class: - invert - lead -->
# <!--fit--> Grupp 05
# Robert Ernlund, Victor Lager, Rasmus Regnell Jansson
---
<!-- _class: - invert - lead -->
# <!--fit--> Grupp 01
# Jonatan Bredenfeldt, Simon Kjellander, Jack Wirz, Bhakti Aryal

---
<!-- _class: - invert - lead -->
# <!--fit--> Grupp 04
# Yahya Al-Hammami, Mattias Bahnan, Martin Löf, Elliot Vikström

---
<!-- _class: - invert - gaia - lead -->
# <!--fit--> Redovisningar
# (torsdag, distans)
---
<!-- _class: - invert - lead -->
# <!--fit--> Grupp 06
# Oscar Brolin, Oskar Kuczynski, Isak Jansson, Cleodileia da Silva Vargas
---
<!-- _class: - invert - lead -->
# <!--fit--> Grupp 09
# Raheleh Mohebbi, Olof Backman, Josef, Battal Kayhan

---
<!-- _class: - invert - lead -->
# <!--fit--> Grupp 08
# Jonatan Norrby, Lukas Rozenek, kodrat mohammad, Carl Ringheim

---
<!-- _class: - invert - lead -->
# <!--fit--> Grupp 10
# Alexander Haddad

---
<!-- _class: - invert - lead -->
# <!--fit--> Grupp 07
# Tomas Zaia, Erhan Cömert, Ousman Senghore



---
<!-- _class: - invert - gaia - lead -->
# <!--fit--> Inför tentan
---

# Inför tentan

* Salstentamen
* 42 flervalsfrågor, 1 poäng per fråga
* G: 21 poäng
* VG: 32 poäng

---

# Typer av frågor

* Vad blir effekten av ett visst kommando eller script?
* Vad betyder ett begrepp eller en förkortning?
* Vilket kommando skall man använda för att ...
* Vad är rätt default directory / default fil för ...
* Vilken daemon används när ...

---

<style scoped> 
    code { font-size: 17pt; }
    li, p { font-size: 21pt; } 
    ol { list-style-type: upper-alpha; }
</style>

# Exempelfråga 1

Vad gör följande script?

```bash
#!/usr/bin/env bash
myfile=/tmp/myexample.log;
timestamp=`date +%Y-%m-%d_%H-%M-%S`;
echo $timestamp ": started" >>$myfile;
```

1. Skriver en tidsstämpel + texten ”: started” i slutet på filen `/tmp/myexample.log`
2. Skriver över filen `/tmp/myexample.log` med texten ”: started”
3. Ställer om datorns klocka till en tid som anges som inparameter
4. Skriver ut en tidsstämpel på stdout och skriver ”: started” i filen `/tmp/myexample.log`

---

<style scoped> ol { list-style-type: upper-alpha; }</style>

# Exempelfråga 2

Vad menas med driftsäkerhet?

1. Att man har koll på vem som kan logga in på servern
1. Att systemet är uppe och tillgängligt
1. Att man har koll på vem som kan ta sig in i lokalerna
1. Att systemet presenterar rätt information

---
<style scoped> ol { list-style-type: upper-alpha; }</style>

# Exempelfråga 3

Vilket kommando används för att låsa kontot så att användare haddock inte kan logga in?

1. `passwd sudo haddock`
1. `lock -pwd haddock`
1. `passwd -l haddock`
1. `lock -u haddock`

---
<style scoped> ol { list-style-type: upper-alpha; }</style>

# Exempelfråga 4

I vilken fil loggar Ubuntu misslyckade inloggningsförsök?

1. `/var/log/attempt`
1. `/var/log/logins`
1. `/var/log/faillog`
1. `/var/log/dmesg`

---
<style scoped> ol { list-style-type: upper-alpha; }</style>

# Exempelfråga 5

Vilken bakgrundsprocess behöver vara igång för att man skall kunna logga på servern med ssh?

1. `ftpd`
1. `sshd`
1. `cupsd`
1. `crond`

---

<!-- _class: - invert - lead -->
# <!--fit--> Repetition
---

# Repetitionsövning 1

* Gör ett skript som tar ett directorynamn som inparameter
* Om detta directory inte existerar, skall skriptet ge ett felmeddelande och avslutas
* Om detta directory existerar, skall skapa tio tomma filer i directoryt, med namnen fil1 – fil10.

---

# Repetitionsövning 1: Lösning

```bash
#!/usr/bin/env bash
dir=$1
if [ ! -d $dir ]
then
    echo "No directory " $1
    exit
else
    for i in {1..10}
    do
        touch $1/fil$i
    done
fi
```

---

# Repetitionsövning 2

* Antag att ni har MySQL på servern och en databas som heter mydb1
* Implementera backup av en ögonblicksbild av databasen till en fil under /var/backups en gång i timmen kl 8-18 alla vardagar
* Implementera även att dessa backupfiler städas bort när de blir mer än 3 dagar gamla

---

# Repetitionsövning 2: lösning

```
$ crontab -e
0 8-18 * * 1-5  mysqldump --databases mydb1 >/opt/backup/mydb1[`date +\%Y\%m\%d:\%H_\%M`].sql
0 5    * * *    find /opt/backup -mtime +3 -exec rm {} \;
```

---
<!-- _class: - invert - lead -->
# <!--fit--> Tips & tricks
---

# fish: bästa shellet

![height:360px](https://fishshell.com/assets/img/screenshots/autosuggestion.png)

https://fishshell.com

---

* `^A`, `^E`, alt-pilarna: början, slutet, hoppa ord
* `^W`, `^D`: ta bort ord, ta bort tecken
* `^C`, `^D`: avsluta, exit
* Bash: `^R` (men inbyggt i fish): reverse history search
* `code .`: vscode för nuvaranda mapp
* `open .`: öppna default-app för fil/mapp i GUI
* git-status i prompten

---

# `screen`/`tmux`

* ha flera terminaler i en
* split screen, etc
* flera tabbar i remote
* detach!! ^A-^D
    * `screen -r`
    * lämna interakt script igång (e g på remote host) och kom tillbaka till senare



---

# Tack för den här kursen! 💖
