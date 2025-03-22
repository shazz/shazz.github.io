Title: Bomb
Slug: Bomb
Name: Bomb virus
Date: 2025-03-17 17:30
Location: Montreal / Canada
Category: Atari ST, Virus
Lang: en
Author: shazz
status: hidden
summary: This article is about the Bomb virus...
image: {filename}../../../gallery/viruses/Bomb.png
Source: no
UVK: 
OtherName: |15|[Bomb](/Bomb-en.html)|Bombenvirus, Bomb Virus|yes|||BOMB.S|
Tags: bootsector virus

## In a few words...

This virus does not have a description.

The following symptoms may happen: when the generation counter reaches 1, 19 bombs will be shown on screen

## Details

 - **Replication**: on any call to getbpb (device is retrieved from this call) on any bootsector except the virus itself in its current generation
 - **Bootcode size**: 206 bytes.
 - **Resident address**: N/A.
 - **Start address**: 0x20.
 - **Stealth address**: N/A.
 - **Attached vectors**: hdv_bpb.
 - **Reset resistance**: No.
 - **TOS**: 1.0 only.

### What's special ?

What's special...



### Fun facts

In the UVK book, Richard wrote...



## See the virus in action!

{% from '/html/macros/emulator.html' import emulator %}
{{ emulator("Bomb", False) }}