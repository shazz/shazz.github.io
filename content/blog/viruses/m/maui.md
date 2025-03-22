Title: Maui's Virus
Slug: maui
Name: Maui's Virus virus
Date: 2025-03-22 18:22
Location: Montreal / Canada
Category: Atari ST, Virus
Lang: en
Author: shazz
status: hidden
summary: This article is about the Maui's Virus virus...
image: {filename}../../../gallery/viruses/maui.png
Source: no
UVK: 
OtherName: |54|[Maui's Virus](/maui-en.html)|Anaconda Virus A|yes|79||ANACONDA.S|
Tags: bootsector virus

## In a few words...

This virus does not have a description.

The following symptoms may happen: replicates itself, after 10 replications it should display "MAUI viens de vous niquer" and locks the computer (infinite loop)

## Details

 - **Replication**: on A or B only, when Getbpb() is called, on any bootsector
 - **Bootcode size**: 430 bytes.
 - **Resident address**: 0x140.
 - **Start address**: 0x1E.
 - **Stealth address**: PHYSTOP-0x8200.
 - **Attached vectors**: hdv_bpb.
 - **Reset resistance**: resvec and undocumented resident program.
 - **TOS**: all.

### What's special ?

What's special...



### Fun facts

In the UVK book, Richard wrote...



## See the virus in action!

{% from '/html/macros/emulator.html' import emulator %}
{{ emulator("maui", False) }}