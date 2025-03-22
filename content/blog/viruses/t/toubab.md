Title: Toubab
Slug: toubab
Name: Toubab virus
Date: 2025-03-22 18:22
Location: Montreal / Canada
Category: Atari ST, Virus
Lang: en
Author: shazz
status: hidden
summary: This article is about the Toubab virus...
image: {filename}../../../gallery/viruses/toubab.png
Source: no
UVK: 
OtherName: |80|[Toubab](/toubab-en.html)|Finland Virus|yes|55||TOUBAB.S|
Tags: bootsector virus

## In a few words...

This virus does not have a description.

The following symptoms may happen: 

## Details

 - **Replication**: the replication is pretty complex but will occurs only on drive A:
  - if this is the  Sagrotan virus killer
  - if the bootsector is looking for resident program (RESIDENT_MAGIC)
  - if the bootsector calling XBIOS flopwr => This Anti-Virus beeps and f... AntiVirus #1 from UVK, Satan's antivirus
  - if the bootsector calling XBIOS protobt => This Anti-Virus beeps and f... AntiVirus #1 from UVK
  - if the is not executable (word checksum != 0x1234)
 - **Bootcode size**: 481 bytes.
 - **Resident address**: 0x160.
 - **Start address**: 0x1E.
 - **Stealth address**: 0x51200.
 - **Attached vectors**: hdv_bpb, resvec, undocumented reset-proof stealth location.
 - **Reset resistance**: Yes.
 - **TOS**: All.

### What's special ?

What's special...



### Fun facts

In the UVK book, Richard wrote...



## See the virus in action!

{% from '/html/macros/emulator.html' import emulator %}
{{ emulator("toubab", False) }}