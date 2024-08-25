Title: How Virus Work
Slug: HowVirusWork
Date: 1994-10-06 12:34
Location: Slovenia
Category: Atari ST
Lang: en
Author: Lucky Lady

### HOW BOOTSECTOR WORKS

Bootsector is the first sector (#0) on an TOS disk, it is also called "the boot track". It tells your computer several necessary things about the nature of the disk and whether or not the boot program can be loaded from the disk or code must be found elsewhere.
First, an executable boot sector must "word-checksum" to the value of $1234 (4660). If the checksum is correct, the system does a JSR to the first byte of the buffer where the boot code was loaded. Since the buffer location is variable, code in the bootsector must be relative, not location-independent!

The bootsector is normally written down when a disk is formatted or an entire disk is copied onto another. 
The bootsector includes a "BIOS Parameter Block" (BPB) which contains essential information concerning the disk and is structured like this:

### THE BOOTSECTOR CONSTRUCTION

```
byte:   label:      meaning:                    valuesý:
$00     BRA.Sþ      branch to boot code         00 00
$02     ......      reserved bytes for OEM code .. .. .. .. .. ..
$08     SERIAL      24-bit serial number        .. .. ..
$0B     BPS         bytes per sector            00 02
$0D     SPC         sectors per cluster         02
$0E     RES         number of reserved sectors  01 00
$10     NFATS       number of FATs              02
$11     NDIRS       number of directory entries 70 00
$13     NSECTS      number of sectors on media  A0 05
$15     MEDIA       description byte of media   F9
$16     SPF         number of sectors per FAT   05 00
$18     SPT         number of sectors per track 09 00
$1A     NSIDES      number of sides on media    02 00
$1C     NHID        number of hidden sectors    00 00
$1E     -           BOOT CODE (if any)          -
```

 ý Values are for standard double sided floppy disk.
 þ BRA.S ="BRAnch to... .S=short" in MC680x0 assembly language.

The values described here refer to typical values found on a double sided non-boot disk. 
The OEM bytes are used on a boot disk and may be on other company disks but are not used on a generic non-boot disk. 
The serial number is written at format time and is meant to be unique so TOS can tell if a disk has been swapped.
For some tools to be able to manupulate the loader, the OEM bytes must be $4C 6F 61 64 65 72 ("Loader" in ASCI). 
The final two bytes (one word) of the boot sector are reserved for the "evening out" value which allows the checksum to be corrected accordingly.

The boot loader also contains specific information as well:

```
byte:   label:      meaning:  
$1E     EXECFLG     copied to cmdload
$20     LDMODE      load mode
$22     SSECT       sector start
$24     SCETCNT     number of sectors to load
$26     LDADDR      load address
$2A     FATBUF      FAT address
$2E     FNAME       file name if LDMODE is 0
$39     .           reserved
$3A     BOOTIT      boot code
```

If LDMODE is zero, then the filename in FNAME is searched and loaded. If non-zero, then the number of sectors in SECTCNT is loaded, beginning with SSECT. FATBUF points to the location in RAM where the FAT and directory is placed. FNAME consists of
eight characters and a three character extension. Of course, if bootsector is executable but is not a boot loader the values on bytes from $1E to $3A are not neccesary to be set.

### BOOTING

Upon a cold or warm bootý, microprocessors in the 680x0 series load the initial supervisor stack pointer from the second longword in memory ($4) and begin execution at the PC found in the first longword ($0). The location this points to is the
base initialization point for the Atari computers.
Every Atari computer or TOS clone follows a predefined set of steps to accomplish system initialization. The following illustrates these steps leaving out some hardware initialization which is specific to the particular computer line (ST, TT,
Falcon, etc.).

 ýA cold boot occurs when the computer system experiences a total loss of power and no memory locations can be considered valid (this can be done artificially by zeroing memory, as is the case with the CTRL_ALT_rightSHIFT-DELETE reset). A warm boot
 is a manual restart of the system which can be accomplished via software or the reset button or with CTRL-ALT_DELETE reset.

step / description:

1. The Interrupt Priority Level (IPL) is set to 7 and the OS switches to supervisor mode.

2. A RESET instruction is executed to reset external hardware devices.

3. The presence of diagnostic cartridge is determined. If one is inserted, it is JMP'ed to with a return address in register A6.

4. If running on a MC68030/68040, the CACR, VBR, TC, TT0 and TT1 registers are initialized.

5. If a floating-poin coprocessor is present it is initialized.

6. If the memvalid ($4F2), memval2 ($43A), and memval3 ($51A) system variables are all valid, a warm boot is assumed and the memory controller is initialized with the return value from memcntrl ($424).

7. The initial color palette registers are loaded and the screen base is initialized to $100000.

8. Memory is sized if it wasn't from a previous reset.

9. Magic numbers are stored in low memory to indicate the successful sizing and initialization of memory.

10. System variables and the cookie jar are initialized.

11. The BIOS initialization point is executed.

12. Installed cartridges of type 2 are executed.

13. The screen resolution is programmed.

14. Installed cartridges of type 0 are executed.

15. Interrupts are enabled by lowering the IPL to 3.

16. Installed cartridges of type 1 are executed.

17. If running TOS 2.06, 3.06, 4.0x or 5.0x, the Fuji logo is displayed and a memory test and hard disk spin-up sequence is executed.

18. If at least one floppy drive is attached to the system, the first sector (bootsector) of the first floppy drive is loaded 
 and if executable, it is called.

19. If at least one hard disk or other media is attached to the system, the first sector of each is loaded in succession until one with an executable sector is found or each has been tried.

20. If a hard disk sector was found that was executable, it is executed.

21. The text cursor is enabled.

22. All "\AUTO\*.PRG" files found on the boot disk are executed.

23. If cmdload ($482) is 0 then an evironment string is created and the AES is launched, otherwise "\COMMAND.PRG" is loaded.

24. If the AES ever terminates, the system is reset and system initialization begins again.

### IMPORTANT SYSTEM VECTORS AND MEMORY LOCATIONS

In previous section, we mentioned cold and warm reset. For every virus coder it is very important to know what's going on at reset 
sequence esspecially concerning memory locations and system vectors. 
In generally: in both reset cases memory is zeroed from (phystop - $200) to $800. 
Just before that, TOS searches memory in steps of two memory pages (512 bytes) in "hope" to find a following contents: longword $12123456 and a longword of actual double memory page. 
In successful case, TOS first does a word checksum, which has to be $5678. If that is correct, the code on that double memory page is executed through JSR with return
address in A6.

As you can see, there are two areas to place a code to survive a warm resetþ: down from address $800 or up from phystop by simpling lowering the phystop itself. System vectors beggins at address $400 but there are many of other vectors in area from $0 to $800. The most popular address to place a virus or antivirus or anykind of a resetproof code is $140. At that address
Multi-Function Pheripheral Port Vectors are placed, but they have any meaning only on a machines based on TOS 3.0x (TT, Medusa T40 and Eagle computers). Of course, you can place a virus at $140 on TOS 3.0x as well, but it can not be reset proof.

 þ"In the old days" of virus coding there was always one simple rule: If you turned off your computer - no code could survive a cold reset! Nowadays that is not true anymore! A cold reset can code survive on a systems such as Mega ST, Mega STE, TT, Falcon030, Medusa T040 and Eagle or on a updated other ST or STE through a placing it to NVM (Non Volatile Memory), this is the battery backed-up memory, which remains untouched even if your computer stays shut off for a long time (some months).
 Well, there is another way, more comfortable as space concers, but more of this one will be told in further versions of UVD. 

Everything you have to know about systems vectors and about an imortant memory locations is in a book avaible at SSO: "Lucky Lady's Atari Virus Cook Book" written by Lucky Lady of Lucky Lady Coding Group. Refer to that guide for further informations.
