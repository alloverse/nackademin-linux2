---
marp: true
title: Linux 2 DEVOPS21, Lektion 8
theme: gaia
paginate: true
footer: Nackademin HT 2022 • Linux 2 DEVOPS21 • Alloverse AB
---
<!-- _class: - gaia -->

# <!--fit--> Linux 2 <br> DEVOPS 2021 
## Lektion 9

---

# Idag

* Virtuella servrar (2/2)
* KVM
* Bygga miljö med virtuella servrar


---

# Virtuella servrar

* Bygga upp ett antal virtuella servrar på en fysisk server
* I princip hela serverparken på en maskin
* En hel testmiljö på en maskin, spridd över olika servrar
* ...eller en av flera fysiska maskiner som används för en uppsättning virtuella servrar

---

<!-- _class: - invert - lead -->
# <!--fit--> KVM 

---

<style scoped>
    blockquote { font-size: 22pt; }
</style>


> ”**KVM** (for **Kernel-based Virtual Machine**) is a full virtualization solution for Linux on x86 hardware containing virtualization extensions (Intel VT or AMD-V). It consists of a loadable kernel module, kvm.ko, that provides the core virtualization infrastructure and a processor specific module, kvm-intel.ko or kvm-amd.ko. 
> 
> Using KVM, one can run multiple virtual machines running unmodified Linux or Windows images. Each virtual machine has private virtualized hardware: a network card, disk, graphics adapter, etc.
> 
> KVM is open source software. The kernel component of KVM is included in mainline Linux, as of 2.6.20. The userspace component of KVM is included in mainline QEMU, as of 1.3.”

----

# KVM

* En hypervisor inbyggd i Linux
* Program på Linux
* I de virtuella maskinerna kan olika operativsystem installeras

---

# KVM
![bg 50%](img/kvm.png)

<br><br><br><br><br><br>
Kort introduktion på YouTube:
https://www.youtube.com/watch?v=Pgltb5lnnLY

---


# KVM

* qemu för att sköta kontakten med värdmaskinens hårdvara
* virsh för kommandoraden
* virt-manager för GUI

---

# KVM

* Kvm check
    * Paket `cpu-checker`
    * Kommando `kvm-ok`
* Installera paket
    * `sudo apt-get install qemu-kvm libvirt-daemon-system libvirt-clients bridge-utils virtinst`
* `virsh`

---

# Övning 1

* Kör `kvm-ok`
    * Saknar du det paketet, `apt install cpu-checker`
* Kan din maskin köra KVM?

---

<style scoped>
    li { font-size: 24pt; }
</style>

# Förberedelser

* Om du inte råkar ha någon iso-image liggande på din hårddisk, börja ladda hem en nu så att den finns redo om en stund. (Använd t ex `wget`.)
*  Några relativt små images:
    * CentOS8 minimal http://ftp.lysator.liu.se/pub/CentOS/7.9.2009/isos/x86_64/CentOS-7-x86_64-Minimal-2009.iso
    *  TinyCore http://tinycorelinux.net/11.x/x86/release/Core-current.iso
    * Plain debian https://cdimage.debian.org/debian-cd/current/amd64/iso-cd/debian-11.4.0-amd64-netinst.iso

---

# virsh-kommandon

* `virsh list`
* `virsh list --all`
* `virsh net-list`
* `virsh net-info default`
* `virsh nodeinfo`

---

# KVM-bibliotek

* `/var/lib/libvirt/`
* ISO images: `/var/lib/libvirt/boot/`
* VM-installationer: `/var/lib/libvirt/images/`
* Libvirt-konfiguration: `/etc/libvirt/`

---

# Övning 2

* Installera paketen för att använda KVM
* Se till att `virsh list` ger en (tom) lista
* Se till att `virsh net-list` ger en (tom) lista
* Se nätverksinformation med `virsh net-info default`

---

/// todo: bild

---

# Libvirt är en del av andra lösningar också

/// todo: bild

---

# KVM: bygga en VM

* Börja med att hämta en iso, lämpligen för någon minimerad Linux och kopiera den till `/var/lib/libvirt/boot/`
    ```
    cd /var/lib/libvirt/boot/
    sudo wget http://ftp.lysator.liu.se/pub/CentOS/8.2.2004/isos/x86_ 64/CentOS-8.2.2004-x86_64-minimal.iso
    ```
* Installera med virt-manager (GUI) eller virt-install (CLI)

---

# virt-manager

// todo: 5 bilder

---

<style scoped>
    code { font-size: 16pt;}
</style>

# virt-install, exempel

```bash
sudo virt-install \
    --name centos7 \
    --description "Test VM with CentOS 7" \
    --ram=1024 \
    --vcpus=2 \
    --os-type=Linux \
    --os-variant=rhel7.0 \
    --disk path=/var/lib/libvirt/images/centos7.qcow2,bus=virtio,size=10 \
    --graphics none \
    --location /var/lib/libvirt/boot/CentOS-7-x86_64-Minimal-2009.iso  \
    --network bridge:virbr0 \
    --console pty,target_type=serial \
    -x 'console=ttyS0,115200n8 serial'
```

från https://computingforgeeks.com/virsh-commands-cheatsheet/

---

![](img/virt-install.png)

---

# Fler virsh-kommandon

* `virsh start <vm>`
* `virsh shutdown <vm>`
* `virsh destroy <vm>`
* `virsh reboot <vm>`
* `virsh dominfo <vm>`
* `virsh undefine <vm>`

---

# Övning 3

* Installera en virtuell maskin på KVM.
* Kontrollera att du kan starta och starta om din virtuella maskin.


