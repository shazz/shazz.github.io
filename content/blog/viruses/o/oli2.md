Title: Oli 2
Slug: oli2
Name: Oli 2 virus
Date: 2025-03-22 18:22
Location: Montreal / Canada
Category: Atari ST, Virus
Lang: en
Author: shazz
status: hidden
summary: This article is about the Oli 2 virus...
image: {filename}../../../gallery/viruses/oli2.png
Source: no
UVK: 
OtherName: |65|[Oli 2](/oli2-en.html)|N/A|yes|||OLI2.S|
Tags: bootsector virus

## In a few words...

This virus does not have a description.

The following symptoms may happen: aftter 20 generations of the virus, decreased after each reset, (on the same floppy or any other), the message "OLI-VIRUS installed ." appears at boot and then the system starts to slow down more and more as vbl count increases.

## Details

 - **Replication**: on the bootdev device when calls are performed to 
- Flopwr() in any case
- Floprd() if bootsector is not executable  
- Rwabs(write on first logical sector) if bootsector is not executable
 - **Bootcode size**: 482 bytes.
 - **Resident address**: 0x600.
 - **Start address**: 0x1C.
 - **Stealth address**: 0x600.
 - **Attached vectors**: hdv_rw, xbios (trap 14), trap 12 to call old xbios vector, 2nd VBL routine (only for symptoms).
 - **Reset resistance**: undocumented resident routine.
 - **TOS**: all.

### What's special ?

- This is an updated version of the original OLI virus which 
  - also spoof Rwabs() read calls
  - only spoof Rwabs() and Floprd() calls when this is the virus contrary to the original version which spoofed EVERY Floprd calls.

### Fun facts

- Many antivirus and disk editors are deceived by this version and only "see" an empty and non executable bootsector: UVK 2000, XTermine, Dispact, Diskus, PVK, Mutil, Exorcist Pro... 
  Only tools which are using the WD1772 disk controller (and not BIOS/XBIOS system calls) directly are able to detect the virus (The Killer, KnifeST, Sagrotan, DiskDoctor, Fastcopy III)

## See the virus in action!

{% from '/html/macros/emulator.html' import emulator %}
{{ emulator("oli2", False) }}