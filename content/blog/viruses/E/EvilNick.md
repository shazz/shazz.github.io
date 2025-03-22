Title: Evil Nick
Slug: EvilNick
Name: Evil Nick virus
Date: 2025-03-17 17:30
Location: Montreal / Canada
Category: Atari ST, Virus
Lang: en
Author: shazz
status: hidden
summary: This article is about the Evil Nick virus...
image: {filename}../../../gallery/viruses/EvilNick.png
Source: no
UVK: 
OtherName: |27|[Evil Nick](/EvilNick-en.html)|Evil Virus|yes|25||EVIL_NICK.S|
Tags: bootsector virus

## In a few words...

This virus does not have a description.

The following symptoms may happen: after 101 cold boots with the virus it will change background color to yellow (if was white)

## Details

 - **Replication**: on any floppy without the virus identified
 - **Bootcode size**: 476 bytes.
 - **Resident address**: N/A.
 - **Start address**: 0x3a.
 - **Stealth address**: N/A.
 - **Attached vectors**: hrv_bpb, resvec, (also hrv_init, hdv_rw but not changed).
 - **Reset resistance**: reset vector.
 - **TOS**: Probably not all as some patterns are used to identify TOS routines addresses.

### What's special ?

What's special...



### Fun facts

In the UVK book, Richard wrote...



## See the virus in action!

{% from '/html/macros/emulator.html' import emulator %}
{{ emulator("EvilNick", False) }}