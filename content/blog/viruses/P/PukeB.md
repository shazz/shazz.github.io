Title: Puke B
Slug: PukeB
Name: Puke B virus
Date: 2025-03-17 17:30
Location: Montreal / Canada
Category: Atari ST, Virus
Lang: en
Author: shazz
status: hidden
summary: This article is about the Puke B virus...
image: {filename}../../../gallery/viruses/PukeB.png
Source: no
UVK: 
OtherName: |69|[Puke B](/PukeB-en.html)|Puke B Virus|yes|35||PUKE2.S|
Tags: bootsector virus

## In a few words...

This virus does not have a description.

The following symptoms may happen: write video ram content on the 9 first sectors of the floppy

## Details

 - **Replication**: on any floppy without ths signature after a floprd() on the bootsector
 - **Bootcode size**: 0 bytes.
 - **Resident address**: VRAM + 32000.
 - **Start address**: .
 - **Stealth address**: .
 - **Attached vectors**: .
 - **Reset resistance**: .
 - **TOS**: .

### What's special ?

What's special...



### Fun facts

In the UVK book, Richard wrote...



## See the virus in action!

{% from '/html/macros/emulator.html' import emulator %}
{{ emulator("PukeB", False) }}