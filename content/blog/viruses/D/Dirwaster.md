Title: Dir Waster
Slug: Dirwaster
Name: Dir Waster virus
Date: 2025-03-17 17:30
Location: Montreal / Canada
Category: Atari ST, Virus
Lang: en
Author: shazz
status: hidden
summary: This article is about the Dir Waster virus...
image: {filename}../../../gallery/viruses/Dirwaster.png
Source: no
UVK: 
OtherName: |24|[Dir Waster](/Dirwaster-en.html)|Directory Waster Virus|yes|59||DIRWASTER.S|
Tags: bootsector virus

## In a few words...

This virus does not have a description.

The following symptoms may happen: after 20 replications it will replace the first 20 tracks on both sides with the VRAM content

## Details

 - **Replication**: on every floppy
 - **Bootcode size**: 426 bytes.
 - **Resident address**: 0x140.
 - **Start address**: 0x1e.
 - **Stealth address**: PHYSTOP - 0x8200.
 - **Attached vectors**: hdv_bpb, resvec, undocumented resident routine.
 - **Reset resistance**: Yes.
 - **TOS**: All.

### What's special ?

What's special...



### Fun facts

In the UVK book, Richard wrote...



## See the virus in action!

{% from '/html/macros/emulator.html' import emulator %}
{{ emulator("Dirwaster", False) }}