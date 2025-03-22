Title: Gillus
Slug: gillus
Name: Gillus virus
Date: 2025-03-22 18:22
Location: Montreal / Canada
Category: Atari ST, Virus
Lang: en
Author: shazz
status: hidden
summary: This article is about the Gillus virus...
image: {filename}../../../gallery/viruses/gillus.png
Source: no
UVK: 
OtherName: |36|[Gillus](/gillus-en.html)|Vaccin-Gillus Virus|yes|89||GILLUS.S|
Tags: bootsector virus

## In a few words...

This virus does not have a description.

The following symptoms may happen: Display rasters at boot with message "VACCIN GILLUS"

## Details

 - **Replication**: on any Getbpb() call on a floppy
 - **Bootcode size**: 462 bytes.
 - **Resident address**: 0x140.
 - **Start address**: 0x1e.
 - **Stealth address**: PHYSTOP - 0x8200.
 - **Attached vectors**: hdv_bpb, resvec, undocumented resident routine.
 - **Reset resistance**: Yes.
 - **TOS**: all.

### What's special ?

What's special...



### Fun facts

In the UVK book, Richard wrote...



## See the virus in action!

{% from '/html/macros/emulator.html' import emulator %}
{{ emulator("gillus", False) }}