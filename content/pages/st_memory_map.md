Title: The Atari ST/TT/Falcon Memory Map
Slug: AtariMemoryMap
Date: 1994-01-22 08:08
Location: Ohio, US
Category: Atari ST, Virus
Lang: en
Author: shazz
status: hidden
Summary: Atari ST/STe/MSTe/TT/F030 Hardware Register Listing


```
             .---------------------------------------------------.
             |Atari ST/STe/MSTe/TT/F030 Hardware Register Listing|
             `---------------------------------------------------'
                        <<< EXCLUSIVE ST-NEWS VERSION >>>

                      Version 7.0 (FINAL REVISION) - 1/22/94
                                  By Dan Hollis
                 Copyright (C) 1993/1994 MicroImages Software

##############################################################################
########## THIS IS THE LAST VERSION OF THE LISTING TO BE DISTRIBUTED #########
##############################################################################
Due to the absence of feedback, combined with the lack of free time, I will no
longer be updating this listing. This is the FINAL revision.
------------------------------------------------------------------------------
This document may only be copied unmodified, in its entirety. This document
may ONLY be copied freely, and may NOT be sold. I make no guarantees as to the
accuracy of this document. I cannot be responsible for the use or misuse of
information contained within this document. Use at your own risk! Regardless,
every effort has been taken to ensure this document is as complete and
accurate as possible.
------------------------------------------------------------------------------

Many thanks to the following people for their contributions!

Markus Gutschke, Alexander Herzlinger, Karsten Isakovic, Thomas Binder,
Julian Reschke, Georges Kesseler, Torbjoern Ose, Rickard Troedsson,
Martin Griffiths, Eric Prevoteau


Any comments or questions can be sent to me at the following addresses:

Internet : goemon@venice.mps.ohio-state.edu
MCI Mail : 679-5560
Snail : Dan Hollis
        744 NW Kinney
        Grants Pass, OR 97526
        U.S.A.

Address Description                                                      Space
-------+----------------------------------------------------------------+-----
########CPU Reset Vectors                                               ######
-------+----------------------------------------------------------------+-----
$000000|Reset : Initial SSP                                             |SP
$000004|Reset : Initial PC                                              |SP
-------+----------------------------------------------------------------+-----
########CPU Exception Vectors                                           ######
-------+----------------------------------------------------------------+-----
$000008|Bus Error                                                       |SD
$00000C|Address Error                                                   |SD
$000010|Illegal Instruction                                             |SD
$000014|Zero Divide                                                     |SD
$000018|CHK, CHK2 Instruction                                           |SD
$00001C|cpTRAPcc, TRAPcc, TRAPV                                         |SD
$000020|Privilege Violation                                             |SD
$000024|Trace                                                           |SD
$000028|Line 1010 Emulator (LineA)                                      |SD
$00002C|Line 1111 Emulator (LineF)                                      |SD
$000030|(Unassigned, Reserved)                                          |SD
$000034|Coprocessor Protocol Violation (68030)                          |SD
$000038|Format Error (68010)                                            |SD
$00003C|Uninitialized Interrupt Vector                                  |SD
$000040|(Unassigned, Reserved)                                          |SD
   :   |   :             :                                              | :
$00005F|(Unassigned, Reserved)                                          |SD
$000060|Spurious Interrupt (Bus error during interrupt)                 |SD                                          
-------+----------------------------------------------------------------+-----
########Auto-Vector Interrupts                                          ######
-------+----------------------------------------------------------------+-----
$000064|Level 1 Int Autovector (TT VME)                                 |SD
$000068|Level 2 Int Autovector (HBL)                                    |SD
$00006C|Level 3 Int Autovector (TT VME)                                 |SD
$000070|Level 4 Int Autovector (VBL)                                    |SD
$000074|Level 5 Int Autovector                                          |SD
$000078|Level 6 Int Autovector (MFP)                                    |SD
$00007C|Level 7 Int Autovector                                          |SD
-------+----------------------------------------------------------------+-----
########Trap Instruction Vectors (Trap #n = Vector number + 32 + n)     ######
-------+----------------------------------------------------------------+-----
$000080|Trap #0                                                         |SD
$000084|Trap #1 (GemDOS)                                                |SD
$000088|Trap #2 (AES/VDI)                                               |SD
$00008C|Trap #3                                                         |SD
$000090|Trap #4                                                         |SD
$000094|Trap #5                                                         |SD
$000098|Trap #6                                                         |SD
$00009C|Trap #7                                                         |SD
$0000A0|Trap #8                                                         |SD
$0000A4|Trap #9                                                         |SD
$0000A8|Trap #10                                                        |SD
$0000AC|Trap #11                                                        |SD
$0000B0|Trap #12                                                        |
$0000B4|Trap #13 (BIOS)                                                 |SD
$0000B8|Trap #14 (XBIOS)                                                |SD
-------+----------------------------------------------------------------+-----
########Math Coprocessor Vectors (68881/68882/Internal)                 ######
-------+----------------------------------------------------------------+-----
$0000C0|FFCP Branch or Set on Unordered Condition                       |SD
$0000C4|FFCP Inexact Result                                             |SD
$0000C8|FFCP Divide by Zero                                             |SD
$0000CC|FFCP Underflow                                                  |SD
$0000D0|FFCP Operand Error                                              |SD
$0000D4|FFCP Overflow                                                   |SD
$0000D8|FFCP Signaling NAN                                              |SD
$0000DC|(Unassigned, Reserved)                                          |SD
-------+----------------------------------------------------------------+-----
########PMMU Coprocessor Vectors (68851/Internal)                       ######
-------+----------------------------------------------------------------+-----
$0000E0|MMU Configuration Error                                         |SD
$0000E4|MC68851, not used by MC68030                                    |SD
$0000E8|MC68851, not used by MC68030                                    |SD
-------+----------------------------------------------------------------+-----
########Miscellaneous Vectors                                           ######
-------+----------------------------------------------------------------+-----
$0000EC|(Unassigned, Reserved)                                          |SD
   :   |   :             :                                              | :
$0000FF|(Unassigned, Reserved)                                          |SD
-------+----------------------------------------------------------------+-----
########User Assigned Interrupt Vectors                                 ######
-------+----------------------------------------------------------------+-----
$000100|ST-MFP-0 - Centronics busy                                      |SD
$000104|ST-MFP-1 - RS-232 DCD                                           |SD
$000108|ST-MFP-2 - RS-232 CTS                                           |SD
$00010C|ST-MFP-3 - Blitter done                                         |SD
$000110|ST-MFP-4 - Timer D (USART timer)                                |SD
$000114|ST-MFP-5 - Timer C (200hz Clock)                                |SD
$000118|ST-MFP-6 - Keyboard/MIDI (ACIA)                                 |SD
$00011C|ST-MFP-7 - FDC/HDC                                              |SD
$000120|ST-MFP-8 - Timer B (HBL)                                        |SD
$000124|ST-MFP-9 - Send Error                                           |SD
$000128|ST-MFP-10 - Send buffer empty                                   |SD
$00012C|ST-MFP-11 - Receive error                                       |SD
$000130|ST-MFP-12 - Receive buffer full                                 |SD
$000134|ST-MFP-13 - Timer A (STe sound)                                 |SD
$000138|ST-MFP-14 - RS-232 Ring detect                                  |SD
$00013C|ST-MFP-15 - GPI7 - Monochrome Detect                            |SD
$000140|TT-MFP-0 - GPI 0                                                |SD
$000144|TT-MFP-1 - GPI 1                                                |SD
$000148|TT-MFP-2 - SCC-DMA Controller                                   |SD
$00014C|TT-MFP-3 - Ring Indicator SCC B                                 |SD
$000150|TT-MFP-4 - Timer D                                              |SD
$000154|TT-MFP-5 - Timer C                                              |SD
$000158|TT-MFP-6 - (Reserved) GPI 4                                     |SD
$00015C|TT-MFP-7 - SCSI DMA Controller                                  |SD
$000160|TT-MFP-8 - Timer B                                              |SD
$000164|TT-MFP-9 - Send Error                                           |SD
$000168|TT-MFP-10 - Send buffer empty                                   |SD
$00016C|TT-MFP-11 - Receive error                                       |SD
$000170|TT-MFP-12 - Receive buffer full                                 |SD
$000174|TT-MFP-13 - Timer A                                             |SD
$000176|TT-MFP-14 - TT Clock (MC146818A)                                |SD
$00017C|TT-MFP-15 - TT-SCSI Drive Controller NCR 5380                   |SD
$000180|SCC Interrupt                                                   |SD
$0001BC|SCC Interrupt                                                   |SD
$0001C0|User Defined, Unused                                            |SD
   :   |  :     :        :                                              | :
$0003FC|User Defined, Unused                                            |SD
-------+----------------------------------------------------------------+-----

Address Size  Description                                           Name
-------+-----+-----------------------------------------------------+----------
##############System Crash Page                                    ###########
-------+-----+-----------------------------------------------------+----------
$000380|long |Validates System Crash Page if $12345678             |proc_lives
$000384|.....|Saved registers D0-D7                                |proc_dregs
$0003A4|.....|Saved registers A0-A7                                |proc_aregs
$0003C4|long |Vector number of crash exception                     |proc_enum
$0003C8|long |Saved USP                                            |proc_usp
$0003CC|.....|Saved 16 words from exception stack                  |proc_stk
-------+-----+-----------------------------------------------------+----------
##############System Variables                                     ###########
-------+-----+-----------------------------------------------------+----------
$000400|long |GEM Event timer vector                               |etv_timer
$000404|long |GEM Critical error handler                           |etv_critic
$000408|long |GEM Program termination vector                       |etv_term
$00040C|long |GEM Additional vector #1 (Unused)                    |etv_xtra
   :   |  :  | :      :        :     :    :                        |   :
$00041C|long |GEM Additional vector #5 (Unused)                    |etv_xtra
$000420|long |Validates memory configuration if $752019F3          |memvalid
$000424|word |Copy of contents of $FF8001                          |memctrl
$000426|long |Validates resvector if $31415926                     |resvalid
$00042A|long |Reset vector                                         |resvector
$00042E|long |Physical top of RAM                                  |phystop
$000432|long |Start of TPA (user memory)                           |_membot
$000436|long |End of TPA (user memory)                             |_memtop
$00043A|long |Validates memcntrl and memconf if $237698AA          |memval2
$00043E|word |If nonzero, floppy disk VBL routine is disabled      |flock
$000440|word |Floppy Seek rate - 0:6ms, 1:12ms, 2:2ms, 3:3ms       |seekrate
$000442|word |Time between two timer calls (in milliseconds)       |_timer_ms
$000444|word |If not zero, verify floppy disk writes               |_fverify
$000446|word |Default boot device                                  |_bootdev
$000448|word |0 - NTSC (60hz), <>0 - PAL (50hz)                    |palmode
$00044A|word |Default video resolution                             |defshiftmod
$00044C|word |Copy of contents of $FF8260                          |sshiftmod
$00044E|long |Pointer to video RAM (logical screen base)           |_v_bas_ad
$000452|word |If not zero, VBL routine is not executed             |vblsem
$000454|word |Number of vertical blank routines                    |nvbls
$000456|long |Pointer to list of vertical blank routines           |_vblqueue
$00045A|long |If not zero, points to color palette to be loaded    |colorptr
$00045E|long |If not zero, points to video ram for next VBL        |screenpt
$000462|long |Counter for number of VBLs                           |_vbclock
$000466|long |Number of VBL routines executed                      |_frclock
$00046A|long |Vector for hard disk initialization                  |hdv_init
$00046E|long |Vector for resolution change                         |swv_vec
$000472|long |Vector for getbpb for hard disk                      |hdv_bpb
$000476|long |Vector for read/write routine for hard disk          |hdv_rw
$00047A|long |Vector for hard disk boot                            |hdv_boot
$00047E|long |Vector for hard disk media change                    |hdv_mediach
$000482|word |If not zero, attempt to load "COMMAND.PRG" on boot   |_comload
$000484|byte |Attribute vector for console output       BIT 3 2 1 0|conterm
       |     |Return "kbshift" for BIOS conin --------------' | | ||
       |     |System bell (1 - on) ---------------------------' | ||
       |     |Key repeat (1 - on) ------------------------------' ||
       |     |Key click (1 - on) ---------------------------------'|
$000486|long |Return address for TRAP #14                  (unused)|trp14ret
$00048A|long |Return address for critical error handler    (unused)|criticret
$00048E|long |Memory descriptor block                              |themd
$00049E|long |Space for additional memory descriptors              |themdmd
$0004A2|long |Pointer to BIOS save registers block                 |savptr
$0004A6|word |Number of connected floppy drives                    |_nflops
$0004A8|long |Vector for screen output                             |con_state
$0004AC|word |Temporary storage for cursor line position           |save_row
$0004AE|long |Pointer to save area for exception processing        |sav_context
$0004B2|long |Pointer to buffer control block for GEMDOS data      |_bufl
$0004B6|long |Pointer to buffer control block for GEMDOS fat/dir   |_bufl
$0004BA|long |Counter for 200hz system clock                       |_hz_200
$0004BC|long |Pointer to default environment string                |the_env
$0004C2|long |Bit allocation for physical drives (bit 0=A, 1=B..)  |_drvbits
$0004C6|long |Pointer to 1024-byte disk buffer                     |_dskbufp
$0004CA|long |Pointer to autoexecute path                          |_autopath
$0004CE|long |Pointer to VBL routine #1                            |_vbl_lis
   :   |  :  |  :      :  :     :     :                            |    :
$0004EA|long |Pointer to VBL routine #8                            |_vbl_lis
$0004EE|word |Flag for screen -> printer dump                      |_dumpflg
$0004F0|word |Printer abort flag                                   |_prtabt
$0004F2|long |Pointer to start of OS                               |_sysbase
$0004F6|long |Global shell pointer                                 |_shell_p
$0004FA|long |Pointer to end of OS                                 |end_os
$0004FE|long |Pointer to entry point of OS                         |exec_os
$000502|long |Pointer to screen dump routine                       |scr_dump
$000506|long |Pointer to _lstostat()                               |prv_lsto
$00050A|long |Pointer to _lstout()                                 |prv_lst
$00050E|long |Pointer to _auxostat()                               |prv_auxo
$000512|long |Pointer to _auxout()                                 |prv_aux
$000516|long |If AHDI, pointer to pun_info                         |pun_ptr
$00051A|long |If $5555AAAA, reset                                  |memval3
$00051E|long |8 Pointers to input-status routines                  |xconstat
$00053E|long |8 Pointers to input routines                         |xconin
$00055E|long |8 Pointers to output-status routines                 |xcostat
$00057E|long |8 Pointers to output routines                        |xconout
$00059E|word |If not 0, then not 68000 - use long stack frames     |_longframe
$0005A0|long |Pointer to cookie jar                                |_p_cookies
$0005A4|long |Pointer to end of FastRam                            |ramtop
$0005A8|long |Validates ramtop if $1357BD13                        |ramvalid
$0005AC|long |Pointer to routine for system bell                   |bell_hook
$0005B0|long |Pointer to routine for system keyclick               |kcl_hook
-------+-----+-----------------------------------------------------+----------

Address Size  Description                                 Bits used Read/Write
-------+-----+-----------------------------------------------------+----------
##############OS ROMs                                              ###########
-------+-----+-----------------------------------------------------+----------
$E00000|byte |TOS 512k ROMs                                        |R
   :   |  :  | :   :    :                                          |:
$EFFFFF|byte |TOS 512k ROMs                                        |R
-------+-----+-----------------------------------------------------+----------
##############ADSPEED Configuration registers                      ###########     
-------+-----+-----------------------------------------------------+----------
$F00000|byte |Switch to 16 Mhz                                     |W
$F10000|byte |Switch to 8 Mhz                                      |W
$F20000|byte |Turn on high speed ROM option in 16 Mhz              |W
$F30000|byte |Turn off high speed ROM option                       |W
$F40000|byte |Unknown                                              |W
$F50000|byte |Turn off cache while in 16 Mhz                       |W
       |     |       >> Write 0 to an address to set it. <<        |
-------+-----+-----------------------------------------------------+----------
##############IDE Controller (Falcon, ST-Book, IDE cards)          ###########
-------+-----+-----------------------------------------------------+----------
$F00000|long |Data Register                                        |R/W
$F00005|byte |Error Register                    BIT 7 6 5 4 3 2 1 0|R
       |     |Bad block mark -----------------------' | | | | | | ||
       |     |Uncorrectable error --------------------' | | | | | ||
       |     |Media change -----------------------------' | | | | ||
       |     |ID-Field not found -------------------------' | | | ||
       |     |Media change requested -----------------------' | | ||
       |     |Command aborted --------------------------------' | ||
       |     |Track 0 not found --------------------------------' ||
       |     |DAM not found --------------------------------------'|
$F00009|byte |Sector Count Register                                |W
$F0000D|byte |Sector Number Register                               |W
$F00011|byte |Cylinder Low Register                                |W
$F00015|byte |Cylinder High Register                               |W
$F00019|byte |Drive Head Register                                  |W
$F0001D|byte |Status Register                                      |R
$F0001D|byte |Command Register                                     |W
$F00039|byte |Alternate Status Register                            |R
$F00039|byte |Data Output Register                                 |W
-------+-----+-----------------------------------------------------+----------
##############ST MMU Controller                                    ###########
-------+-----+-----------------------------------------------------+----------
$FF8001|byte |MMU memory configuration                  BIT 3 2 1 0|R/W
       |     |Bank 0                                        | | | ||
       |     |00 - 128k ------------------------------------+-+ | ||
       |     |01 - 512k ------------------------------------+-+ | ||
       |     |10 - 2m --------------------------------------+-+ | ||
       |     |11 - reserved --------------------------------+-' | ||
       |     |Bank 1                                            | ||
       |     |00 - 128k ----------------------------------------+-+|
       |     |01 - 512k ----------------------------------------+-+|
       |     |10 - 2m ------------------------------------------+-+|
       |     |11 - reserved ------------------------------------+-'|
-------+-----+-----------------------------------------------------+----------
##############Falcon030 Processor Control                          ###########
-------+-----+-----------------------------------------------------+----------
$FF8007|byte |Falcon Bus Control                    BIT 5 . . 2 . 0|R/W (F030)
       |     |STe Bus Emulation (0 - on) ---------------'     |   ||
       |     |Blitter (0 - 8mhz, 1 - 16mhz) ------------------'   ||
       |     |68030 (0 - 8mhz, 1 - 16mhz) ------------------------'|
-------+-----+-----------------------------------------------------+----------
##############SHIFTER Video Controller                             ###########
-------+-----+-----------------------------------------------------+----------
$FF8201|byte |Video screen memory position (High byte)             |R/W
$FF8203|byte |Video screen memory position (Mid byte)              |R/W
$FF820D|byte |Video screen memory position (Low byte)              |R/W  (STe)
$FF8205|byte |Video address pointer (High byte)                    |R
$FF8207|byte |Video address pointer (Mid byte)                     |R
$FF8209|byte |Video address pointer (Low byte)                     |R
$FF820E|word |Offset to next line                                  |R/W (F030)
$FF820F|byte |Width of a scanline (width in words-1)               |R/W  (STe)
$FF8210|word |Width of a scanline (width in words)                 |R/W (F030)
$FF8265|byte |Horizontal scroll register (0-15)                    |R/W  (STe)
-------+-----+-----------------------------------------------------+----------
$FF820A|byte |Video synchronization mode                    BIT 1 0|R/W
       |     |0 - 60hz, 1 - 50hz -------------------------------+ ||
       |     |0 - internal, 1 - external sync ------------------' ||      (TT)
       |     |0 - internal, 1 - external sync --------------------'|     (!TT)
-------+-----+-----------------------------------------------------+----------
       |     |                                BIT 11111198 76543210|
       |     |                                    543210           |
       |     |                     ST color value .....RRr .GGr.BBb|
       |     |                    STe color value ....rRRR gGGGbBBB|
$FF8240|word |Video palette register 0              Lowercase = LSB|R/W
    :  |  :  |  :      :       :     :                             | :
$FF825E|word |Video palette register 15                            |R/W
-------+-----+-----------------------------------------------------+----------
$FF8260|byte |Shifter resolution                            BIT 1 0|R/W
       |     |00 320x200x4 bitplanes (16 colors) ---------------+-+|
       |     |01 640x200x2 bitplanes (4 colors) ----------------+-+|
       |     |10 640x400x1 bitplane  (1 colors) ----------------+-'|
$FF8262|word |TT Shifter resolution                   BIT 15 . . 12|R/W   (TT)
       |     |Sample/Hold mode ----------------------------'      ||
       |     |Hypermono mode -------------------------------------'|
       |     |Video Mode                                 BIT 10 9 8|
       |     |000  320x200x4 bitplanes (16 colors) -----------+-+-+|
       |     |001  640x200x2 bitplanes (4 colors) ------------+-+-+|
       |     |010  640x400x1 bitplane  (2 colors)(Duochrome) -+-+-+|
       |     |100  640x480x4 bitplanes (16 colors) -----------+-+-+|
       |     |110 1280x960x1 bitplane  (2 colors) ------------+-+-+|
       |     |111  320x480x8 bitplanes (256 colors) ----------+-+-'|
       |     |ST Palette Bank                           BIT 3 2 1 0|
-------+-----+-----------------------------------------------------+----------
$FF827E|???? |STACY Display Driver                                 |???(STACY)
-------+-----+-----------------------------------------------------+----------
       |     |                                BIT 11111198 76543210|
       |     |                                    543210           |
       |     |                     TT color value ....RRRr GGGgBBBb|
$FF8400|word |TT Palette  0                         Lowercase = LSB|R/W   (TT)
    :  |  :  | :    :     :                                        | :      :
$FF85FE|word |TT Palette 255                                       |R/W   (TT)
-------+-----+-----------------------------------------------------+----------
##############Falcon030 VIDEL Video Controller                     ###########
-------+-----+-----------------------------------------------------+----------
$FF8006|byte |Monitor Type                                  BIT 1 0|R   (F030)
       |     |00 - Monochrome (SM124) --------------------------+-+|
       |     |01 - Color (SC1224) ------------------------------+-+|
       |     |10 - VGA Color -----------------------------------+-+|
       |     |11 - Television ----------------------------------+-'|
$FF820E|word |Offset to next line                                  |R/W (F030)
$FF8210|word |VWRAP - Linewidth in words                           |R/W (F030)
$FF8266|word |SPSHIFT                    BIT 10 . 8 . 6 5 4 3 2 1 0|R/W (F030)
       |     |2-colour mode ------------------'   |   | | | | | | ||
       |     |Truecolour mode --------------------'   | | | | | | ||
       |     |Use external hsync ---------------------' | | | | | ||
       |     |Use external vsync -----------------------' | | | | ||
       |     |8 Bitplane mode ----------------------------' | | | ||
       |     |? Bitplane mode ------------------------------' | | ||
       |     |? Bitplane mode --------------------------------' | ||
       |     |? Bitplane mode ----------------------------------' ||
       |     |? Bitplane mode ------------------------------------'|
       |     +-----------------------------------------------------+
       |     |      Horizontal Control Registers             (9bit)|
$FF8280|word |HHC - Horizontal Hold Counter                        |R   (F030)
$FF8282|word |HHT - Horizontal Hold Timer                          |R/W (F030)
$FF8284|word |HBB - Horizontal Border Begin                        |R/W (F030)
$FF8286|word |HBE - Horizontal Border End                          |R/W (F030)
$FF8288|word |HDB - Horizontal Display Begin                       |R/W (F030)
$FF828A|word |HDE - Horizontal Display End                         |R/W (F030)
$FF828C|word |HSS - Horizontal SS                                  |R/W (F030)
$FF828E|word |HFS - Horizontal FS                                  |R/W (F030)
$FF8290|word |HEE - Horizontal EE                                  |R/W (F030)
       |     +-----------------------------------------------------+
       |     |      Vertical Control Registers              (10bit)|
$FF82A0|word |VFC - Vertcial Frequency Counter                     |R   (F030)
$FF82A2|word |VFT - Vertical Frequency Timer                       |R/W (F030)
$FF82A4|word |VBB - Vertical Border Begin      (count in 1/2 lines)|R/W (F030)
$FF82A6|word |VBE - Vertical Border End        (count in 1/2 lines)|R/W (F030)
$FF82A8|word |VDB - Vertical Display Begin                         |R/W (F030)
$FF82AA|word |VDE - Vertical Display End                           |R/W (F030)
$FF82AC|word |VSS - Vertical SS                                    |R/W (F030)
       |     +-----------------------------------------------------+
$FF82C0|word |??? - Video Clock (?) (Super78 puts $182 here)       |R/W (F030)
$FF82C2|word |VCO - Video Control                       BIT 3 2 1 0|R/W (F030)
       |     |Quarter pixel width (quadruple pixels) -------' | | ||
       |     |Half pixel width (double pixels) ---------------' | ||
       |     |Skip line (interlace) ----------------------------' ||
       |     |Line doubling --------------------------------------'|
-------+-----+-----------------------------------------------------+----------
##############DMA/WD1772 Disk controller                           ###########
-------+-----+-----------------------------------------------------+----------
$FF8600|     |Reserved                                             |
$FF8602|     |Reserved                                             |
$FF8604|word |FDC access/sector count                              |R/W
$FF8606|word |DMA mode/status                             BIT 2 1 0|R
       |     |Condition of FDC DATA REQUEST signal -----------' | ||
       |     |0 - sector count null,1 - not null ---------------' ||
       |     |0 - no error, 1 - DMA error ------------------------'|
$FF8606|word |DMA mode/status                 BIT 8 7 6 . 4 3 2 1 .|W
       |     |0 - read FDC/HDC,1 - write ---------' | | | | | | |  |
       |     |0 - HDC access,1 - FDC access --------' | | | | | |  |
       |     |0 - DMA on,1 - no DMA ------------------' | | | | |  |
       |     |Reserved ---------------------------------' | | | |  |
       |     |0 - FDC reg,1 - sector count reg -----------' | | |  |
       |     |0 - FDC access,1 - HDC access ----------------' | |  |
       |     |0 - pin A1 low, 1 - pin A1 high ----------------' |  |
       |     |0 - pin A0 low, 1 - pin A0 high ------------------'  |
$FF8609|byte |DMA base and counter (High byte)                     |R/W
$FF860B|byte |DMA base and counter (Mid byte)                      |R/W
$FF860D|byte |DMA base and counter (Low byte)                      |R/W
-------+-----+-----------------------------------------------------+----------
##############TT-SCSI DMA Controller                               ###########
-------+-----+-----------------------------------------------------+----------
$FF8701|byte |DMA Address Pointer (Highest byte)                   |R/W   (TT)
$FF8703|byte |DMA Address Pointer (High byte)                      |R/W   (TT)
$FF8705|byte |DMA Address Pointer (Low byte)                       |R/W   (TT)
$FF8707|byte |DMA Address Pointer (Lowest byte)                    |R/W   (TT)
$FF8709|byte |DMA Byte Count (Highest byte)                        |R/W   (TT)
$FF870B|byte |DMA Byte Count (High byte)                           |R/W   (TT)
$FF870D|byte |DMA Byte Count (Low byte)                            |R/W   (TT)
$FF870F|byte |DMA Byte Count (Lowest byte)                         |R/W   (TT)
$FF8710|word |Residue Data Register (High Word)                    |R     (TT)
$FF8712|word |Residue Data Register (Low Word)                     |R     (TT)
$FF8715|byte |Control register                  BIT 7 6 . . . . 1 0|R/W   (TT)
       |     |Bus error ----------------------------' |         | ||
       |     |Byte count zero ------------------------'         | ||
       |     |Enable -------------------------------------------' ||
       |     |DMA Direction (1 - out to port) --------------------'|
-------+-----+-----------------------------------------------------+----------
##############TT-SCSI Drive Controller NCR 5380                    ###########
-------+-----+-----------------------------------------------------+----------
$FF8781|byte |Data register                                        |R/W   (TT)
$FF8783|byte |Init-Command Register                                |R/W   (TT)
$FF8785|byte |Mode Register                                        |R/W   (TT)
$FF8787|byte |Target-Command Register                              |R/W   (TT)
$FF8789|byte |ID Select/SCSI Control Register                      |R/W   (TT)
$FF878B|byte |Status Register                                      |R/W   (TT)
$FF878D|byte |Target Receive/Input Data                            |R/W   (TT)
$FF878F|byte |Initiate Receive/Reset                               |R/W   (TT)
-------+-----+-----------------------------------------------------+----------
##############YM2149 Sound Chip                                    ###########
-------+-----+-----------------------------------------------------+----------
$FF8800|byte |Read data/Register select                            |R/W
       |     |0 Channel A Freq Low              BIT 7 6 5 4 3 2 1 0|
       |     |1 Channel A Freq High                     BIT 3 2 1 0|
       |     |2 Channel B Freq Low              BIT 7 6 5 4 3 2 1 0|
       |     |3 Channel B Freq High                     BIT 3 2 1 0|
       |     |4 Channel C Freq Low              BIT 7 6 5 4 3 2 1 0|
       |     |5 Channel C Freq High                     BIT 3 2 1 0|
       |     |6 Noise Freq                          BIT 5 4 3 2 1 0|
       |     |7 Mixer Control                   BIT 7 6 5 4 3 2 1 0|
       |     |  Port B IN/OUT (1=Output) -----------' | | | | | | ||
       |     |  Port A IN/OUT ------------------------' | | | | | ||
       |     |  Channel C Noise (1=Off) ----------------' | | | | ||
       |     |  Channel B Noise --------------------------' | | | ||
       |     |  Channel A Noise ----------------------------' | | ||
       |     |  Channel C Tone (0=On) ------------------------' | ||
       |     |  Channel B Tone ---------------------------------' ||
       |     |  Channel A Tone -----------------------------------'|
       |     |8 Channel A Amplitude Control           BIT 4 3 2 1 0|
       |     |  Fixed/Variable Level (0=Fixed) -----------' | | | ||
       |     |  Amplitude level control --------------------+-+-+-'|
       |     |9 Channel B Amplitude Control           BIT 4 3 2 1 0|
       |     |  Fixed/Variable Level ---------------------' | | | ||
       |     |  Amplitude level control --------------------+-+-+-'|
       |     |10 Channel C Amplitude Control          BIT 4 3 2 1 0|
       |     |  Fixed/Variable Level ---------------------' | | | ||
       |     |  Amplitude level control --------------------+-+-+-'|
       |     |11 Envelope Period High           BIT 7 6 5 4 3 2 1 0|
       |     |12 Envelope Period Low            BIT 7 6 5 4 3 2 1 0|
       |     |13 Envelope Shape                         BIT 3 2 1 0|
       |     |  Continue -----------------------------------' | | ||
       |     |  Attack ---------------------------------------' | ||
       |     |  Alternate --------------------------------------' ||
       |     |  Hold ---------------------------------------------'|
       |     |   00xx - \____________________________________      |
       |     |   01xx - /|___________________________________      |
       |     |   1000 - \|\|\|\|\|\|\|\|\|\|\|\|\|\|\|\|\|\|\      |
       |     |   1001 - \____________________________________      |
       |     |   1010 - \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\      |
       |     |   1011 - \|-----------------------------------      |
       |     |   1100 - /|/|/|/|/|/|/|/|/|/|/|/|/|/|/|/|/|/|/      |
       |     |   1101 - /------------------------------------      |
       |     |   1110 - /\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/      |
       |     |   1111 - /|___________________________________      |
       |     |14 Port A                         BIT 7 6 5 4 3 2 1 0|
       |     |  IDE Drive On/OFF -------------------+ | | | | | | ||    (F030)
       |     |  SCC A (0=LAN, 1=Serial2) -----------' | | | | | | ||      (TT)
       |     |  Monitor jack GPO pin -----------------+ | | | | | ||
       |     |  Internal Speaker On/Off --------------' | | | | | ||    (F030)
       |     |  Centronics strobe ----------------------' | | | | ||
       |     |  RS-232 DTR output ------------------------' | | | ||
       |     |  RS-232 RTS output --------------------------' | | ||
       |     |  Drive select 1 -------------------------------' | ||
       |     |  Drive select 0 ---------------------------------' ||
       |     |  Drive side select --------------------------------'|
       |     |15 Port B (Parallel port)                            |
$FF8802|byte |Write data                                           |W
       |     +-----------------------------------------------------+
       |     |Note: PSG Registers are now fixed at these addresses.|
       |     |All other addresses are masked out on the Falcon. Any|
       |     |writes to the shadow registers $8804-$88FF will cause|
       |     |bus errors. Game/Demo coders beware!                 |
-------+-----+-----------------------------------------------------+----------
##############DMA Sound System                                     ###########
-------+-----+-----------------------------------------------------+----------
$FF8900|byte |Buffer interrupts                         BIT 3 2 1 0|R/W (F030)
       |     |TimerA-Int at end of record buffer -----------' | | ||
       |     |TimerA-Int at end of replay buffer -------------' | ||
       |     |MFP-15-Int (I7) at end of record buffer ----------' ||
       |     |MFP-15-Int (I7) at end of replay buffer ------------'|
-------+-----+-----------------------------------------------------+----------
$FF8901|byte |DMA Control Register              BIT 7 . 5 4 . . 1 0|R/W
       |     |1 - select record register -----------+   | |     | ||    (F030) 
       |     |0 - select replay register -----------'   | |     | ||    (F030)
       |     |Loop record buffer -----------------------' |     | ||    (F030)
       |     |DMA Record on ------------------------------'     | ||    (F030)
       |     |Loop replay buffer -------------------------------' ||     (STe)
       |     |DMA Replay on --------------------------------------'|     (STe)
-------+-----+-----------------------------------------------------+----------
$FF8903|byte |Frame start address (high byte)                      |R/W  (STe)
$FF8905|byte |Frame start address (mid byte)                       |R/W  (STe)
$FF8907|byte |Frame start address (low byte)                       |R/W  (STe)
$FF8909|byte |Frame address counter (high byte)                    |R    (STe)
$FF890B|byte |Frame address counter (mid byte)                     |R    (STe)
$FF890D|byte |Frame address counter (low byte)                     |R    (STe)
$FF890F|byte |Frame end address (high byte)                        |R/W  (STe)
$FF8911|byte |Frame end address (mid byte)                         |R/W  (STe)
$FF8913|byte |Frame end address (low byte)                         |R/W  (STe)
-------+-----+-----------------------------------------------------+----------
$FF8920|byte |DMA Track Control                     BIT 5 4 . . 1 0|R/W (F030)
       |     |00 - Set DAC to Track 0 ------------------+-+     | ||
       |     |01 - Set DAC to Track 1 ------------------+-+     | ||
       |     |10 - Set DAC to Track 2 ------------------+-+     | ||
       |     |11 - Set DAC to Track 3 ------------------+-'     | ||
       |     |00 - Play 1 Track --------------------------------+-+|
       |     |01 - Play 2 Tracks -------------------------------+-+|
       |     |10 - Play 3 Tracks -------------------------------+-+|
       |     |11 - Play 4 Tracks -------------------------------+-'|
-------+-----+-----------------------------------------------------+----------
$FF8921|byte |Sound mode control                BIT 7 6 . . . . 1 0|R/W  (STe)
       |     |0 - Stereo, 1 - Mono -----------------' |         | ||
       |     |0 - 8bit -------------------------------+         | ||
       |     |1 - 16bit (F030 only) ------------------'         | ||    (F030)
       |     |Frequency control bits                            | ||
       |     |00 - Off (F030 only) -----------------------------+-+|    (F030)
       |     |00 - 6258hz frequency (STe only) -----------------+-+|
       |     |01 - 12517hz frequency ---------------------------+-+|
       |     |10 - 25033hz frequency ---------------------------+-+|
       |     |11 - 50066hz frequency ---------------------------+-'|
       |     |Samples are always signed. In stereo mode, data is   |
       |     |arranged in pairs with high pair the left channel,low|
       |     |pair right channel. Sample length MUST be even in    |
       |     |either mono or stereo mode.                          |
       |     |Example: 8 bit Stereo : LRLRLRLRLRLRLRLR             |
       |     |        16 bit Stereo : LLRRLLRRLLRRLLRR (F030)      |
       |     |2 track 16 bit stereo : LLRRllrrLLRRllrr (F030)      |
-------+-----+-----------------------------------------------------+----------
##############STe Microwire Controller (STe/TT only!)              ###########
-------+-----+-----------------------------------------------------+----------
$FF8922|byte |Microwire data register                              |R/W  (Mwr)
$FF8924|byte |Microwire mask register                              |R/W  (Mwr)
       |     +-----------------------------------------------------+
       |     |!! ATTENTION !! Microwire is now obsolete! It is not |
       |     |present in the Falcon030 and is unlikely to be in any|
       |     |future machines. You have been warned.               | 
       |     +-----------------------------------------------------+
       |     |Volume/tone controller commands         (Address %10)|
       |     |Master Volume                           10 011 DDDDDD|
       |     |Left Volume                             10 101 .DDDDD|
       |     |Right Volume                            10 100 .DDDDD|
       |     |Treble                                  10 010 ..DDDD|
       |     |Bass                                    10 001 ..DDDD|
       |     |Mixer                                   10 000 ....DD|
       |     +-----------------------------------------------------+
       |     |Volume/tone controller values                        |
       |     |Master Volume     : 0-40   (0 -80dB, 40=0dB)         |
       |     |Left/Right Volume : 0-20    (0 80dB, 20=0dB)         |
       |     |Treble/bass       : 0-12 (0 -12dB, 12 +12dB)         |
       |     |Mixer             : 0-3 (0 -12dB, 1 mix PSG)         |
       |     |                    (2 don't mix,3 reserved)         |
       |     +-----------------------------------------------------+
       |     |Procedure: Set mask register to $7ff. Read data      |
       |     |register and save original value.Write data register.|
       |     |Compare data register with original value, repeat    |
       |     |until data register returns to original value to     |
       |     |ensure data has been sent over the interface.        |
       |     +-----------------------------------------------------+
       |     |Interrupts: Timer A can be set to interrupt at the   |
       |     |end of a frame. Alternatively, the GPI7 (MFP mono    |
       |     |detect) can be used to generate interrupts thereby   |
       |     |freeing up Timer A. In this case, the active edge    |
       |     |$FFFA03 must be set by or-ing the active edge of     |
       |     |$FFFA03 with the contents of $FF8260:                |
       |     |$FF8260 - 2 (mono)     or.b  #$80 with edge          |
       |     |$FF8260 - 0,1 (colour) and.b #$7F with edge          |
       |     |This will generate an interrupt at the START of a    |
       |     |frame, instead of at the end as with Timer A. To     |
       |     |generate an interrupt at the END of a frame, simply  |
       |     |reverse the edge values.                             |
-------+-----+-----------------------------------------------------+----------
##############Falcon030 DMA/DSP Controllers                        ###########
-------+-----+-----------------------------------------------------+----------
$FF8930|word |Crossbar Source Controller                           |R/W (F030)
       |     +-----------------------------------------------------+
       |     |Source: A/D Convertor                 BIT 15 14 13 12|
       |     |1 - Connect, 0 - disconnect ---------------'  |  |  ||
       |     |00 - 25.175Mhz clock -------------------------+--+  ||
       |     |01 - External clock --------------------------+--+  ||
       |     |10 - 32Mhz clock (Don't use) -----------------+--'  ||
       |     |0 - Handshake on, 1 - Handshake off ----------------'|
       |     +-----------------------------------------------------+
       |     |Source: External Input                BIT 11 10  9  8|
       |     |0 - DSP IN, 1 - All others ----------------'  |  |  ||
       |     |00 - 25.175Mhz clock -------------------------+--+  ||
       |     |01 - External clock --------------------------+--+  ||
       |     |10 - 32Mhz clock -----------------------------+--'  ||
       |     |0 - Handshake on, 1 - Handshake off ----------------'|
       |     +-----------------------------------------------------+
       |     |Source: DSP-XMIT                      BIT  7  6  5  4|
       |     |0 - Tristate and disconnect DSP -----------+  |  |  ||
       |     |    (Only for external SSI use)            |  |  |  ||
       |     |1 - Connect DSP to multiplexer ------------'  |  |  ||
       |     |00 - 25.175Mhz clock -------------------------+--+  ||
       |     |01 - External clock --------------------------+--+  ||
       |     |10 - 32Mhz clock -----------------------------+--'  ||
       |     |0 - Handshake on, 1 - Handshake off ----------------'|
       |     +-----------------------------------------------------+
       |     |Source: DMA-PLAYBACK                  BIT  3  2  1  0|
       |     |0 - Handshaking on, dest DSP-REC ----------+  |  |  ||
       |     |1 - Destination is not DSP-REC ------------'  |  |  ||
       |     |00 - 25.175Mhz clock -------------------------+--+  ||
       |     |01 - External clock --------------------------+--+  ||
       |     |10 - 32Mhz clock -----------------------------+--'  ||
       |     |0 - Handshake on, 1 - Handshake off ----------------'|
-------+-----+-----------------------------------------------------+----------
$FF8932|word |Crossbar Destination Controller                      |R/W (F030)
       |     +-----------------------------------------------------+
       |     |Destination: D/A Convertor            BIT 15 14 13 12|
       |     |1 - Connect, 0 - Disconnect ---------------'  |  |  ||
       |     |00 - Source DMA-PLAYBACK ---------------------+--+  ||
       |     |01 - Source DSP-XMIT -------------------------+--+  ||
       |     |10 - Source External Input -------------------+--+  ||
       |     |11 - Source A/D Convertor --------------------+--'  ||
       |     |0 - Handshake on, 1 - Handshake off ----------------'|
       |     +-----------------------------------------------------+
       |     |Destination: External Output          BIT 11 10  9  8|
       |     |0 - DSP out, 1 - All others ---------------'  |  |  ||
       |     |00 - Source DMA-PLAYBACK ---------------------+--+  ||
       |     |01 - Source DSP-XMIT -------------------------+--+  ||
       |     |10 - Source External Input -------------------+--+  ||
       |     |11 - Source A/D Convertor --------------------+--'  ||
       |     |0 - Handshake on, 1 - Handshake off ----------------'|
       |     +-----------------------------------------------------+
       |     |Destination: DSP-RECORD               BIT  7  6  5  4|
       |     |0 - Tristate and disconnect DSP -----------+  |  |  ||
       |     |    (Only for external SSI use)            |  |  |  ||
       |     |1 - Connect DSP to multiplexer ------------'  |  |  ||
       |     |00 - Source DMA-PLAYBACK ---------------------+--+  ||
       |     |01 - Source DSP-XMIT -------------------------+--+  ||
       |     |10 - Source External Input -------------------+--+  ||
       |     |11 - Source A/D Convertor --------------------+--'  ||
       |     |0 - Handshake on, 1 - Handshake off ----------------'|
       |     +-----------------------------------------------------+
       |     |Destination: DMA-RECORD               BIT  3  2  1  0|
       |     |0 - Handshaking on, src DSP-XMIT ----------+  |  |  ||
       |     |1 - Source is not DSP-XMIT ----------------'  |  |  ||
       |     |00 - Source DMA-PLAYBACK ---------------------+--+  ||
       |     |01 - Source DSP-XMIT -------------------------+--+  ||
       |     |10 - Source External Input -------------------+--+  ||
       |     |11 - Source A/D Convertor --------------------+--'  ||
       |     |0 - Handshake on, 1 - Handshake off ----------------'|
-------+-----+-----------------------------------------------------+----------
$FF8934|byte |Frequency Divider External Clock          BIT 3 2 1 0|R/W (F030)
       |     |0000 - STe-Compatible mode                           |
       |     |0001 - 1111  Divide by 256 and then number           |
-------+-----+-----------------------------------------------------+----------
$FF8935|byte |Frequency Divider Internal Sync           BIT 3 2 1 0|R/W (F030)
       |     |0000 - STe-Compatible mode   1000 - 10927Hz*         |
       |     |0001 - 49170Hz               1001 -  9834Hz          |
       |     |0010 - 32780Hz               1010 -  8940Hz*         |
       |     |0011 - 24585Hz               1011 -  8195Hz          |
       |     |0100 - 19668Hz               1100 -  7565Hz*         |
       |     |0101 - 16390Hz               1101 -  7024Hz*         |
       |     |0110 - 14049Hz*              1110 -  6556Hz*         |
       |     |0111 - 12292Hz               1111 -  6146Hz*         |
       |     |               * - Invalid for CODEC                 |
-------+-----+-----------------------------------------------------+----------
$FF8936|byte |Record Tracks Select                          BIT 1 0|R/W (F030)
       |     |00 - Record 1 Track ------------------------------+-+|
       |     |01 - Record 2 Tracks -----------------------------+-+|
       |     |10 - Record 3 Tracks -----------------------------+-+|
       |     |11 - Record 4 Tracks -----------------------------+-'|
-------+-----+-----------------------------------------------------+----------
$FF8937|byte |CODEC Input Source from 16bit adder           BIT 1 0|R/W (F030)
       |     |Source: Multiplexer ------------------------------' ||
       |     |Source: A/D Convertor ------------------------------'|
-------+-----+-----------------------------------------------------+----------
$FF8938|byte |CODEC ADC-Input for L+R Channel               BIT 1 0|R/W (F030)
       |     |0 - Microphone, 1 - Soundchip                     L R|
-------+-----+-----------------------------------------------------+----------
$FF8939|byte |Channel amplification                   BIT LLLL RRRR|R/W (F030)
       |     |          Amplification is in +1.5dB steps           |
-------+-----+-----------------------------------------------------+----------
$FF893A|word |Channel attenuation                     BIT LLLL RRRR|R/W (F030)
       |     |           Attenuation is in -1.5dB steps            |
-------+-----+-----------------------------------------------------+----------
$FF893C|byte |CODEC-Status                                  BIT 1 0|R/W (F030)
       |     |Left Channel Overflow ----------------------------' ||
       |     |Right Channel Overflow -----------------------------'|
-------+-----+-----------------------------------------------------+----------
$FF8941|byte |GPx Data Direction                          BIT 2 1 0|R/W (F030)
       |     |0 - In, 1 - Out --------------------------------+-+-'|
       |     | For the GP0-GP2 pins on the DSP connector           |
-------+-----+-----------------------------------------------------+----------
$FF8943|byte |GPx Data Port                               BIT 2 1 0|R/W (F030)
-------+-----+-----------------------------------------------------+----------
##############TT Clock Chip (MC146818A @ 32.768 khz)               ###########
-------+-----+-----------------------------------------------------+----------
$FF8961|byte |Register select                                      |W     (TT)
       |     |0 - Current Second                                   |
       |     |1 - Second for alarm                                 |
       |     |2 - Current Minute                                   |
       |     |3 - Minute for alarm                                 |
       |     |4 - Current Hour                                     |
       |     |5 - Hour for alarm                                   |
       |     |6 - Day of week (1=Sunday, 2=Monday, 3=...)          |
       |     |7 - Day of Month                                     |
       |     |8 - Month                                            |
       |     |9 - Year (example : '93' for this year)              |
       |     |A                                               BIT 7|
       |     |    If set, update time in progress ----------------'|
       |     |    don't read time & date registers                 |
       |     |B                                 BIT 7 6 5 4 3 2 1 0|
       |     |1 = Write Protect time & date --------'   | |   | | ||
       |     |1 = Enable alarm interrupt ---------------' |   | | ||
       |     |1 = Interrupt after time updated -----------'   | | ||
       |     |1 = Format Binary, 0 = Format BCD --------------' | ||
       |     |1 = 24hr format, 0 = 12hr format -----------------' ||
       |     |1 = Summer hours, 0 = Winter hours -----------------'|
       |     |C                                           BIT 6 5 4|
       |     | ??? -------------------------------------------' | ||
       |     |1 = alarm is ringing -----------------------------' ||
       |     |1 = date is updated --------------------------------'|
       |     |On interrupt, read this register to determine source.|
       |     |D                                               BIT 7|
       |     |1 = Battery dead -----------------------------------'|
$FF8963|byte |Register data                                        |R/W   (TT)
-------+-----+-----------------------------------------------------+----------
##############Blitter (Not present on TT!)                         ###########
-------+-----+-----------------------------------------------------+----------
$FF8A00|word |Halftone-RAM, Word 0                                 |R/W (Blit)
    :  |  :  |    :     :     :  :                                 | :     :
$FF8A1E|word |Halftone-RAM, Word 15                                |R/W (Blit)
$FF8A20|word |Source X Increment                      (signed,even)|R/W (Blit)
$FF8A22|word |Source Y Increment                      (signed,even)|R/W (Blit)
$FF8A24|long |Source Address Register                 (24 bit,even)|R/W (Blit)
$FF8A28|word |Endmask 1                     (First write of a line)|R/W (Blit)
$FF8A2A|word |Endmask 2                     (All other line writes)|R/W (Blit)
$FF8A2C|word |Endmask 3                      (Last write of a line)|R/W (Blit)
$FF8A2E|word |Destination X Increment                 (signed,even)|R/W (Blit)
$FF8A30|word |Destination Y Increment                 (signed,even)|R/W (Blit)
$FF8A32|long |Destination Address Register            (24 bit,even)|R/W (Blit)
$FF8A36|word |Words per Line in Bit-Block                 (0=65536)|R/W (Blit)
$FF8A38|word |Lines per Bit-Block                         (0=65536)|R/W (Blit)
$FF8A3A|byte |Halftone Operation Register                   BIT 1 0|R/W (Blit)
       |     |00 - All ones ------------------------------------+-+|
       |     |01 - Halftone ------------------------------------+-+|
       |     |10 - Source --------------------------------------+-+|
       |     |11 - Source AND Halftone -------------------------+-'|
$FF8A3B|byte |Logical Operation Register                BIT 3 2 1 0|R/W (Blit)
       |     |0000 All zeros -------------------------------+-+-+-+|
       |     |0001 Source AND destination ------------------+-+-+-+|
       |     |0010 Source AND NOT destination --------------+-+-+-+|
       |     |0011 Source ----------------------------------+-+-+-+|
       |     |0100 NOT source AND destination --------------+-+-+-+|
       |     |0101 Destination -----------------------------+-+-+-+|
       |     |0110 Source XOR destination ------------------+-+-+-+|
       |     |0111 Source OR destination -------------------+-+-+-+|
       |     |1000 NOT source AND NOT destination ----------+-+-+-+|
       |     |1001 NOT source XOR destination --------------+-+-+-+|
       |     |1010 NOT destination -------------------------+-+-+-+|
       |     |1011 Source OR NOT destination ---------------+-+-+-+|
       |     |1100 NOT source ------------------------------+-+-+-+|
       |     |1101 NOT source OR destination ---------------+-+-+-+|
       |     |1110 NOT source OR NOT destination -----------+-+-+-+|
       |     |1111 All ones --------------------------------+-+-+-'|
$FF8A3C|byte |Line Number Register              BIT 7 6 5 . 3 2 1 0|R/W (Blit)
       |     |BUSY ---------------------------------' | |   | | | ||
       |     |0 - Share bus, 1 - Hog bus -------------' |   | | | ||
       |     |SMUDGE mode ------------------------------'   | | | ||
       |     |Halftone line number -------------------------+-+-+-'|
$FF8A3D|byte |SKEW Register                     BIT 7 6 . . 3 2 1 0|R/W (Blit)
       |     |Force eXtra Source Read --------------' |     | | | ||
       |     |No Final Source Read -------------------'     | | | ||
       |     |Source skew ----------------------------------+-+-+-'|
-------+-----+-----------------------------------------------------+----------
##############SCC-DMA (TT Only!)                                   ###########
-------+-----+-----------------------------------------------------+----------
$FF8C01|byte |DMA Address Pointer (Highest Byte)                   |R/W   (TT)
$FF8C03|byte |DMA Address Pointer (High Byte)                      |R/W   (TT)
$FF8C05|byte |DMA Address Pointer (Low Byte)                       |R/W   (TT)
$FF8C07|byte |DMA Address Pointer (Lowest Byte)                    |R/W   (TT)
$FF8C09|byte |DMA Byte Count (Highest-Byte)                        |R/W   (TT)
$FF8C0B|byte |DMA Byte Count (High-Byte)                           |R/W   (TT)
$FF8C0D|byte |DMA Byte Count (Low-Byte)                            |R/W   (TT)
$FF8C0F|byte |DMA Byte Count (Lowest-Byte)                         |R/W   (TT)
$FF8C10|word |Residue Data Register (High-Word)                    |R     (TT)
$FF8C12|word |Residue Data register (Low-Word)                     |R     (TT)
$FF8C15|byte |Control register                  BIT 7 6 . . . . 1 0|R/W   (TT)
       |     |Bus error ----------------------------' |         | ||
       |     |Byte count zero ------------------------'         | ||
       |     |Enable -------------------------------------------' ||
       |     |DMA Direction (1 - out to port) --------------------'|
-------+-----+-----------------------------------------------------+----------
##############Zilog 8530 SCC (MSTe/TT/F030)                        ###########
-------+-----+-----------------------------------------------------+----------
$FF8C81|byte |Channel A - Control Register                         |R/W  (SCC)
$FF8C83|byte |Channel A - Data Register                            |R/W  (SCC)
$FF8C85|byte |Channel B - Control Register                         |R/W  (SCC)
$FF8C87|byte |Channel B - Data Register                            |R/W  (SCC)
-------+-----+-----------------------------------------------------+----------
##############VME Bus System Control Unit (MSTe/TT)                ###########
-------+-----+-----------------------------------------------------+----------
$FF8E01|byte |VME sys_mask                      BIT 7 6 5 4 . 2 1 .|R/W  (VME)
$FF8E03|byte |VME sys_stat                      BIT 7 6 5 4 . 2 1 .|R    (VME)
       |     |_SYSFAIL in VMEBUS -------------------' | | |   | |  |program
       |     |MFP ------------------------------------' | |   | |  |autovec
       |     |SCC --------------------------------------' |   | |  |autovec
       |     |VSYNC --------------------------------------'   | |  |program
       |     |HSYNC ------------------------------------------' |  |program
       |     |System software INT ------------------------------'  |program
       |     +-----------------------------------------------------+
       |     |Reading sys_mask resets pending int-bits in sys_stat,|
       |     |so read sys_stat first.                              |
-------+-----+-----------------------------------------------------+----------
$FF8E05|byte |VME sys_int                                     BIT 0|R/W  (VME)
       |     |Setting bit 0 to 1 forces an INT of level 1. INT must|Vector $64
       |     |be enabled in sys_mask to use it.                    |
-------+-----+-----------------------------------------------------+----------
$FF8E0D|byte |VME vme_mask                      BIT 7 6 5 4 3 2 1 .|R/W  (VME)
$FF8E0F|byte |VME vme_stat                      BIT 7 6 5 4 3 2 1 .|R    (VME)
       |     |_IRQ7 from VMEBUS --------------------' | | | | | |  |program
       |     |_IRQ6 from VMEBUS/MFP ------------------' | | | | |  |program
       |     |_IRQ5 from VMEBUS/SCC --------------------' | | | |  |program
       |     |_IRQ4 from VMEBUS --------------------------' | | |  |program
       |     |_IRQ3 from VMEBUS/soft -----------------------' | |  |prog/autov
       |     |_IRQ2 from VMEBUS ------------------------------' |  |program
       |     |_IRQ1 from VMEBUS --------------------------------'  |program
       |     +-----------------------------------------------------+
       |     |MFP-int and SCC-int are hardwired to the VME-BUS-ints|
       |     |(or'ed). Reading vme_mask resets pending int-bits in |
       |     |vme_stat, so read vme_stat first.                    |
-------+-----+-----------------------------------------------------+----------
$FF8E07|byte |VME vme_int                                     BIT 0|R/W   (TT)
       |     |Setting bit 0 to 1 forces an INT of level 3. INT must|Vector $6C
       |     |be enabled in vme_mask to use it.                    |
-------+-----+-----------------------------------------------------+----------
$FF8E09|byte |General purpose register - does nothing              |R/W   (TT)
$FF8E0B|byte |General purpose register - does nothing              |R/W   (TT)
-------+-----+-----------------------------------------------------+----------
##############Mega STe Cache/Processor Control                     ###########
-------+-----+-----------------------------------------------------+----------
$FF8E21|byte |Mega STe Cache/Processor Control           BIT 15-1 0|R/W (MSTe)
       |     |Cache enable lines (set all to 1 to enable) -----'  ||
       |     |CPU Speed (0 - 8mhz, 1 - 16mhz) --------------------'|
-------+-----+-----------------------------------------------------+----------
##############STe/F030 Extended Joystick/Lightpen Ports            ###########
-------+-----+-----------------------------------------------------+----------
$FF9200|word |Fire buttons 1-4                          Bit 3 2 1 0|R    (Ext)
       |     |Pause/F0 -------------------------------------' | | ||
       |     |F1 ---------------------------------------------' | ||
       |     |F2 -----------------------------------------------' ||
       |     |Option/F3 ------------------------------------------'|
$FF9202|word |Read Mask (0 - pin read)                             |W    (Ext)
$FF9202|word |Joystick Inputs                   BIT 7 6 5 4 3 2 1 0|R    (Ext)
       |     |Controller 1 pin 4 -------------------' | | | | | | ||
       |     |Controller 1 pin 3 ---------------------' | | | | | ||
       |     |Controller 1 pin 2 -----------------------' | | | | ||
       |     |Controller 1 pin 1 -------------------------' | | | ||
       |     |Controller 0 pin 4 ---------------------------' | | ||
       |     |Controller 0 pin 3/Paddle 1 Trigger ------------' | ||
       |     |Controller 0 pin 2/Paddle 0 Trigger --------------' ||
       |     |Controller 0 pin 1 ---------------------------------'|
       |     |                            BIT 15 14 13 12 11 10 9 8|
       |     |Controller 1 pin 14 ------------'   |  |  |  |  | | ||
       |     |Controller 1 pin 13 ----------------'  |  |  |  | | ||
       |     |Controller 1 pin 12 -------------------'  |  |  | | ||
       |     |Controller 1 pin 11 ----------------------'  |  | | ||
       |     |Controller 0 pin 14 -------------------------'  | | ||
       |     |Controller 0 pin 13 ----------------------------' | ||
       |     |Controller 0 pin 12 ------------------------------' ||
       |     |Controller 0 pin 11 --------------------------------'|
$FF9210|word |X Paddle 0 Position               BIT 7 6 5 4 3 2 1 0|R    (Ext)
$FF9212|word |Y Paddle 0 Position               BIT 7 6 5 4 3 2 1 0|R    (Ext)
$FF9214|word |X Paddle 1 Position               BIT 7 6 5 4 3 2 1 0|R    (Ext)
$FF9216|word |Y Paddle 1 Position               BIT 7 6 5 4 3 2 1 0|R    (Ext)
$FF9220|word |Lightpen X-Position           BIT 9 8 7 6 5 4 3 2 1 0|R    (Ext)
$FF9222|word |Lightpen Y-Position           BIT 9 8 7 6 5 4 3 2 1 0|R    (Ext)
-------+-----+-----------------------------------------------------+----------
##############Falcon VIDEL Palette Registers                       ###########
-------+-----+-----------------------------------------------------+----------
       |     |              BIT 33222222 22221111 11111198 76543210|
       |     |                  10987654 32109876 543210           |
       |     |                  RRRRRr.. GGGGGg.. ........ BBBBBb..|
$FF9800|long |Palette Register  0                   Lowercase = LSB|R/W (F030)
   :   |  :  |   :        :     :                                  | :     :
$FF98FC|long |Palette Register 255                                 |R/W (F030)
-------+-----+-----------------------------------------------------+----------
##############Falcon DSP Host Interface                            ###########
-------+-----+-----------------------------------------------------+----------
$FFA200|byte |Interrupt Ctrl Register           BIT 7 6 5 4 3 . 1 0|R/W (F030)
X:$FFE9|     |INIT bit -----------------------------' | | | |   | ||
       |     |00 - Interupt mode (DMA off) -----------+-+ | |   | ||
       |     |01 - 24-bit DMA mode -------------------+-+ | |   | ||
       |     |10 - 16-bit DMA mode -------------------+-+ | |   | ||
       |     |11 - 8-bit DMA mode --------------------+-' | |   | ||
       |     |Host Flag 1 --------------------------------' |   | ||
       |     |Host Flag 0 ----------------------------------'   | ||
       |     |         Host mode Data transfers:                | ||
       |     |              Interrupt mode                      | ||
       |     |00 - No interrupts (Polling) ---------------------+-+|
       |     |01 - RXDF Request (Interrupt) --------------------+-+|
       |     |10 - TXDE Request (Interrupt) --------------------+-+|
       |     |11 - RXDF and TXDE Request (Interrupts) ----------+-+|
       |     |                 DMA Mode                         | ||
       |     |00 - No DMA --------------------------------------+-+|
       |     |01 - DSP to Host Request (RX) --------------------+-+|
       |     |10 - Host to DSP Request (TX) --------------------+-+|
       |     |11 - Undefined (Illegal) -------------------------+-'|
$FFA201|byte |Command Vector Register           BIT 7 . . 4 3 2 1 0|R/W (F030)
X:$FFE9|     |Host Command Bit (Handshake)----------'     | | | | ||
       |     |Host Vector (0-31) -------------------------+-+-+-+-'|
$FFA202|byte |Interrupt Status Reg              BIT 7 6 . 4 3 2 1 0|R   (F030)
X:$FFE8|     |ISR Host Request ---------------------' |   | | | | ||
       |     |ISR DMA Status -------------------------'   | | | | ||
       |     |Host Flag 3 --------------------------------' | | | ||
       |     |Host Flag 2 ----------------------------------' | | ||
       |     |ISR Transmitter Ready (TRDY) -------------------' | ||
       |     |ISR Transmit Data Register Empty (TXDE) ----------' ||
       |     |ISR Receive Data Register Full (RXDF) --------------'|
$FFA203|byte |Interrupt Vector Register                            |R/W (F030)
$FFA204|byte |Unused                                               |    (F030)
$FFA205|byte |DSP-Word High                                        |R/W (F030)
X:$FFEB|     |                                                     |
$FFA206|byte |DSP-Word Mid                                         |R/W (F030)
X:$FFEB|     |                                                     |
$FFA207|byte |DSP-Word Low                                         |R/W (F030)
X:$FFEB|     |                                                     |
-------+-----+-----------------------------------------------------+----------
##############MFP 68901 - Multi Function Peripheral Chip           ###########
-------+-----+-----------------------------------------------------+----------
       |     |     MFP Master Clock is 2,457,600 cycles/second     |
-------+-----+-----------------------------------------------------+----------
$FFFA01|byte |Parallel Port Data Register                          |R/W
-------+-----+-----------------------------------------------------+----------
$FFFA03|byte |Active Edge Register              BIT 7 6 5 4 . 2 1 0|R/W
       |     |Monochrome monitor detect ------------' | | | | | | ||
       |     |RS-232 Ring indicator ------------------' | | | | | ||
       |     |FDC/HDC interrupt ------------------------' | | | | ||
       |     |Keyboard/MIDI interrupt --------------------' | | | ||
       |     |Reserved -------------------------------------' | | ||
       |     |RS-232 CTS (input) -----------------------------' | ||
       |     |RS-232 DCD (input) -------------------------------' ||
       |     |Centronics busy ------------------------------------'|
       |     +-----------------------------------------------------+
       |     |       When port bits are used for input only:       |
       |     |0 - Interrupt on pin high-low conversion             |
       |     |1 - Interrupt on pin low-high conversion             |
-------+-----+-----------------------------------------------------+----------
$FFFA05|byte |Data Direction                    BIT 7 6 5 4 3 2 1 0|R/W
       |     |0 - In, 1 - Out ----------------------+-+-+-+-+-+-+-'|
-------+-----+-----------------------------------------------------+----------
$FFFA07|byte |Interrupt Enable A                BIT 7 6 5 4 3 2 1 0|R/W
$FFFA0B|byte |Interrupt Pending A               BIT 7 6 5 4 3 2 1 0|R/W
$FFFA0F|byte |Interrupt In-service A            BIT 7 6 5 4 3 2 1 0|R/W
$FFFA13|byte |Interrupt Mask A                  BIT 7 6 5 4 3 2 1 0|R/W
       |     |MFP Address                           | | | | | | | ||
       |     |$13C GPI7-Monochrome Detect ----------' | | | | | | ||
       |     |$138   RS-232 Ring Detector ------------' | | | | | ||
       |     |$134 (STe sound)    Timer A --------------' | | | | ||
       |     |$130    Receive buffer full ----------------' | | | ||
       |     |$12C          Receive error ------------------' | | ||
       |     |$128      Send buffer empty --------------------' | ||
       |     |$124             Send error ----------------------' ||
       |     |$120 (HBL)          Timer B ------------------------'|
       |     |1 - Enable Interrupt            0 - Disable Interrupt|
-------+-----+-----------------------------------------------------+----------
$FFFA09|byte |Interrupt Enable B                BIT 7 6 5 4 3 2 1 0|R/W
$FFFA0D|byte |Interrupt Pending B               BIT 7 6 5 4 3 2 1 0|R/W
$FFFA11|byte |Interrupt In-service B            BIT 7 6 5 4 3 2 1 0|R/W
$FFFA15|byte |Interrupt Mask B                  BIT 7 6 5 4 3 2 1 0|R/W
       |     |MFP Address                           | | | | | | | ||
       |     |$11C                FDC/HDC ----------' | | | | | | ||
       |     |$118          Keyboard/MIDI ------------' | | | | | ||
       |     |$114 (200hz clock)  Timer C --------------' | | | | ||
       |     |$110 (USART timer)  Timer D ----------------' | | | ||
       |     |$10C           Blitter done ------------------' | | ||
       |     |$108     RS-232 CTS - input --------------------' | ||
       |     |$104     RS-232 DCD - input ----------------------' ||
       |     |$100        Centronics Busy ------------------------'|
       |     |1 - Enable Interrupt            0 - Disable Interrupt|
-------+-----+-----------------------------------------------------+----------
$FFFA17|byte |Vector Register                   BIT 7 6 5 4 3 . . .|R/W
       |     |Vector Base Offset -------------------+-+-+-' |      |
       |     |1 - *Software End-interrupt mode -------------+      |
       |     |0 - Automatic End-interrupt mode -------------'      |
       |     |* - Default operating mode                           |
-------+-----+-----------------------------------------------------+----------
$FFFA19|byte |Timer A Control                         BIT 4 3 2 1 0|R/W
$FFFA1B|byte |Timer B Control                         BIT 4 3 2 1 0|R/W
       |     |Reset (force output low) -------------------' | | | ||
       |     +----------------------------------------------+-+-+-++
       |     |0000 - Timer stop, no function executed              |
       |     |0001 - Delay mode, divide by 4                       |
       |     |0010 -     :           :     10                      |
       |     |0011 -     :           :     16                      |
       |     |0100 -     :           :     50                      |
       |     |0101 -     :           :     64                      |
       |     |0110 -     :           :     100                     |
       |     |0111 - Delay mode, divide by 200                     |
       |     |1000 - Event count mode                              |
       |     |1xxx - Pulse extension mode, divide as above         |
       |     +-----------------------------------------------------+
$FFFA1F|byte |Timer A Data                                         |R/W
$FFFA21|byte |Timer B Data                                         |R/W
-------+-----+-----------------------------------------------------+----------
$FFFA1D|byte |Timer C & D Control                 BIT 6 5 4 . 2 1 0|R/W
       |     |                                        Timer   Timer|
       |     |                                          C       D  |
       |     +-----------------------------------------------------+
       |     |000 - Timer stop                                     |
       |     |001 - Delay mode, divide by 4                        |
       |     |010 -      :           :    10                       |
       |     |011 -      :           :    16                       |
       |     |100 -      :           :    50                       |
       |     |101 -      :           :    64                       |
       |     |110 -      :           :    100                      |
       |     |111 - Delay mode, divide by 200                      |
       |     +-----------------------------------------------------+
$FFFA23|byte |Timer C Data                                         |R/W
$FFFA25|byte |Timer D Data                                         |R/W
-------+-----+-----------------------------------------------------+----------
$FFFA27|byte |Sync Character                                       |R/W
$FFFA29|byte |USART Control                     BIT 7 6 5 4 3 2 1 .|R/W
       |     |Clock divide (1 - div by 16) ---------' | | | | | | ||
       |     |Word Length 00 - 8 bits ----------------+-+ | | | | ||
       |     |            01 - 7 bits ----------------+-+ | | | | ||
       |     |            10 - 6 bits ----------------+-+ | | | | ||
       |     |            11 - 5 bits ----------------+-' | | | | ||
       |     |Bits Stop Start Format                      | | | | ||
       |     |00     0    0   Synchronous ----------------+-+ | | ||
       |     |01     1    1   Asynchronous ---------------+-+ | | ||
       |     |10     1    1.5 Asynchronous ---------------+-+ | | ||
       |     |11     1    2   Asynchronous ---------------+-' | | ||
       |     |Parity (0 - ignore parity bit) -----------------' | ||
       |     |Parity (0 - odd parity,1 - even) -----------------' ||
       |     |Unused ---------------------------------------------'|
$FFFA2B|byte |Receiver Status                   BIT 7 6 5 4 3 2 1 0|R/W
       |     |Buffer full --------------------------' | | | | | | ||
       |     |Overrun error --------------------------' | | | | | ||
       |     |Parity error -----------------------------' | | | | ||
       |     |Frame error --------------------------------' | | | ||
       |     |Found - Search/Break detected ----------------' | | ||
       |     |Match/Character in progress --------------------' | ||
       |     |Synchronous strip enable -------------------------' ||
       |     |Receiver enable bit --------------------------------'|
$FFFA2D|byte |Transmitter Status                BIT 7 6 5 4 3 2 1 0|R/W
       |     |Buffer empty -------------------------' | | | | | | ||
       |     |Underrun error -------------------------' | | | | | ||
       |     |Auto turnaround --------------------------' | | | | ||
       |     |End of transmission ------------------------' | | | ||
       |     |Break ----------------------------------------' | | ||
       |     |High bit ---------------------------------------' | ||
       |     |Low bit ------------------------------------------' ||
       |     |Transmitter enable ---------------------------------'|
$FFFA2F|byte |USART data                                           |R/W
-------+-----+-----------------------------------------------------+----------
##############Floating Point Coprocessor (CIR Interface in MSTe)   ###########
-------+-----+-----------------------------------------------------+----------
$FFFA40|word |FP_Stat    Response-Register                         |??? (MSTe)
$FFFA42|word |FP_Ctl     Control-Register                          |??? (MSTe)
$FFFA44|word |FP_Save    Save-Register                             |??? (MSTe)
$FFFA46|word |FP_Restor  Restore-Register                          |??? (MSTe)
$FFFA48|word |                                                     |??? (MSTe)
$FFFA4A|word |FP_Cmd     Command-Register                          |??? (MSTe)
$FFFA4E|word |FP_Ccr     Condition-Code-Register                   |??? (MSTe)
$FFFA50|long |FP_Op      Operand-Register                          |??? (MSTe)
$FFFA54|word |FP_Selct   Register Select                           |??? (MSTe)
$FFFA58|long |FP_Iadr    Instruction Address                       |??? (MSTe)
$FFFA5C|long |           Operand Address                           |??? (MSTe)
-------+-----+-----------------------------------------------------+----------
##############MFP 68901 #2 (MFP2) - TT Only                        ###########
-------+-----+-----------------------------------------------------+----------
$FFFA81|byte |Parallel Port Data Register                          |R/W   (TT)
-------+-----+-----------------------------------------------------+----------
$FFFA83|byte |Active Edge Register              BIT 7 6 5 4 3 2 1 0|R/W   (TT)
       |     +-----------------------------------------------------+
       |     |       When port bits are used for input only:       |
       |     |0 - Interrupt on pin high-low conversion             |
       |     |1 - Interrupt on pin low-high conversion             |
-------+-----+-----------------------------------------------------+----------
$FFFA85|byte |Data Direction                    BIT 7 6 5 4 3 2 1 0|R/W   (TT)
       |     |0 - In, 1 - Out ----------------------+-+-+-+-+-+-+-'|
-------+-----+-----------------------------------------------------+----------
$FFFA87|byte |Interrupt Enable A                BIT 7 6 5 4 3 2 1 0|R/W   (TT)
$FFFA8B|byte |Interrupt Pending A               BIT 7 6 5 4 3 2 1 0|R/W   (TT)
$FFFA8F|byte |Interrupt In-service A            BIT 7 6 5 4 3 2 1 0|R/W   (TT)
$FFFA93|byte |Interrupt Mask A                  BIT 7 6 5 4 3 2 1 0|R/W   (TT)
       |     |MFP Address                           | | | | | | | ||
       |     |$17C         TT-SCSI NCR5380 ---------' | | | | | | ||
       |     |$178         RTC (MC146818A) -----------' | | | | | ||
       |     |$174                 Timer A -------------' | | | | ||
       |     |$170     Receive buffer full ---------------' | | | ||
       |     |$16C           Receive error -----------------' | | ||
       |     |$168       Send buffer empty -------------------' | ||
       |     |$164              Send error ---------------------' ||
       |     |$160                 Timer B -----------------------'|
       |     |1 - Enable Interrupt            0 - Disable Interrupt|
-------+-----+-----------------------------------------------------+----------
$FFFA89|byte |Interrupt Enable B                BIT 7 6 5 4 3 2 1 0|R/W   (TT)
$FFFA8D|byte |Interrupt Pending B               BIT 7 6 5 4 3 2 1 0|R/W   (TT)
$FFFA91|byte |Interrupt In-service B            BIT 7 6 5 4 3 2 1 0|R/W   (TT)
$FFFA95|byte |Interrupt Mask B                  BIT 7 6 5 4 3 2 1 0|R/W   (TT)
       |     |MFP Address                           | | | | | | | ||
       |     |$15C     SCSI DMA Controller ---------' | | | | | | ||
       |     |$158       (Reserved) GPIP 4 -----------' | | | | | ||
       |     |$154                 Timer C -------------' | | | | ||
       |     |$150                 Timer D ---------------' | | | ||
       |     |$14C    SCC B Ring Indicator -----------------' | | ||
       |     |$148      SCC DMA Controller -------------------' | ||
       |     |$144 General Purpose Input 1 ---------------------' ||
       |     |$140 General Purpose Input 0 -----------------------'|
       |     |1 - Enable Interrupt            0 - Disable Interrupt|
-------+-----+-----------------------------------------------------+----------
$FFFA97|byte |Vector Register                   BIT 7 6 5 4 3 . . .|R/W   (TT)
       |     |Vector Base Offset -------------------+-+-+-' |      |
       |     |1 - *Software End-interrupt mode -------------+      |
       |     |0 - Automatic End-interrupt mode -------------'      |
       |     |* - Default operating mode                           |
-------+-----+-----------------------------------------------------+----------
$FFFA99|byte |Timer A Control                         BIT 4 3 2 1 0|R/W   (TT)
$FFFA9B|byte |Timer B Control                         BIT 4 3 2 1 0|R/W   (TT)
       |     |Reset (force output low) -------------------' | | | ||
       |     +----------------------------------------------+-+-+-++
       |     |0000 - Timer stop, no function executed              |
       |     |0001 - Delay mode, divide by 4                       |
       |     |0010 -     :           :     10                      |
       |     |0011 -     :           :     16                      |
       |     |0100 -     :           :     50                      |
       |     |0101 -     :           :     64                      |
       |     |0110 -     :           :     100                     |
       |     |0111 - Delay mode, divide by 200                     |
       |     |1000 - Event count mode                              |
       |     |1xxx - Pulse extension mode, divide as above         |
       |     +-----------------------------------------------------+
$FFFA9F|byte |Timer A Data                                         |R/W   (TT)
$FFFAA1|byte |Timer B Data                                         |R/W   (TT)
-------+-----+-----------------------------------------------------+----------
$FFFA9D|byte |Timer C & D Control                 BIT 6 5 4 . 2 1 0|R/W   (TT)
       |     |                                        Timer   Timer|
       |     |                                          C       D  |
       |     +-----------------------------------------------------+
       |     |000 - Timer stop                                     |
       |     |001 - Delay mode, divide by 4                        |
       |     |010 -      :           :    10                       |
       |     |011 -      :           :    16                       |
       |     |100 -      :           :    50                       |
       |     |101 -      :           :    64                       |
       |     |110 -      :           :    100                      |
       |     |111 - Delay mode, divide by 200                      |
       |     +-----------------------------------------------------+
$FFFAA3|byte |Timer C Data                                         |R/W   (TT)
$FFFAA5|byte |Timer D Data                                         |R/W   (TT)
-------+-----+-----------------------------------------------------+----------
$FFFAA7|byte |Sync Character                                       |R/W   (TT)
$FFFAA9|byte |USART Control                     BIT 7 6 5 4 3 2 1 .|R/W   (TT)
       |     |Clock divide (1 - div by 16) ---------' | | | | | | ||
       |     |Word Length 00 - 8 bits ----------------+-+ | | | | ||
       |     |            01 - 7 bits ----------------+-+ | | | | ||
       |     |            10 - 6 bits ----------------+-+ | | | | ||
       |     |            11 - 5 bits ----------------+-' | | | | ||
       |     |Bits Stop Start Format                      | | | | ||
       |     |00     0    0   Synchronous ----------------+-+ | | ||
       |     |01     1    1   Asynchronous ---------------+-+ | | ||
       |     |10     1    1.5 Asynchronous ---------------+-+ | | ||
       |     |11     1    2   Asynchronous ---------------+-' | | ||
       |     |Parity (0 - ignore parity bit) -----------------' | ||
       |     |Parity (0 - odd parity,1 - even) -----------------' ||
       |     |Unused ---------------------------------------------'|
$FFFAAB|byte |Receiver Status                   BIT 7 6 5 4 3 2 1 0|R/W   (TT)
       |     |Buffer full --------------------------' | | | | | | ||
       |     |Overrun error --------------------------' | | | | | ||
       |     |Parity error -----------------------------' | | | | ||
       |     |Frame error --------------------------------' | | | ||
       |     |Found - Search/Break detected ----------------' | | ||
       |     |Match/Character in progress --------------------' | ||
       |     |Synchronous strip enable -------------------------' ||
       |     |Receiver enable bit --------------------------------'|
$FFFAAD|byte |Transmitter Status                BIT 7 6 5 4 3 2 1 0|R/W   (TT)
       |     |Buffer empty -------------------------' | | | | | | ||
       |     |Underrun error -------------------------' | | | | | ||
       |     |Auto turnaround --------------------------' | | | | ||
       |     |End of transmission ------------------------' | | | ||
       |     |Break ----------------------------------------' | | ||
       |     |High bit ---------------------------------------' | ||
       |     |Low bit ------------------------------------------' ||
       |     |Transmitter enable ---------------------------------'|
$FFFAAF|byte |USART data                                           |R/W   (TT)
-------+-----+-----------------------------------------------------+----------
##############6850 ACIA I/O Chips                                  ###########
-------+-----+-----------------------------------------------------+----------
$FFFC00|byte |Keyboard ACIA control             BIT 7 6 5 4 3 2 1 0|W
       |     |Rx Int enable (1 - enable) -----------' | | | | | | ||
       |     |Tx Interrupts                           | | | | | | ||
       |     |00 - RTS low, Tx int disable -----------+-+ | | | | ||
       |     |01 - RTS low, Tx int enable ------------+-+ | | | | ||
       |     |10 - RTS high, Tx int disable ----------+-+ | | | | ||
       |     |11 - RTS low, Tx int disable,           | | | | | | ||
       |     |     Tx a break onto data out ----------+-' | | | | ||
       |     |Settings                                    | | | | ||
       |     |000 - 7 bit, even, 2 stop bit --------------+-+-+ | ||
       |     |001 - 7 bit, odd, 2 stop bit ---------------+-+-+ | ||
       |     |010 - 7 bit, even, 1 stop bit --------------+-+-+ | ||
       |     |011 - 7 bit, odd, 1 stop bit ---------------+-+-+ | ||
       |     |100 - 8 bit, 2 stop bit --------------------+-+-+ | ||
       |     |101 - 8 bit, 1 stop bit --------------------+-+-+ | ||
       |     |110 - 8 bit, even, 1 stop bit --------------+-+-+ | ||
       |     |111 - 8 bit, odd, 1 stop bit ---------------+-+-' | ||
       |     |Clock divide                                      | ||
       |     |00 - Normal --------------------------------------+-+|
       |     |01 - Div by 16 -----------------------------------+-+|
       |     |10 - Div by 64 -----------------------------------+-+|
       |     |11 - Master reset --------------------------------+-'|
$FFFC00|byte |Keyboard ACIA control             BIT 7 6 5 4 3 2 1 0|R
       |     |Interrupt request --------------------' | | | | | | ||
       |     |Parity error ---------------------------' | | | | | ||
       |     |Rx overrun -------------------------------' | | | | ||
       |     |Framing error ------------------------------' | | | ||
       |     |CTS ------------------------------------------' | | ||
       |     |DCD --------------------------------------------' | ||
       |     |Tx data register empty ---------------------------' ||
       |     |Rx data register full ------------------------------'|
$FFFC02|byte |Keyboard ACIA data                                   |R/W
$FFFC04|byte |MIDI ACIA control                 BIT 7 6 5 4 3 2 1 0|W
       |     |Rx Int enable (1 - enable) -----------' | | | | | | ||
       |     |Tx Interrupts                           | | | | | | ||
       |     |00 - RTS low, Tx int disable -----------+-+ | | | | ||
       |     |01 - RTS low, Tx int enable ------------+-+ | | | | ||
       |     |10 - RTS high, Tx int disable ----------+-+ | | | | ||
       |     |11 - RTS low, Tx int disable,           | | | | | | ||
       |     |     Tx a break onto data out ----------+-' | | | | ||
       |     |Settings                                    | | | | ||
       |     |000 - 7 bit, even, 2 stop bit --------------+-+-+ | ||
       |     |001 - 7 bit, odd, 2 stop bit ---------------+-+-+ | ||
       |     |010 - 7 bit, even, 1 stop bit --------------+-+-+ | ||
       |     |011 - 7 bit, odd, 1 stop bit ---------------+-+-+ | ||
       |     |100 - 8 bit, 2 stop bit --------------------+-+-+ | ||
       |     |101 - 8 bit, 1 stop bit --------------------+-+-+ | ||
       |     |110 - 8 bit, even, 1 stop bit --------------+-+-+ | ||
       |     |111 - 8 bit, odd, 1 stop bit ---------------+-+-' | ||
       |     |Clock divide                                      | ||
       |     |00 - Normal --------------------------------------+-+|
       |     |01 - Div by 16 -----------------------------------+-+|
       |     |10 - Div by 64 -----------------------------------+-+|
       |     |11 - Master reset --------------------------------+-'|
$FFFC04|byte |MIDI ACIA control                 BIT 7 6 5 4 3 2 1 0|R
       |     |Interrupt request --------------------' | | | | | | ||
       |     |Parity error ---------------------------' | | | | | ||
       |     |Rx overrun -------------------------------' | | | | ||
       |     |Framing error ------------------------------' | | | ||
       |     |CTS ------------------------------------------' | | ||
       |     |DCD --------------------------------------------' | ||
       |     |Tx data register empty ---------------------------' ||
       |     |Rx data register full ------------------------------'|
$FFFC06|byte |MIDI ACIA data                                       |R/W
-------+-----+-----------------------------------------------------+----------
##############Realtime Clock                                       ###########
-------+-----+-----------------------------------------------------+----------
$FFFC21|byte |S_Units                                              |???
$FFFC23|byte |S_Tens                                               |???
$FFFC25|byte |M_Units                                              |???
$FFFC27|byte |M_Tens                                               |???
$FFFC29|byte |H_Units                                              |???
$FFFC2B|byte |H_Tens                                               |???
$FFFC2D|byte |Weekday                                              |???
$FFFC2F|byte |Day_Units                                            |???
$FFFC31|byte |Day_Tens                                             |???
$FFFC33|byte |Mon_Units                                            |???
$FFFC35|byte |Mon_Tens                                             |???
$FFFC37|byte |Yr_Units                                             |???
$FFFC39|byte |Yr_Tens                                              |???
$FFFC3B|byte |Cl_Mod                                               |???
$FFFC3D|byte |Cl_Test                                              |???
$FFFC3F|byte |Cl_Reset                                             |???
-------+-----+-----------------------------------------------------+----------
##############ROM                                                  ###########
-------+-----+-----------------------------------------------------+----------
$FA0000|     |                                                     |
    :  |     |128K ROM expansion cartridge port                    |R
$FBFFFF|     |                                                     |
-------+-----+-----------------------------------------------------+----------
$FC0000|     |                                                     |
    :  |     |192K System ROM                                      |R
$FEFFFF|     |                                                     |
-------+-----+-----------------------------------------------------+----------

                               Atari 32 bit Memory Map

Addresses           Description
-------------------+----------------------------------------------------------
$00000000-$00DFFFFF|ST RAM
$00E00000-$00EFFFFF|512k TOS ROMs
$00F00000-$00F9FFFF|Reserved I/O Space
$00FA0000-$00FBFFFF|128k ROM cartridge expansion port
$00FC0000-$00FEFFFF|192k System ROM
$00FF0000-$00FF7FFF|Reserved I/O Space
$00FF8000-$00FFFFFF|ST/TT I/O
$01000000-$013FFFFF|TT Fast Ram
$01400000-$FDFFFFFF|Reserved
$FE000000-$FEFFFFFF|VME A24/D16
$FEFF0000-$FEFFFFFF|VME A16/D16
$FF000000-$FFFFFFFF|ST 24 bit compatible shadow
$FFD000xx-$FFD000xx|Set FastRAM refresh rate and generate a bus error
-------------------+----------------------------------------------------------

                                   Cookie Jar
                            Atari "Official" Cookies
Cookie  Description
-------+----------------------------------------------------------------------
_CPU   | CPU Type                                          Bit 7 6 5 4 3 2 1 0
       | Processor type is represented in decimal in the lowest byte.
       | (0 - 68000, 40 - 68040)
-------+----------------------------------------------------------------------
_VDO   | Video Type                                                  BIT 17 16
       | Shifter Type                                                     |  |
       | 00 - ST ---------------------------------------------------------+--+
       | 01 - STe --------------------------------------------------------+--+
       | 10 - TT ---------------------------------------------------------+--+
       | 11 - Falcon030 --------------------------------------------------+--'
-------+----------------------------------------------------------------------
_FDC   | Floppy Drive Controller                              BIT 25 24 . 23-0
       | Floppy Format                                             |  |      |
       | 00 - DD (Normal floppy interface) ------------------------+--+      |
       | 01 - HD (1.44 MB with 3.5") ------------------------------+--+      |
       | 10 - ED (2.88 MB with 3.5") ------------------------------+--'      |
       | Controller ID                                                       |
       | 0 - No information available                                        |
       | 'ATC' - Fully compatible interface built in a way that -------------+
       |         behaves like part of the system.                            |
       | 'DP1' - "DreamPark Development", all ID's beginning with -----------'
       |         "DP" are reserved for Dreampark.
-------+----------------------------------------------------------------------
_FLK   | File Locking
       | If present, GEMDOS supports file locking. Value represents version
       | number of the expansion.
-------+----------------------------------------------------------------------
_NET   | Network Type
       | If present, there is GEMDOS network support. Points to 2 longs:
       | The first is the ID of the producer, and the second is the version
       | number.
-------+----------------------------------------------------------------------
_SLM   | SLM Driver
       | Diablo-driver for the SLM laser printer. Value points to a
       | non-documented structure.
-------+----------------------------------------------------------------------
_INF   | .INF Patch
       | When present, STEFIX (patch program for TOS 1.06) is active.
-------+----------------------------------------------------------------------
_SND   | Sound Hardware                                        BIT 5 4 3 2 1 0
       | CodeC (??) -----------------------------------------------' | | | | |
       | Connection Matrix ------------------------------------------' | | | |
       | DSP56001 -----------------------------------------------------' | | |
       | 16 Bit DMA Sound -----------------------------------------------' | |
       | 8 Bit DMA Sound --------------------------------------------------' |
       | YM2149 -------------------------------------------------------------'
-------+----------------------------------------------------------------------
_MCH   | Machine Type                                                BIT 17 16
       | 00 - ST/Mega ST -------------------------------------------------+--+
       | 01 - STe & Compatible Machines (See Below) ----------------------+--+
       | 10 - TT ---------------------------------------------------------+--+
       | 11 - Falcon030 --------------------------------------------------+--'
       | STe & Compatible Machines                             BIT 5 4 3 2 1 0
       | 00000 - STe ----------------------------------------------+-+-+-+-+-+
       | 00001 - ST Book ------------------------------------------+-+-+-+-+-+
       | 10000 - Mega STe -----------------------------------------+-+-+-+-+-'
-------+----------------------------------------------------------------------
_SWI   | Configuration Switches
       | State of configuration switches (MSTe/TT only)
-------+----------------------------------------------------------------------
_FRB   | Fast Ram Buffer
       | (TT specific) 64k buffer for ACSI DMA
       | 0 - no buffers assigned    Not 0 - address of FastRam buffer
-------+----------------------------------------------------------------------
_FPU   | FPU Type
       | Software FPU                                              BIT 3 2 1 0
       | 68040's internal FPU -----------------------------------------' | | |
       | 01 - 6888x present ---------------------------------------------+-+ |
       | 10 - 68881 for sure --------------------------------------------+-+ |
       | 11 - 68882 for sure --------------------------------------------+-' |
       | SFP004 present -----------------------------------------------------'
       | Hardware FPU                                            BIT 11 10 9 8
       | 68040's internal FPU ----------------------------------------'  | | |
       | 01 - 6888x present ---------------------------------------------+-+ |
       | 10 - 68881 for sure --------------------------------------------+-+ |
       | 11 - 68882 for sure --------------------------------------------+-' |
       | SFP004 present -----------------------------------------------------'
-------+----------------------------------------------------------------------
_OOL   | PoolFix
       | Value corresponds to PoolFix version
-------+----------------------------------------------------------------------
_AKP   | Keyboard/Language Configuration
       | Keyboard Configuration                                       Bit 15-8
       | 1 - German   5 - Italian -------------------------------------------+
       | 2 - French   7 - Swiss French --------------------------------------+
       | 4 - Spanish  8 - Swiss German --------------------------------------+
       | All others - English -----------------------------------------------'
       | Language Configuration                                        BIT 7-0
       | 1 - German   5 - Italian -------------------------------------------+
       | 2 - French   7 - Swiss French --------------------------------------+
       | 4 - Spanish  8 - Swiss German --------------------------------------+
       | All others - English -----------------------------------------------'
-------+----------------------------------------------------------------------
_IDT   | International Date/Time Format
       | Time Format                                                    BIT 12
       | 0 - AM/PM, 1 - 24 hours --------------------------------------------+
       | Date Format                                                   BIT 9 8
       | 00 - MMDDYY ------------------------------------------------------+-+
       | 01 - DDMMYY ------------------------------------------------------+-+
       | 10 - YYMMDD ------------------------------------------------------+-+
       | 11 - YYDDMM ------------------------------------------------------+-'
       | Separator for date                                            BIT 7-0
       | ASCII Value (i.e. "." or "/") --------------------------------------'
-------+----------------------------------------------------------------------
MiNT   | MiNT
       | Present if MiNT/MultiTOS is active. Value represents the version
       | number of the MiNT kernel in hex (0x104 = 1.04)
-------+----------------------------------------------------------------------

```