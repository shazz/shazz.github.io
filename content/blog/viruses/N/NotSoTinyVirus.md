Title: Tiny
Slug: NotSoTinyVirus
Name: Tiny virus
Date: 2025-03-17 17:30
Location: Montreal / Canada
Category: Atari ST, Virus
Lang: en
Author: shazz
status: hidden
summary: This article is about the Tiny virus...
image: {filename}../../../gallery/viruses/NotSoTinyVirus.png
Source: no
UVK: 
OtherName: |78|[Tiny](/NotSoTinyVirus-en.html)|Tiny Virus|yes|85||TINY.S|
Tags: bootsector virus

## In a few words...

This virus does not have a description.

The following symptoms may happen: replicates iself

## Details

 - **Replication**: on A only, when Getbpb() is called, on any bootsector
 - **Bootcode size**: 192 bytes.
 - **Resident address**: 1C0.
 - **Start address**: 0x1E.
 - **Stealth address**: N/A.
 - **Attached vectors**: hdv_bpb and vbl_list.
 - **Reset resistance**: No.
 - **TOS**: All.

### What's special ?

What's special...



### Fun facts

In the UVK book, Richard wrote...



## See the virus in action!

{% from '/html/macros/emulator.html' import emulator %}
{{ emulator("NotSoTinyVirus", False) }}