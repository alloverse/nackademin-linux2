---
marp: true
title: Linux 2 DEVOPS21, Lektion 5
theme: gaia
paginate: true
footer: Nackademin HT 2022 • Linux 2 DEVOPS21 • Alloverse AB
---
<!-- _class: - gaia -->

# <!--fit--> Linux 2 <br> DEVOPS 2021 
## Lektion 5

---

# Idag

* Säkerhet och nätverkssäkerhet
* Säkerhetstänkande och riskbedömningar på olika nivåer
* iptables
* Härdning

---

<!-- _class: - invert - lead -->

# <!--fit--> Säkerhetstänk

---
<!-- _class: - invert - lead -->
# <!--fit--> iptables
---

# Nätverkssäkerhet

* Brandvägg
* Vad ska vara öppet? Vad ska vara stängt?
* Behöver något övervakas?


---

# `iptables`

<!-- https://wiki.archlinux.org/title/iptables#Basic_concepts -->

Linux-program som fungerar som inbyggd brandvägg. Huvudsakligen använt för att filtrera vad som får komma in respektive komma ut. Kan även användas för NAT-routing, och annat.

Grundkoncept:`tables` innehåller `chains` innehåller `rules`.

---

# Övning 2

Se hur din lokala iptables ser ut med `sudo iptables -L -v`.

Lägg speciellt märke till vilka tre chains du ser i defaulttabellen `filter`.

---

![bg fit](img/iptables.png)

---

# iptables: tables
Finns fem fördefinerade tabeller, men vi kommer mest bry oss om tabellen `filter` (den är default)

---

# iptables: chains

En `chain` reglerar _en väg_ för nätverkstrafik: en lista av regler. Tabellen `filter` har tre chains:

* `INPUT`: Paket (förmodligen från nätverket) som ska levereras lokalt.
* `OUTPUT`: Paket som ska från denna datorn och ut till nätverket
* `FORWARD`: Paket utifrån som inte ska levereras lokalt, utan ska ut på nätverket igen (dvs NAT och dyl)

---

## iptables: rules

Varje `rule` består av:

* ett `predicate` (ett test: _OM_ paketet är på port X, eller _OM_ paketet ska till IP Y, osv)
* och en `target` (vad som ska hända: `ACCEPT`, `DROP`, eller flytta paketet till en annan table (överkurs)).

Inom en chain evalueras en lista med regler i tur och ordning. Når man slutet utan att en regel matchats, så utförs antingen `ACCEPT` eller `DROP`, beroende på inställning.

---

# iptables

* Lägg till en regel: `iptables -A {kedja} {regel}`
* Ta bort en regel: `iptables -D {kedja} {regel}`
* Lägg till på specifik plats: `iptables -I {kedja} {plats} {regel}`

---

# iptables

* Tillåt all trafik i en riktning: `iptables -A {INPUT|OUTPUT} ACCEPT`
* Blockera all trafik i en riktning: `iptables -A {INPUT|OUTPUT} DROP`
* Blockera inkommande från specifik IP: `iptables -A INPUT -s 1.2.3.4 -j DROP`

---

<style scoped> td, th { font-size: 20pt; }</style>

|iptables-exempel
|-----------
|Tillåt ssh från specifikt nätverk
|`$ iptables -A INPUT -i eth0 -p tcp -s 192.168.100.0/24 --dport 22 -m state --state NEW,ESTABLISHED -j ACCEPT` `$ iptables -A OUTPUT -o eth0 -p tcp --sport 22 -m state --state ESTABLISHED -j ACCEPT`
|Tillåt all inkommande http
|`$ iptables -A INPUT -i eth0 -p tcp --dport 80 -m state --state NEW,ESTABLISHED -j ACCEPT` `$ iptables -A OUTPUT -o eth0 -p tcp --sport 80 -m state --state ESTABLISHED -j ACCEPT`
|Tillåt forward från ett nätverk till ett annat (ofta internt till externt)|
`$ iptables -A FORWARD -i eth0 -o eth1 -j ACCEPT`
| Rensa tabellen helt
| `iptables -F`

---

<style scoped> td, th { font-size: 22pt; }</style>

|iptables-exempel
|-----------
|Stäng för utgående trafik på http-porten
|`iptables -A OUTPUT -p tcp --dport 80 -j DROP`
|Tillåt trafik ut till specifikt nätverk
|`iptables -A OUTPUT -p tcp -d nackademin.se -j ACCEPT`
| Stäng för all trafik in
|`iptables -P INPUT DROP`
| Stäng för all trafik ut
|`iptables -P OUTPUT DROP`

https://www.thegeekstuff.com/2011/06/iptables-rules-examples/

---

# Övning 3

* Stäng av din egen Linux-maskins tillgång till en webbsite (t ex www.generationt.se) med `iptables`.
* Testa att blockeringen fungerar.
* Ta bort blockeringen igen.

---

# Övning 3

```bash
$ iptables -A OUTPUT -p tcp -d www.generationt.se -j DROP
$ open https://www.generationt.se
$ iptables -D OUTPUT 1
$ open https://www.generationt.se
```

---

# Övning 4

Tänk dig att du gör iptables-konfigurationen för en "kiosk" enligt bilden nedan. Skapa rätt iptables. (om du experimenterar med en dator över teamviewer, se till att hålla öppet för det protokollet!)

// todo: bild

---

# Övning 4

```bash
$ iptables -A OUTPUT -p tcp -d bigmart.com -j ACCEPT
$ iptables -A OUTPUT -p tcp -d bigmart-data.com -j ACCEPT
$ iptables -A OUTPUT -p tcp -d ubuntu.com -j ACCEPT
$ iptables -A OUTPUT -p tcp -d ca.archive.ubuntu.com -j ACCEPT
$ iptables -A OUTPUT -p tcp --dport 80 -j DROP
$ iptables -A OUTPUT -p tcp --dport 443 -j DROP
$ iptables -A INPUT -p tcp -s 10.0.3.1 --dport 22 -j ACCEPT
$ iptables -A INPUT -p tcp -s 0.0.0.0/0 --dport 22 -j DROP
```

Övningsexemplet stulet från
https://opensource.com/article/18/9/linux-iptables-firewalld

---

<!-- _class: - invert - lead -->

# <!--fit--> Härdning

---
