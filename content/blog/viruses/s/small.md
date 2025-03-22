Title: Small
Slug: small
Name: Small virus
Date: 2025-03-22 18:22
Location: Montreal / Canada
Category: Atari ST, Virus
Lang: en
Author: shazz
status: hidden
summary: This article is about the Small virus...
image: {filename}../../../gallery/viruses/small.png
Source: no
UVK: 
OtherName: |75|[Small](/small-en.html)|Small Virus|yes|74||SMALL.S|
Tags: bootsector virus

## In a few words...

This virus does not have a description.

The following symptoms may happen: no symptoms

## Details

 - **Replication**: Replication unknown
 - **Bootcode size**: 206 bytes.
 - **Resident address**: DISKBUF + 0x600.
 - **Start address**: 0x1E.
 - **Stealth address**: N/A.
 - **Attached vectors**: hdv_bpb.
 - **Reset resistance**: No.
 - **TOS**: Requires the ROM hdv_bpb vector to be at 0xFC0FCA, not sure that's on every TOS versions..

### What's special ?

What's special...



### Fun facts

In the UVK book, Richard wrote...



## See the virus in action!

{% from '/html/macros/emulator.html' import emulator %}
{{ emulator("small", False) }}