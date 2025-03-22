Title: Oli
Slug: oli
Name: Oli virus
Date: 2025-03-22 18:01
Location: Montreal / Canada
Category: Atari ST, Virus
Lang: en
Author: shazz
status: hidden
summary: This article is about the Oli virus...
image: {filename}../../../gallery/viruses/oli.png
Source: no
UVK: 
OtherName: |64|[Oli](/Oli-en.html)|OLI Virus|yes|14||OLI.S|
Tags: bootsector virus

## In a few words...

This virus does not have a description.

The following symptoms may happen: aftter 20 generations of the virus, decreased after each reset, (on the same floppy or any other), the message "OLI-VIRUS installed ." appears at boot and then the system starts to slow down more and more as vbl count increases.

## Details

 - **Replication**: on the bootdev device when calls are performed to 
- Flopwr() in any case
- Floprd() if bootsector is not executable  
- Rwabs(write on first logical sector) if bootsector is not executable
 - **Bootcode size**: 448 bytes.
 - **Resident address**: 0x600.
 - **Start address**: 0x3E.
 - **Stealth address**: 0x600.
 - **Attached vectors**: hdv_rw, xbios (trap 14), trap 12 to call old xbios vector, 2nd VBL routine (only for symptoms).
 - **Reset resistance**: undocumented resident routine.
 - **TOS**: all.

### What's special ?

- to hide its activities, the virus copies the Xbios Trap in unused Trap 12 vector: The virus uses this redirection to indirectly call Flopwr() to replicate itself.
- the virus catches any floprd() calls on bootsector to hide itself and sends back an empty buffer
- the virus disables the hdv_init vector and use hdv_boot to check if a bootsector is executable rather any any suspect rwabs or floprd call
- at boot the virus patch its bootsector: deactivates its bootsector (patch checksum) and decrease its generation counter  then set the resident routine to install the virus

### Fun facts

- I'm not sure the description in the UVK book is not totally accurate: "In certain cases, it can also corrupt disk data.", this comment was also available in the reverse
  engineering done by a Croatian engineer from FOCUS Computer Gmbh who thinks that if Rwabs is called with the mediach flag, the read will be considered for a write by the virus.
  That's not what I understand in the code. And I was not able to reproduce this unwanted symptom.
- I think there is a little bug, after each boot, if the disk is already infected, the bootsector will still be patched with a decreased generation number and cheksum altered
  Then, as not executable, mostly any calls to rwabs or floprd/flopwr will revalidate the checksum. In most cases, only new infected floppies have a different generation number.

## See the virus in action!

{% from '/html/macros/emulator.html' import emulator %}
{{ emulator("oli", False) }}