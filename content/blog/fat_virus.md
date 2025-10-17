Title: Atari ST FAT Viruses: Exploiting Hidden Filesystem Structures
Slug: fatviruses
Date: 2025-10-16 16:34
Location: Montreal / Canada
Category: Atari ST, Virus
Lang: en
Author: shazz
status: published
summary: Learn more about FAT viruses. Those bootsectors viruses extend their capabilities by hiding some additional code into unused or hidden FAT sectors.
image: {filename}images/max_t.png
Tags: learning, viruses

## Technical Overview of Atari ST Bootsector Viruses

The Atari ST's file system and low-level disk structure provided a unique attack surface for early computer viruses, particularly those targeting the File Allocation Table (FAT) and bootsector. <BR>These viruses leveraged the intricate details of the Atari TOS (The Operating System) to propagate and hide malicious code.

## Filesystem Architecture Vulnerabilities

The Atari ST used a FAT filesystem similar to early MS-DOS systems, with some key characteristics:

- Floppy disk format: Typically 9 sectors of 512 bytes per track
- Western Digital WD1772 Floppy Disk Controller
- Boot sector located in the first physical sector, 512 bytes, ~480 bytes usable
- Some MS-DOS BPB fields not used. BPB data encoded as Little Endian as it is the case for MS-DOS (while the ST is Big Endian)

## Notable Viruses and Their Techniques

### The Swiss Virus

<b>Key Characteristics</b>:

- *Type*: Memory-resident bootsector virus
- *Other names*: Blot virus, FAT virus
- *Discovery Date*: <b>May 1st 1988</b> by Stephen E. Schneider.
- *Origin*: probably from Swiss hence the name
- *Propagation*: Copies to drive A
- *Polymorphism*: no
- *Destructive Payload* based on the unique loaded FAT sector: 
    - when `hz200` counter has reached 3 hours, it will blackened the screen from top and bottom to middle
- *Infection Vector*: Attaches to the `Hdv_bpb` (hard drive parameter block), timer C,etv critic and reset vectors and undocumented resident routine.
- *Notes*: 
    - the FAT sector code is only 170 bytes dedicated to replicate the FAT sector and trigger the symptoms.
    - Works with German TOS 1.0 only due to `dskbuf` hardcoded address

### The Beilstein Virus

<b>Key Characteristics</b>:

- *Type*: Reset-proof memory-resident bootsector virus
- *Origin*: written by a student from Beilstein, a town in South Germany (hence its name)
- *Discovery Date*: <b>March 16th 1993</b> by Volker Söhnitz.
- *Propagation*: Copies to drive A
- *Polymorphism*: use dual encryption
- *Destructive Payload* based on the loaded FAT sectors: 
    - Delete specific files when `MDISK`, `FCOPYIII`, `FCOPY3??`, `DISKUS`, `DISKDEMO`, `TED_???` and `G_COPY`
    - Clear partition `C` of your hard disk when the virus in memory discovers that you are trying to trace it (trace bit set, for example in a debugger).
    - Create garbage on your screen.
    - Keyboard, mouse and joystick disabled.
    - Mouse movements inverted.
    - Printer output corrupted.
    - Modem output corrupted.
    - A bomb error created.
    - The system frozen until you enter the password "Apokalypse".
    - Memory cleared, followed by a reset.
    - The first hundred sectors of a floppy disk cleared.
    - Delete a folder.

- *Infection Vector*: Uses undocumented reset-resistant vector and `Hdv_bpb`, `Vbl_queue`, `Hdv_rw`, `Hdv_boot`, `GEMDOS`, `XBIOS`


### The Lucky Lady 4.12 Virus

<b>Key Characteristics</b>:

- *Type*: Reset-proof memory-resident bootsector virus
- *Origin*: written by Lucky Lady from Slovenia.
- *Discovery Date*: <b>March 1994</b> by Richard Karsmakers.
- *Propagation*: Copies to drive A
- *Polymorphism*: no
- *Destructive Payload* based on the loaded FAT sectors: 
    - It puts message "Lucky Lady forbids you to load the UVK!" on screen, then erases `UVK_x_x.PRG` files from current drive when you try to load the "Ultimate Virus Killer"
    - Mouse cursor is changed from TOS arrow to Lucky Lady’s logo (LL) after approximately 35 minutes on monochrome (this takes a bit longer on colour).
    - Screws up the screen
    - Logical clusters 351 & 352 are overwritten and marked as ‘bad’ in the FAT (Every cluster entry after 351 is thus a "floating entry" if there was a file (data lost) present before on a disk)
- *Infection Vector*: `Hdv_bpb`, `resvector`, `vbl_queue`.


## Technical Infection Mechanism

These viruses typically exploited the filesystem's structure by:

1. <b>Intercepting system vectors</b> during boot process
2. <b>Hiding additional code in unused or hidden FAT sectors</b>
3. <b>Modifying bootsector to ensure virus persistence</b>

## Virus Propagation Techniques

- <b>Memory Residence</b>: Staying active after system boot
- <b>Disk Infection</b>: Copying themselves to attached drives
- <b>Vector Hijacking</b>: Intercepting critical system interrupt vectors

## Immunization and Detection

Antivirus tools like the Ultimate Virus Killer (UVK) 2000 could partially detect these viruses by:

- Checking specific memory offsets
- Verifying bootsector integrity
- Monitoring system vector modifications

But as far as I know, no antivirus was checking the FAT sectors to find malicious content, the Swiss and Beilstein viruses were recognized by identifying their bootsector loader. 


## Historical Context and Possible Lost FAT Virus

The most widespread virus of this era was the <b>Signum/BPL Virus A</b>, estimated to have infected approximately <b>1.5 million disks worldwide</b>. This virus emerged during a period of limited system security and minimal antivirus protection. As this ewas a key virus, it was patiently waiting for his companion bootsector, the Key, to trigger the symptoms which may have been located on FAT sectors but as nobody found the key, it is justr speculaion.

## Technical Significance

These Atari ST viruses represented an early example of:

- <b>Sophisticated low-level filesystem manipulation</b>
- <b>Memory-resident malware techniques</b>
- <b>Exploiting operating system design vulnerabilities</b>

## Conclusion and resources

The FAT viruses on the Atari ST demonstrated the vulnerabilities inherent in early computer systems, showcasing how malicious actors could exploit filesystem structures to create persistent and potentially destructive malware.

This article explains the BPB structure and how FAT sectors are defined:
- [Q140418: Detailed Explanation of FAT Boot Sector](https://jeffpar.github.io/kbarchive/kb/140/Q140418/)
