---
marp: true
title: Linux 2 DEVOPS21, Lektion 6
theme: gaia
paginate: true
footer: Nackademin HT 2022 • Linux 2 DEVOPS21 • Alloverse AB
---
<!-- _class: - gaia -->

# <!--fit--> Linux 2 <br> DEVOPS 2021 
## Lektion 6

---

# Idag

* Databaser
* SQL vs NoSQL
* SQL-exempel: MySQL
* NoSQL-exempel: MongoDB

---

<!-- _class: - invert - lead -->

# <!--fit--> Databaser

---

# Databaser

* Egentligen varje ansamling av data, t ex textdokument
* I sammanhanget menar man oftast relationsdatabaser (SQL-databaser)
* Även andra sätt att organisera data för sökningar (NoSQL-databaser)

---

# Relationsdatabaser

* Data organiserat i tabeller
    * Rader (poster)
    * Kolumner (fält)
* Relationer mellan tabeller
    * Beroenden mellan fält
    * Kräver ett speciellt tänk om man är mer van vid programmering (relationer istället för listor, etc)

---

# Relationsdatabaser - exempel

![](img/schema.png)

---

# Relationsdatabaser

* Normalform
    * Se till att data delas upp i tabeller så att det inte upprepas i onödan och så att varje tabell har ett tydligt dataset
* Underlätta snabba sökningar
* Joins av tabeller

---
<!-- _class: - invert - lead -->

# <!--fit--> SQL

---

# SQL

* Urgammalt språk för data-sökningar och hantering av relationsdata
* Sök, lägg in, ändra, radera

---

# SQL: Exempel

| Uppgift | Exempel
|---------|---------
| Sök     | `select * from users;`
| Lägg in | `INSERT INTO users (first_name, last_name, email) VALUES ('Archibald', 'Haddock', 'haddock@moulinsart.be');`
| Ändra   | `update users set email='tintin@moulinsart.be' where first_name='Tintin'`
| Radera  | `delete from users where last_name='Dupont'`

---

# Databasmotor

* Programmet som möjliggör själva databasen
    * Databasfunktioner
    * Användarhantering
    * Lagringshantering
* Exempel (SQL): MySQL, Oracle, MS SQL Server, PostgreSQL
* Exempel (NoSQL): MongoDB, CouchDB, Neo4j

---

<!-- _class: - invert - lead -->

# <!--fit--> MySQL

---

# MySQL

* Relationsdatabaser
* Snabb och anses enkel
* Används ofta för databaser bakom webbsiter
* Open source
* Notera fork: MariaDB

---

<!-- _class: - invert - lead -->

# <!--fit--> NoSQL

---

<!-- _class: - invert - lead -->

# <!--fit--> MongoDB

---

---

# Erfarenheter med MongoDB i praktiken

* Svårt att hantera schema-lös data när den växer till sig. Ansvaret blir ditt som programmerare att se till att rätt data är på rätt plats.
* Väldigt mycket null-checkar
* Ingen statisk typning till hjälp i statiska språk
* Hade hellre använt postgres från början
