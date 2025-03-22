Title: Chopin
Slug: Chopin
Name: Chopin virus
Date: 2025-03-17 17:30
Location: Montreal / Canada
Category: Atari ST, Virus
Lang: en
Author: shazz
status: hidden
summary: This article is about the Chopin virus...
image: {filename}../../../gallery/viruses/Chopin.png
Source: no
UVK: 
OtherName: |18|[Chopin](/Chopin-en.html)|Chopin Virus|yes|31||CHOPIN.S|
Tags: bootsector virus

## In a few words...

This virus does not have a description.

The following symptoms may happen: after 26 replication, will play La Marche Funèbre de Chopin and display a message forever

## Details

 - **Replication**: only if after a fsfirst or fopen call, the virus reads the bootsector
 - **Bootcode size**: 338 bytes.
 - **Resident address**: 0x140.
 - **Start address**: 0x1E.
 - **Stealth address**: No.
 - **Attached vectors**: Trap 1 (Gemdos).
 - **Reset resistance**: No.
 - **TOS**: all.

### What's special ?

What's special...



### Fun facts

In the UVK book, Richard wrote...



## See the virus in action!

{% from '/html/macros/emulator.html' import emulator %}
{{ emulator("Chopin", False) }}