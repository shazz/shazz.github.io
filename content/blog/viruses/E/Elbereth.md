Title: Elbereth
Slug: elbereth
Name: Elbereth virus
Date: 2025-03-22 18:01
Location: Montreal / Canada
Category: Atari ST, Virus
Lang: en
Author: shazz
status: hidden
summary: This article is about the Elbereth virus...
image: {filename}../../../gallery/viruses/elbereth.png
Source: no
UVK: 
OtherName: |26|[Elbereth](/Elbereth-en.html)|DNA Menace, Menace virus|yes|63||MENACE.S|
Tags: bootsector virus

## In a few words...

This virus does not have a description.

The following symptoms may happen: after 10 replications, it will fill the 64 sectors after the bootsectors with the VRAM content (32K) and patch the bootsector to show at boot a poem from Lord of the Rings and lock the system

## Details

 - **Replication**: on any floppy after xbios calls to floprd() or flopwr() and getBPB()
 - **Bootcode size**: 0 bytes.
 - **Resident address**: PHYSTOP - 0x800.
 - **Start address**: 0x1e, and uses FAT secotor 6 or 10 based om the number of sectors on the disk.
 - **Stealth address**: 0x600.
 - **Attached vectors**: hdv_bpb, trap 14, undocumented resident routine, vbl vector.
 - **Reset resistance**: yes.
 - **TOS**: all.

### What's special ?

- Some code similar to the CT virus to hide itself using theMD descriptor block
- Use a secondary sector (6 or 10) to store code
- Use a VBL routine to reinstall the resident routine after execution/deletion after a short delay (5s)
- Catch any xbios call, hide itself from call using floprd() to get the bootsector and returns an empty bootsector (and replicates at the same time if floprd() or flopwr() are called)
- Use many global variables in the 0x140-0x174 space tp save addresses and a simple state machine

### Fun facts

- The message shown is one of the 3 versions of the "A Elbereth Gilthoniel", an Elvish hymn to Varda in Sindarin in J. R. R. Tolkien's The Lord of the Rings (Sam Gamegie's one).
  It can be translated as "O Elbereth Starkindler, from heaven gazing afar to thee I cry here beneath the shadow of death! O look towards me, Everwhite!"
- Any bootsector modification using floprd then flopwr will in fact write back possibly the empty bootsector, this will trigger the replication and counter update

## See the virus in action!

{% from '/html/macros/emulator.html' import emulator %}
{{ emulator("elbereth", False) }}