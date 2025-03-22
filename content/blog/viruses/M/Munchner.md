Title: Munchner BHP
Slug: munchner
Name: Munchner BHP virus
Date: 2025-03-22 18:01
Location: Montreal / Canada
Category: Atari ST, Virus
Lang: en
Author: shazz
status: hidden
summary: This article is about the Munchner BHP virus...
image: {filename}../../../gallery/viruses/munchner.png
Source: no
UVK: 
OtherName: |62|[Munchner BHP](/Munchner-en.html)|Bayrische Hacker Post (BHP) Virus|yes|9||MUNCHNER.S|
Tags: bootsector virus

## In a few words...

This virus does not have a description.

The following symptoms may happen: replicates and increment generation counter

## Details

 - **Replication**: on A or B only, when Getbpb() is called, if floppy is not write protected and the bootsector starts with 0x0000 (kind of bad shortcut for non-executable)
 - **Bootcode size**: 166 bytes.
 - **Resident address**: PHYSTOP - 0x200.
 - **Start address**: 0x1E.
 - **Stealth address**: N/A.
 - **Attached vectors**: hdv_bpb.
 - **Reset resistance**: No.
 - **TOS**: 1.0 only for the non patched version.

### What's special ?

What's special...



### Fun facts

In the UVK book, Richard wrote...



## See the virus in action!

{% from '/html/macros/emulator.html' import emulator %}
{{ emulator("munchner", False) }}