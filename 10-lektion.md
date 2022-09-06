---
marp: true
title: Linux 2 DEVOPS21, Lektion 10
theme: gaia
paginate: true
footer: Nackademin HT 2022 • Linux 2 DEVOPS21 • Alloverse AB
---
<!-- _class: - gaia -->

# <!--fit--> Linux 2 <br> DEVOPS 2021 
## Lektion 9

---

# Idag

* Andra sätt att virtualisera
* Docker
* Infrastructure as code
    * Ansible
    * Terraform

---

<!-- _class: - invert - lead -->
# <!--fit--> Containers

---

# Containers

* Inte en hel virtuell dator, utan bara en viss miljö i ett virtuellt operativsystem
* Körs på ett operativsystem och delar oftast detta operativsystems kärna, samt bibliotek och en del binärer
* Exempel: Docker, LXC, Solaris Containers

---

# Containers

> Containers may look like real computers from the point of view of programs running in them. A computer program running on an ordinary operating system can see all resources (connected devices, files and folders, network shares, CPU power, quantifiable hardware capabilities) of that computer. However, programs running inside of a container can only see the container's contents and devices assigned to the container.

---

![bg](img/vmvs.jpg)

---

<style scoped>
    th, td { font-size: 18pt; }
</style>

# VMs vs containers

| VMs |	Containers
| --- | -----------
| Heavyweight. | Lightweight.
| Limited performance. | Native performance.
| Each VM runs in its own OS. | All containers share the host OS.
| Hardware-level virtualization. | OS virtualization.
| Startup time in minutes. | Startup time in milliseconds.
| Allocates required memory. | Requires less memory space.
| Fully isolated and hence more secure. | Process-level isolation, less secure.
| Can virtualize most things (e g USB) | Can only virtualize fixed set of things

_baserad på tabell från backblaze.com_

---

# Övning 1

* Ni har en fysisk server som ni vill använda till att snabbt sätta upp och köra testmiljöer för er applikation som körs under Linux.
* Lista fördelar med att köra containers respektive virtuella servrar på denna server.

---

# Övning 1, exempel

* Containers:
    * Behöver mindre kraft för varje container än för en virtuell server
    * Går fortare att få igång testkörning för applikationer
    * Kräver mindre minne
* Virtuella servrar:
    * Tillgång till hela operativsystemet
    * Kan ha helt olika operativsystem

---
<!-- _class: - invert - lead -->
# <!--fit--> Docker 
---

# Docker

* Docker container engine
* Kan köra mjukvara i containers
* ”OS level virtualization”
* Containers är fristående och i princip isolerade från varandra
    * Specifik kommunikation mellan containrar kan konfigureras
* Alla containers kör ovanpå din existerande Linux-kernel, men kan ha olika Linux-distribution/userspace

---

# Docker

![bg fit right](img/docker.png)

* "`chroot` jails"
* "kernel namespaces" för att isolera varje container från andra och från host
* virtuella nätverksinterface
* etc...
* https://www.codementor.io/blog/docker-technology-5x1kilcbow

---

# Installera Docker

* https://www.youtube.com/watch?v=Vplj9b0L_1Y
* https://docs.docker.com/engine/install/ubuntu/

---

# Installera Docker, i korthet:

```bash
$ sudo apt-get update
$ sudo apt-get install ca-certificates curl gnupg lsb-release
$ sudo mkdir -p /etc/apt/keyrings
$ curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
$ echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
$ sudo apt-get update
$ sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin
$ sudo systemctl status docker # kolla så den funkar

$ sudo docker run hello-world

```

---

<!-- _class: - invert - lead -->
# <!--fit--> IaC 

---

---

<!-- _class: - invert - lead -->
# <!--fit--> Ansible 

---

---

<!-- _class: - invert - lead -->
# <!--fit--> Terraform

---

---

Tillbakablick, reflektion, kommentarer ...
