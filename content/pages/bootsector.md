Title: How Atari bootsectors work ?
Slug: HowBootsectorsWork
Date: 1994-10-06 12:34
Location: Slovenia
Category: Atari ST
Lang: en
Author: Lucky Lady

### How bootsector works

Bootsector is the first sector (#0) on an TOS disk, it is also called "the boot track". It tells your computer several necessary things about the nature of the disk and whether or not the boot program can be loaded from the disk or code must be found elsewhere.
First, an executable boot sector must "word-checksum" to the value of $1234 (4660). If the checksum is correct, the system does a JSR to the first byte of the buffer where the boot code was loaded. Since the buffer location is variable, code in the bootsector must be relative, not location-independent!

The bootsector is normally written down when a disk is formatted or an entire disk is copied onto another. 
The bootsector includes a "BIOS Parameter Block" (BPB) which contains essential information concerning the disk and is structured like this:

### The bootsector construction

```
byte:   label:      meaning:                    values:
$00     BRA.S       branch to boot code         00 00
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

  Values are for standard double sided floppy disk.
  BRA.S ="BRAnch to... .S=short" in MC680x0 assembly language.

The values described here refer to typical values found on a double sided non-boot disk. 
The OEM bytes are used on a boot disk and may be on other company disks but are not used on a generic non-boot disk. 
The serial number is written at format time and is meant to be unique so TOS can tell if a disk has been swapped.
For some tools to be able to manipulate the loader, the OEM bytes must be $4C 6F 61 64 65 72 ("Loader" in ASCI). 
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
eight characters and a three character extension. Of course, if bootsector is executable but is not a boot loader the values on bytes from $1E to $3A are not necessary to be set.



