Title: G data Fake
Slug: g-data
Name: G data Fake virus
Date: 2025-03-22 18:22
Location: Montreal / Canada
Category: Atari ST, Virus
Lang: en
Author: shazz
status: hidden
summary: This article is about the G data Fake virus...
image: {filename}../../../gallery/viruses/g-data.png
Source: no
UVK: 
OtherName: |40|[G data Fake](/g-data-en.html)|G-DATA Virus|yes|38||G_DATA_FAKE.S|
Tags: bootsector virus

## In a few words...

This virus does not have a description.

The following symptoms may happen: Shows G-DATA like boot message "ANTI-VIREN KIT 3 KEIN VIRUS IM BOOTSEKTOR" then after 5 replication, the message " !! LAXY 1 !! " (does not work in the original version)

## Details

 - **Replication**: on every floppy without a "BRA" (0x60) in the bootsector branch.
 - **Bootcode size**: 384 bytes.
 - **Resident address**: PHYSTOP - 0x200.
 - **Start address**: 0x1e (0x20 is the branch address).
 - **Stealth address**: N/A.
 - **Attached vectors**: hdv_rw.
 - **Reset resistance**: No.
 - **TOS**: All.

### What's special ?

- the original code was totally buggy and could not replicate as the hdv_rw vector could not work as is.
- tries to mimic the G-DATA vaccine boot (I did not find it so I cannot verify how similar it looks like)
- except that, nothing special.

### Fun facts

- No clue how this virus could have spread (I doubt) as it was pretty buggy, some bra and bsr mixed, rts where it should not, movem to restore registers at the wrong place
- It did not look to be finished as the symptoms part was not implemented, only the counter comparison
- Volker Söhnitz, who probably discovered the virus, thought the end of the bootsector was corrupted, mixed with the remaining of another bootsector it overrided. 
  I don't think so as the virus signature (LAXY 1) was written after the "foreign" code and this code is not random, that's the sleep routine of the MAD virus. 
  So my bet is that his author wanted to create his own virus based on the MAD virus which is pretty similar in the structure.
- The description in the UVK book is not totally accurate:
  - The virus binds to hdv_rw and not hdv_bpb
  - it doesn't tell the virus cannot replicate as it
  - It is not based at all on the Exception virus but the MAD virus
;

## See the virus in action!

{% from '/html/macros/emulator.html' import emulator %}
{{ emulator("g-data", False) }}