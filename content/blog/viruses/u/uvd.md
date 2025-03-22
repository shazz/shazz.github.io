Title: UVD
Slug: uvd
Name: UVD virus
Date: 2025-03-22 18:22
Location: Montreal / Canada
Category: Atari ST, Virus
Lang: en
Author: shazz
status: hidden
summary: This article is about the UVD virus...
image: {filename}../../../gallery/viruses/uvd.png
Source: no
UVK: 
OtherName: |85|[UVD](/uvd-en.html)|UVD Virus|yes|84||UVD1.S|
Tags: bootsector virus

## In a few words...

This virus does not have a description.

The following symptoms may happen: replicates, shows message at 19 min (at 50Hz) and locks the computer (infinite loop)

## Details

 - **Replication**: on A or B only, when Getbpb() is called on any bootsector
 - **Bootcode size**: 426 bytes.
 - **Resident address**: 0x140.
 - **Start address**: 0x1E.
 - **Stealth address**: 0x50000.
 - **Attached vectors**: hdv_bpb, vbl_list, resvec.
 - **Reset resistance**: Yes, using resvec and undocumented stealth resident location.
 - **TOS**: all.

### What's special ?

What's special...



### Fun facts

In the UVK book, Richard wrote...



## See the virus in action!

{% from '/html/macros/emulator.html' import emulator %}
{{ emulator("uvd", False) }}