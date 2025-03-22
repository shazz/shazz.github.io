Title: ACIA
Slug: AciaVirus
Name: ACIA virus
Date: 2025-03-17 17:30
Location: Montreal / Canada
Category: Atari ST, Virus
Lang: en
Author: shazz
status: hidden
summary: This article is about the ACIA virus...
image: {filename}../../../gallery/viruses/AciaVirus.png
Source: no
UVK: 
OtherName: |3|[ACIA](/AciaVirus-en.html)|Temporary Madness Virus|yes|72||ACIA.S|
Tags: bootsector virus

## In a few words...

This virus does not have a description.

The following symptoms may happen: after 22 minutes, the mouse Y axis will be inverted for 10s.

## Details

 - **Replication**: on any floppy when a get_bpb() is called, except if the virus signature is found (value 5 at 4th byte of the bootsector)
 - **Bootcode size**: 308 bytes.
 - **Resident address**: diskbuf.
 - **Start address**: 0x40.
 - **Stealth address**: 0x600.
 - **Attached vectors**: hdv_bpb, vbl_queue.
 - **Reset resistance**: Yes.
 - **TOS**: All.

### What's special ?

- A kind of rework of the Ghost virus, done differently. This kind to invert the mouse Y axis, commands are sent to the ACIA from a VBL queue routine. Works but fairly bigger and complicated.
- As commonly seen, it uses the undocumented resident routine to set up the vectors but from a set of addresses previously saved in 0x5e4-0xef8
- uses FLOCK to decide to show the symptoms or not, not clear why
    
How to trigger the symptoms?
- Install the virus and reboot, check the hdv_bpb vector is set and also the Resident routine to $600
- Quit to GEM and run Tiny Tool accessory
- Read memory address $5e0, set the byte to $FE and click Write
- Wait a few seconds and the mouse will be inverted for 10s

### Fun facts

- the description in the UVK book is not totally accurate:
   - "Virus attaches itself to: Hdv_bpb, undocumented reset-resistant.": also tho vbl queue
   - "Disks can be immunized against it: No": in fact yes if the signature is set in the OEM bytes

## See the virus in action!

{% from '/html/macros/emulator.html' import emulator %}
{{ emulator("AciaVirus", False) }}