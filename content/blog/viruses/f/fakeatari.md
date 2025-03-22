Title: Fake Atari
Slug: fakeatari
Name: Fake Atari virus
Date: 2025-03-22 18:22
Location: Montreal / Canada
Category: Atari ST, Virus
Lang: en
Author: shazz
status: hidden
summary: This article is about the Fake Atari virus...
image: {filename}../../../gallery/viruses/fakeatari.png
Source: no
UVK: 
OtherName: |29|[Fake Atari](/fakeatari-en.html)|Joe Virus|yes|58||FAKE_ATARI.S|
Tags: bootsector virus

## In a few words...

This virus does not have a description.

The following symptoms may happen: 

## Details

 - **Replication**: 
 - **Bootcode size**: 369 bytes.
 - **Resident address**: .
 - **Start address**: .
 - **Stealth address**: .
 - **Attached vectors**: .
 - **Reset resistance**: .
 - **TOS**: .

### What's special ?

- The bootsector "mimics" the Atari RAM-TOS NeuterBooter
;

### Fun facts

- This code is extremelly similar to the Chaos Megacunt virus so or it was by tre same author or it was adapted from this one.
- the description in the UVK book is not totally accurate:
   - "Virus can copy to drive(s): Current drive (floppy only), and only to immunized disks.": Only true with UVK and UVK immunized bootsector which writes a RTS at 0x3a as it replicates only if the 3 possible words are found at 0x3A. Especially the case for empty bootsectors as it could be 0000. And most vaccined disks won't be touched.
   - "When does that happen: After 20 copies of itself are made": not what I saw, it happens after 20 calls to getBPB()

## See the virus in action!

{% from '/html/macros/emulator.html' import emulator %}
{{ emulator("fakeatari", False) }}