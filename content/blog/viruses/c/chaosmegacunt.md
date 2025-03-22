Title: Chaos Megacunt
Slug: chaosmegacunt
Name: Chaos Megacunt virus
Date: 2025-03-22 18:22
Location: Montreal / Canada
Category: Atari ST, Virus
Lang: en
Author: shazz
status: hidden
summary: This article is about the Chaos Megacunt virus...
image: {filename}../../../gallery/viruses/chaosmegacunt.png
Source: no
UVK: 
OtherName: |17|[Chaos Megacunt](/chaosmegacunt-en.html)|Megacunt V2.0 virus|yes|43||CHAOS_MEGACUNT.S|
Tags: bootsector virus

## In a few words...

This virus does not have a description.

The following symptoms may happen: after 20 getBPB() calls it will change every frame the background (palette 0) color

## Details

 - **Replication**: at each getBPB() call if the bootsector word at 3xa (where the virus starts) is RTS, TRAP #$e or 0000
 - **Bootcode size**: 348 bytes.
 - **Resident address**: DISKBUF + 0x600.
 - **Start address**: 0x3A.
 - **Stealth address**: N/A.
 - **Attached vectors**: hdv_bpb, vbl_vector (for symptoms).
 - **Reset resistance**: No.
 - **TOS**: All.

### What's special ?

- Pretty nothing, symptoms are in one line... it says it all. Code is not particularly optimized. Never obfuscated.
- Conditions for replications target UK and PVK immuzed disks (at least), it looks for some instructions at 0x3A. 
- If the bootsector branch is cleared/changed it cannot survive, pretty weak
- The virus attaches itself to the VBL Vector (VBL interrupt) only when it needs to show the symptoms, so now used for the replication part.
;

### Fun facts

- This virus was discovered by Dave Moss (aka Spaz from The Lost Boys) and said to be written by Genital Grinder from Alcoholica, who is in fact Sprog from The Lost Boys. (https://demozoo.org/groups/35459/). So an inside job :)
  As it was provided to Richard directly, it was a joke to target UVK and show how to bypass weak immunization schemes.
- I think the smallest symptoms routine ever, one line :)
- the description in the UVK book is not totally accurate:
   - "Virus can copy to drive(s): Current drive (floppy only), and only to immunized disks.": Only true with UVK and UVK immunized bootsector which writes a RTS at 0x3a as it replicates only if the 3 possible words are found at 0x3A. Especially the case for empty bootsectors as it could be 0000. And most vaccined disks won't be touched.
   - "When does that happen: After 20 copies of itself are made": not what I saw, it happens after 20 calls to getBPB()

## See the virus in action!

{% from '/html/macros/emulator.html' import emulator %}
{{ emulator("chaosmegacunt", False) }}