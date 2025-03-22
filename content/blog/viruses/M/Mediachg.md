Title: Media Change
Slug: Mediachg
Name: Media Change virus
Date: 2025-03-17 17:30
Location: Montreal / Canada
Category: Atari ST, Virus
Lang: en
Author: shazz
status: hidden
summary: This article is about the Media Change virus...
image: {filename}../../../gallery/viruses/Mediachg.png
Source: no
UVK: 
OtherName: |58|[Media Change](/Mediachg-en.html)|Media Change Virus|yes|39||MEDIACHG.S|
Tags: bootsector virus

## In a few words...

This virus does not have a description.

The following symptoms may happen: occurs every modulo 5 generations, invert the 2 first palette colors and play a sound. The generation is only incremented at boot time AND when the virus is not yet in resident memory

## Details

 - **Replication**: on the BOOTDEV device after any call on mediach()
 - **Bootcode size**: 480 bytes.
 - **Resident address**: only DISKBUF.
 - **Start address**: 0x1e.
 - **Stealth address**: 0xF7E00.
 - **Attached vectors**: hdv_mediach, undocumented resident routine.
 - **Reset resistance**: yes.
 - **TOS**: all.

### What's special ?

- Some code similar to the CT virus and Gauweil (especially memory protection routine)
- Use hdv_mediach vector instead of hdv_bpb or hdv_rw vectors to replicate and rwabs to write bootsector rather than flopwr
- Code not optimized at all
- The generation counter is only really incremented at cold start as it is done in the resident routine which is installed only if not yet installed.
- Use the undcoumented reset resident location to resist to reset but also as the main memory location of the virus
;

### Fun facts

- the description in the UVK book is not totally accurate:
   - "What can happen: Text turns to screen colour.": not really, a sound played and palettes entries 0 and 1 inverted
   - "When does that happen: Every fifth copy.": not exactly, at every multiple of 5 generation, new generation occurs after a cold reset.
- A corrupted message "N ! S IN ACTION ! ! CTION" probably to be shown is included in the last bytes of the virus but cannot bet displayed due to the size of the resident routine. The fixed version displays the message which by reducing the code size and adding the display code

## See the virus in action!

{% from '/html/macros/emulator.html' import emulator %}
{{ emulator("Mediachg", False) }}