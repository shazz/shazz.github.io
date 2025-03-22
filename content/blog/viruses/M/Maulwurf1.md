Title: Maulwurf 1 US version
Slug: Maulwurf1
Name: Maulwurf 1 US version virus
Date: 2025-03-17 17:30
Location: Montreal / Canada
Category: Atari ST, Virus
Lang: en
Author: shazz
status: hidden
summary: This article is about the Maulwurf 1 US version virus...
image: {filename}../../../gallery/viruses/Maulwurf1.png
Source: no
UVK: 
OtherName: |55|[Maulwurf 1 US version](/Maulwurf1-en.html)|Maulwurf I Virus B|yes|8||MAULWURF_US.S|
Tags: bootsector virus

## In a few words...

This virus does not have a description.

The following symptoms may happen: Displays the message Maulwurf I - SSG (Subversive Software Group) every line indefinitevely hanging up the computer.

## Details

 - **Replication**: on any floppy disk read, except if it contains exactly the virus (using a difference counter)
 - **Bootcode size**: 486 bytes.
 - **Resident address**: VRAM+32000, 0x10000 for TOS startup copy.
 - **Start address**: 0x1E.
 - **Stealth address**: N/A.
 - **Attached vectors**: hdv_bpb, resvector, VBL routine.
 - **Reset resistance**: Yes.
 - **TOS**: Needs TOS 1.0 resve.

### What's special ?

What's special...



### Fun facts

In the UVK book, Richard wrote...



## See the virus in action!

{% from '/html/macros/emulator.html' import emulator %}
{{ emulator("Maulwurf1", False) }}