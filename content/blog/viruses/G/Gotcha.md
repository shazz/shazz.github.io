Title: Gotcha
Slug: gotcha
Name: Gotcha virus
Date: 2025-03-22 18:01
Location: Montreal / Canada
Category: Atari ST, Virus
Lang: en
Author: shazz
status: hidden
summary: This article is about the Gotcha virus...
image: {filename}../../../gallery/viruses/gotcha.png
Source: no
UVK: 
OtherName: |38|[Gotcha](/Gotcha-en.html)|Gotcha Xeno Virus|yes|83||GOTCHA.S|
Tags: bootsector virus

## In a few words...

This virus does not have a description.

The following symptoms may happen: after 10 replications, then every 5 replications, it will write 'GOTCHA!' to random places on disk on side 0, sector 1-7 and track 1-64.

## Details

 - **Replication**: on current read floppy only but on any bootsector
 - **Bootcode size**: 438 bytes.
 - **Resident address**: 0x140.
 - **Start address**: 0x1E.
 - **Stealth address**: PHYSTOP - 0x8200.
 - **Attached vectors**: hdv_bpb, resvec.
 - **Reset resistance**: Yes.
 - **TOS**: Needs ROM hdv_bpb vector to be located in 0x00FC0FCA.

### What's special ?

What's special...



### Fun facts

In the UVK book, Richard wrote...



## See the virus in action!

{% from '/html/macros/emulator.html' import emulator %}
{{ emulator("gotcha", False) }}