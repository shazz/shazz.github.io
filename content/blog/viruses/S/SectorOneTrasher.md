Title: Sectorone Trasher
Slug: SectorOneTrasher
Name: Sectorone Trasher virus
Date: 2025-03-17 17:30
Location: Montreal / Canada
Category: Atari ST, Virus
Lang: en
Author: shazz
status: hidden
summary: This article is about the Sectorone Trasher virus...
image: {filename}../../../gallery/viruses/SectorOneTrasher.png
Source: no
UVK: 
OtherName: |72|[Sectorone Trasher](/SectorOneTrasher-en.html)|5th Generation virus|yes|13||SECTORONE.S|
Tags: bootsector virus

## In a few words...

This virus does not have a description.

The following symptoms may happen: Each time it replicates on a non-executable bootsector, it will decrease the generation counter in the bootsector.

## Details

 - **Replication**: At each call to rwabs if the bootsector is not executable
 - **Bootcode size**: 260 bytes.
 - **Resident address**: PHYSTOP - 0x208 (0xFFDF8 on a 1MB ST).
 - **Start address**: 0x1e.
 - **Stealth address**: N/A.
 - **Attached vectors**: Trap 13 (bios).
 - **Reset resistance**: No.
 - **TOS**: All.

### What's special ?

- Use the BIOS trap to catch rwabs calls
- Code not optimized and obfuscated. Floprd and Flopwr calls are easy to spot.
- The target upper RAM address is unusual (PHYSTOP-0x208), looking like a stealth location but not on boundary and no header. 
  Part will remain (inactive) in memory as In generally, in both reset cases, memory is zeroed from (`phystop` - `0x200`) to `0x800`. 
;

### Fun facts

- in the floppy image I got the virus should not work as intented:
   - the buffer pointer provided to erase part of the floppy disk was set to 0 and it looks like it does not do the job (fortunately ? or it was patched?)
- the description in the UVK book is not totally accurate:
   - It is called the "5th Generation Virus" but as the generation counter is in the bootsector, it could depends of how many times this virus replicated. Based on the code, it resets to 6. So it should be the 7th Generation Virus :)
   - "Writes trash in the first 34 sectors of a disk": "only" on the first 18 sectors but the result is the same somewhat.
   - "When the virus has reached its fifth generation": in fact no, when the generation counter reaches 0. So depends of the starting point but looks to be 6.
   - Missing the point that the virus only replicates on non executable disks? Or maybe this is what this sentence means: "Disks can be immunized against it: Yes (executable)."

## See the virus in action!

{% from '/html/macros/emulator.html' import emulator %}
{{ emulator("SectorOneTrasher", False) }}