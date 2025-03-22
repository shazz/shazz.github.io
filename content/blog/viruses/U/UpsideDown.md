Title: Upside Down
Slug: upsidedown
Name: Upside Down virus
Date: 2025-03-22 18:01
Location: Montreal / Canada
Category: Atari ST, Virus
Lang: en
Author: shazz
status: hidden
summary: This article is about the Upside Down virus...
image: {filename}../../../gallery/viruses/upsidedown.png
Source: no
UVK: 
OtherName: |84|[Upside Down](/UpsideDown-en.html)|Upside Down Virus|yes|36||UPSIDEDO.S|
Tags: bootsector virus

## In a few words...

This virus does not have a description.

The following symptoms may happen: after 4 replication, will reverse the screen (only one frame) then every 2 replications

## Details

 - **Replication**: only if after a fsfirst or fopen call, the virus reads the bootsector and checks the branch is 0x601C
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
{{ emulator("upsidedown", False) }}