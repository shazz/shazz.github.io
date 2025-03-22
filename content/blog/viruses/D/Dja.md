Title: Dja
Slug: Dja
Name: Dja virus
Date: 2025-03-17 17:30
Location: Montreal / Canada
Category: Atari ST, Virus
Lang: en
Author: shazz
status: hidden
summary: This article is about the Dja virus...
image: {filename}../../../gallery/viruses/Dja.png
Source: no
UVK: 
OtherName: |25|[Dja](/Dja-en.html)|DJA Virus|yes|45||DJA.S|
Tags: bootsector virus

## In a few words...

This virus does not have a description.

The following symptoms may happen: Shows message "Du är smittad av DJA viruset" and "Generation n" (n changes based on the virus generation) and locks the system after 3 replications.

## Details

 - **Replication**: at every Getbpb() call. If the disk is not a MSDOS disk (based om branch), the virus is replicated.
 - **Bootcode size**: 451 bytes.
 - **Resident address**: DISKBUFP + 0x600.
 - **Start address**: 0x3a.
 - **Stealth address**: N/A.
 - **Attached vectors**: hdv_bpb.
 - **Reset resistance**: No.
 - **TOS**: All.

### What's special ?

What's special...



### Fun facts

In the UVK book, Richard wrote...



## See the virus in action!

{% from '/html/macros/emulator.html' import emulator %}
{{ emulator("Dja", False) }}