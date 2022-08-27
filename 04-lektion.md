---
marp: true
title: Linux 2 DEVOPS21, Lektion 4
theme: gaia
paginate: true
footer: Nackademin HT 2022 • Linux 2 DEVOPS21 • Alloverse AB
---
<!-- _class: - gaia -->

# <!--fit--> Linux 2 <br> DEVOPS 2021 
## Lektion 4

---

# Idag

* Nätverk
* Nätverksinställningar
* Mailserver och SMTP
* DNS och DNS-records
* konfigurera DNS

---
<!-- _class: - invert - lead -->

# <!--fit--> Nätverk

---

# Nätverk

* Datorer pratar med varandra
    * Kommunikation på många protokoll, men måste alltid hitta varandra
* IP-adresser (Internet Protocol Address)
    * En numerisk bestämning som pekar ut nätverkskopplingen för en viss enhet
    * IPv4, IPv6

---

# Nätverk

![](/img/osi.png)

---

<style scoped>
    p {
        text-align: center;
    }
</style>

![](/img/ipv6.png)

https://www.youtube.com/watch?v=bNmnRvZW3HU

---

# Nätverkskommandon i Linux

Kommando | Funktion |
-------- | --- |
`ifconfig` | Visa/ändra nätverksinterface och konfiguration |
`ip` | Nyare ersättare till `ifconfig` |
`route` | Visa/ändra routingtabell |
`ethtool` | Visa/ändra parametrar för ett nätverksinterface |
`ping` | testa kontakt och latens till en adress |
`traceroute` | Visa routen som ett paket tar till en adress |

---

# `route`
* Ange en default gateway:
    `route add default gw <ip>`
    `route add default gw 192.168.1.1`

---

# Exempel

* `ifconfig`
* `ip addr show`
* `route`
* `ethtool <interface>`
* `ping <adress>`
* `traceroute <adress>`

---

# Övning 1

Använd lämpliga nyss nämnda verktyg till att ta reda på hur din Linux-maskin är uppsatt nätverksmässigt.

* Ser du om den använder eth eller wlan?
* Ser du routingtabell?

* Kolla speciellt efter
    * din IP
    * ditt loopback-interface

---

# Konfigurera din ip-adress manuellt

`ifconfig <interface> <ip> <netmask> up`
e g: `ifconfig eth1 192.168.1.5 netmask 255.255.255.0 up`

--
`ip addr add <ip>/<mask> dev <interface>`
`ip link set <network> up`

e g: 
```
ip addr add 192.168.1.5/24 dev eth1
ip link set eth1 up
```

---

# Övning 2

* Hur gör du för att sätta din Linux-maskins ip- adress till 10.1.1.101 med netmask /24?
    * Testa förslagsvis bara på ett nätverksinterface som inte är det du använder för din koppling till världen just nu.

---

# Övning 2

`$ sudo ifconfig eth0 10.1.1.101 netmask 255.255.255.0`

![](/img/ifconfig.png)

---

# Se vilka interfaces som är igång?

* `ip addr` och söka efter "state UP"
* `ifconfig` och söka efter "RUNNING"

---

# Övning 3

Implementera följande:

Två gånger i timmen kontrolleras ifall eth0
respektive wlan0 är uppe, och resultatet skrivs
till en log-fil, med tidsstämpel

---

# Övning 3

```bash
#!/bin/bash
logfile=/var/log/myiptest.log
timestamp=`date +%Y-%m-%d_%H-%M-%S`
ip addr | grep wlan0 | grep "state UP" >/dev/null

if [ $? -eq 0 ]; then
    echo $timestamp ": wlan0 UP" >> $logfile;
fi
```


Till crontab:
`0,30 * * * * /var/scripts/iptest.sh`


---
<!-- _class: - invert - lead -->

# <!--fit--> &nbsp;&nbsp;Email&nbsp;&nbsp;
# <!--fit--> SMTP, IMAP, POP

---

# Vad finns det för mailservrar?

* Postfix, Sendmail, Qmail, etc etc etc...
* Översikt över de populäraste: https://www.ubuntupit.com/best-linux-mail-server-software-and-solutions/

---

# Vad gör en mailserver?

* Tar emot e-post från klienter, och antingen lägger dem i en användares inbox eller skickar vidare (över **SMTP**)
* Tar emot e-post från andra mailservrar, och skickar mail till dem (över **SMTP**)
* Hanterar/levererar/listar/etc mail till klienter
    * POP _(gammalt, dåligt, port 110)_
    * IMAP _(modernt, snazzy, port 143)_

---

# SMTP

"**Simple Mail Transfer Protocol**" (ps. "simple" är en lögn)

* "Pusha" mail till mailserver. Protokoll för utgående e-post
* Text-baserat protokoll; går att skriva för hand
* Anslutnings-baserat (koppla upp dig, autentsiera, skicka diverse kommandon, koppla ner. "SMTP-session")
* Port 25 plaintext, 465 över SSL

---

# Snacka SMTP (kommandon)

* `HELO`: vem är du, vem är jag (modernare: `EHLO` för att be om "extended SMTP")
* `MAIL FROM`: skicka ett mail från angiven adress
* `RCPT TO`: ange mottagare
* `DATA`: Ange meddelandet som ska skickas
* `QUIT`: hejdå!

---

<style scoped>
code {
  font-size: 18px;
}
</style>

```
$ telnet example.org 25
S: 220 example.org ESMTP Sendmail 8.13.1/8.13.1; Wed, 30 Aug 2006 07:36:42 -0400
C: HELO mailout1.phrednet.com
S: 250 example.org Hello ip068.subnet71.gci-net.com [216.183.71.68], pleased to meet you
C: MAIL FROM:<xxxx@example.com>
S: 250 2.1.0 <xxxx@example.com>... Sender ok
C: RCPT TO:<yyyy@example.com>
S: 250 2.1.5 <yyyy@example.com>... Recipient ok
C: DATA
S: 354 Enter mail, end with "." on a line by itself
C: From: Dave
To: Test Recipient
Subject: SPAM SPAM SPAM

This is message 1 from our test script.
.
S: 250 2.0.0 k7TKIBYb024731 Message accepted for delivery
C: QUIT
S: 221 2.0.0 example.org closing connection 
Connection closed by foreign host.
```

Från https://en.citizendium.org/wiki/SMTP_example_sessions

---

# Övning 4

* Testa att kontakta `mail.nackademin.se` med smtp-protokollet (t ex med `telnet`).

---

# Övning 4 (om ni har tur...)


<style scoped>
code {
  font-size: 18px;
}
</style>

```
$ telnet mail.nackademin.se 25
Trying 192.71.164.33...
Connected to mail.nackademin.se.
220 shmail01.nackademin.local Microsoft ESMTP MAIL
Service ready at Sun, 16 Aug 2020 14:28:12 +0200
HELP
214-This server supports the following commands:
214 HELO EHLO STARTTLS RCPT DATA RSET MAIL QUIT
HELP AUTH BDAT
QUIT
221 2.0.0 Service closing transmission channel
```

Mer sannolikt:

```
nevyn@linmishi ~> telnet mail.nackademin.se 25
Trying 52.98.151.82...
telnet: Unable to connect to remote host: Network is unreachable
```

---

# Mer SMTP-exempel

Prata SMTP med hjälp av curl?! (exempel från
https://ec.haxx.se/usingcurl/usingcurl-smtp):

`curl smtp://mail.example.com --mail-from
myself@example.com –mail-rcpt
receiver@example.com --upload-file
email.txt`

---

# TLS

* **Transport Layer Security**
* Uppföljare till SSL ("Secure Sockets Layer")
* HTTP**S**
* Helt krypterad trafik
* SMTP kan köras över TLS

---

# Prata SMTP+TLS

`openssl s_client -connect mail.example.com:587 -starttls smtp`

`curl --ssl smtp://mail.example.com --mail-from
myself@example.com --mail-rcpt
receiver@example.com --upload-file email.txt --
user 'user@your-account.com:your-account-
password'`

---

# Hur du bäst kör din egen mail-server

* inte.
    * du kommer få otroliga mängder spam
    * din smtp-server kommer inte vara vitlistad hos världen så din mail kommer inte komma fram
    * du kommer bli hackad
    * tusen varianter på mail-klienter, hälften kommer bete sig buggigt
* Istället: sendgrid, din leverantörs SMTP-server (heroku, loopia, whatev), el dyl.

---

<!-- _class: - invert - lead -->

# <!--fit--> DNS

---
