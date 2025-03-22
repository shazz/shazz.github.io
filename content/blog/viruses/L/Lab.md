Title: Lab
Slug: Lab
Name: Lab virus
Date: 2025-03-17 17:30
Location: Montreal / Canada
Category: Atari ST, Virus
Lang: en
Author: shazz
status: hidden
summary: This article is about the Lab virus...
image: {filename}../../../gallery/viruses/Lab.png
Source: no
UVK: 
OtherName: |44|[Lab](/Lab-en.html)|Lab-Virus|yes|10||LAB.S|
Tags: bootsector virus

## In a few words...

This virus does not have a description.

The following symptoms may happen: after 10 calls to Getbpb() it will fill the screen with $FF for one frame. Counter is then resetted to 0.

## Details

 - **Replication**: on every non-protected disk read with no bootsector branch (0)
 - **Bootcode size**: 222 bytes.
 - **Resident address**: PHYSTOP - 0x200.
 - **Start address**: 0x1e.
 - **Stealth address**: N/A.
 - **Attached vectors**: hdv_bpb.
 - **Reset resistance**: no.
 - **TOS**: TOS 1.0, 1.02 and 1.04 (wplatch).

### What's special ?

- Quite nothing, from the BHP Virus, it adds a generation counter (Not used, only incremented) and fill the pixels with 0xff in the video memory after 10 GetBPB()

### Fun facts

- An adaptation of the Munchner BHP virus, most of its structure is kept.

## See the virus in action!

{% from '/html/macros/emulator.html' import emulator %}
{{ emulator("Lab", False) }}