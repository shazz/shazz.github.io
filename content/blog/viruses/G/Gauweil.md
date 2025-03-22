Title: Gauweil
Slug: gauweil
Name: Gauweil virus
Date: 2025-03-22 18:01
Location: Montreal / Canada
Category: Atari ST, Virus
Lang: en
Author: shazz
status: hidden
summary: This article is about the Gauweil virus...
image: {filename}../../../gallery/viruses/gauweil.png
Source: no
UVK: 
OtherName: |34|[Gauweil](/Gauweil-en.html)|Gauweiler Virus|yes|24||GAUWEIL.S|
Tags: bootsector virus

## In a few words...

This virus does not have a description.

The following symptoms may happen: Show message on screen and erase first 9 sectors. Also any call to GetBPB() to an infected disk will show erroneous data.

## Details

 - **Replication**: On any non executable floppy bootsector or any bootsector containing " 2" at 0x1f2. BPS will be changed on disk
 - **Bootcode size**: 480 bytes.
 - **Resident address**: N/A.
 - **Start address**: 0x1E.
 - **Stealth address**: MEMTOP-0x200.
 - **Attached vectors**: hdv_bpb, partially Trap 13.
 - **Reset resistance**: Undocumented resident program.
 - **TOS**: all.

### What's special ?

What's special...



### Fun facts

In the UVK book, Richard wrote...



## See the virus in action!

{% from '/html/macros/emulator.html' import emulator %}
{{ emulator("gauweil", False) }}