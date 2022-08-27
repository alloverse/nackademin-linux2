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

# <!--fit--> Nätverk och IP

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

* simple = evil
* kör inte din egen server, använd sendgrid el dyl
---

<!-- _class: - invert - lead -->

# <!--fit--> DNS

---
