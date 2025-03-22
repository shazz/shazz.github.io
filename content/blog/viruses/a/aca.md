Title: ACA
Slug: aca
Name: ACA virus
Date: 2025-03-22 18:22
Location: Montreal / Canada
Category: Atari ST, Virus
Lang: en
Author: shazz
status: hidden
summary: This article is about the ACA virus...
image: {filename}../../../gallery/viruses/aca.png
Source: no
UVK: 
OtherName: |1|[ACA](/aca-en.html)|ACA Virus|yes|4||ACA.S|
Tags: bootsector virus

## In a few words...

This virus does not have a description.

The following symptoms may happen: When the counter will reach zero (starting at 10 in the original version, at 2 in the fixed version), the bootsector, FAT and Directory will be erased.

## Details

 - **Replication**: At each boot of the virus bootsector (on bootdev), it is patched, the bootsector (OEM) counter is decreased by 1. 
             After a reset on any floppy EXCEPT if the bootsector starts with BRA or if it has the virus signature ('AC' in OEM). Else the virus is also replicated but the counter is not decremented yet
 - **Bootcode size**: 400 bytes.
 - **Resident address**: DISKBUF.
 - **Start address**: 0x1e (entry point at 0x96).
 - **Stealth address**: 0x600.
 - **Attached vectors**: undocumented resident routine.
 - **Reset resistance**: yes.
 - **TOS**: all.

### What's special ?

- One of the first virus, from 1988
- No binding on typical hdv_bpb or hdv_rw vectors, only the undocumented reset resident routine so everything happens at boot time  (meaning after a reset as sson as th evirus is installed)
- Code is not optimized at all or obfsucated, the virus could be really smaller
- Resident checksum is not computed but hardcoded and realy on the last bytes of the virus to be enabled
- The check to detect the virus is pretty poor as if it first find a "0x60" (BRA) at the beginning of the bootsector it thinks this is the virus and doesn't replicate. It would have been smarter to look at the whole virus code and checksum.
  Or maybe it was on purpose to do not erase bootsectors ?

### Fun facts

- The ACA author get interviewed in a German magazine and had "funny" claims.
- When replicating, the floppy serial numbe is changed to "0xEA", maybe it has a meaning ? That before the mayhem it will generate a 'ACA' 01234 header ?
- The virus can be spead using... ACA Virus Detector and Vaccin! If you type the word EVOT (CapsLock set) it will display a new menu: F6 Infect Disk!

## See the virus in action!

{% from '/html/macros/emulator.html' import emulator %}
{{ emulator("aca", False) }}