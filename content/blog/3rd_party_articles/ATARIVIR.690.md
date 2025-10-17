Title: Computer Virus Catalog (Version 1.2) - 690
Slug: CV690
Name: ATARIVIR.690
Date: 1990-06-05 12:34
Location: Germany
Category: Atari ST, Virus
Lang: en
Author: Virus Test Center
status: published
summary: Computer Virus Catalog (Version 1.2) - 690
image: {filename}../images/hamburg.png
Tags: archives

<pre>
========================================================================
==                Computer Virus Catalog (Version 1.2)                ==
==                      *** 18 Atari Viruses ***                      ==
========================================================================
==      Status:        June 5, 1990                                   ==
==      Classified:  6 Atari-Viruses (ATARIVIR.A89): Nov. 15, 1989    ==
==                 +12 Atari-Viruses (ATARIVIR.690): June  5, 1990    ==
========================================================================
==       List of classified Atari Viruses:                         =Doc=
==       ---------------------------------                         =---=
==          +  1) ACA Virus                                        =690=
==             2) Anthrax = Milzbrand Virus                        =A89=
==          +  3) ANTI-2 Virus                                     =690=
==          +  4) Blot Virus                                       =690=
==             5) c't Virus                                        =A89=
==             6) Emil 1A = "Key" = "BPL" Virus ="Virus 1A"        =A89= 
==             7) Emil 2A Virus = "Virus 2A"                       =A89=
==          +  8) Goblins Virus                                    =690=
==          +  9) Kobold 2 Virus                                   =690=
==          + 10) LAB Virus                                        =690=
==          + 11) MAD Virus                                        =690=
==          + 12) Maulwurf (=Mole) Virus                           =690=                  
==            13) Mouse (Inverter) Virus                           =A89=
==          + 14) Oli Virus                                        =690=
==          + 15) Pirate Trap Virus                                =690=
==          + 16) Screen Virus                                     =690=
==            17) Zimmermann-Virus                                 =A89=
==          + 18) 5th Generation Virus                             =690=
== Remark: new entries are marked "+" in column 13; the suffix (A89,  ==
== 690) refers to the specific documents where entry is published.    ==
==                                                                    ==
== Presently, the following viruses are analysed:                     ==
==             .) Freeze Virus                                        ==
== Generally, we have problems to receive Atari viruses for analysis, ==
== since many users wish to exchange their viruses (like stamps)      ==
== against our's, which we principally refuse: the Virus Test Centers ==
== ethical standard is, that we do not spread viruses!                ==
========================================================================
 
 
======== Computer Virus Catalog 1.2: "ACA"-VIRUS (5-June-1990) ========
Entry............... "ACA" Virus
Alias............... ---
Strain.............. ---
Detected when....... October 1988
         where...... Utrecht (Netherlands)
Classification...... System (Bootsector) Virus, Reset-resident
Length of virus..... 512 Bytes
------------------------Preconditions----------------------------------
Operating System(s). Atari TOS
Version\Release..... All versions
Computer models..... All Atari ST,STE
-------------------------Attributes------------------------------------
Easy identification. If the bootsector is infected, the string "ACA"
                     can be found at bootsector position $04 and $4E.
                     In memory, the same string can be found at $630.
Type of infection...: Self-Identification: The Virus tests boot sector-
                      position 4 for String "AC"; if string does not 
                      match, virus infects boot sector.
                      Reset-resident at address $600 via magic long-
                      word ($12123456) and checksum ($1234).
Infection Trigger...: Reset
Storage media affected: The virus infects drive A,B!
Interrupts hooked...: No Interrupts used.
                      No system vectors changed
Damage..............: Permanent Damage: Only after reset overwriting 
                      boot sectors.
                      Transient Damage: Clearing first track
Damage Trigger......: Damage occurs after 10 infections. 
Particularities.....: ---
Similarities........: ---
--------------------- Agents -----------------------------------------
Countermeasures.....: Program that search for reset-resident programs, 
                      especialy lower system area ($800).
                      Programs that calculate the checksum and change 
                      it, if it is $1234; the sector is then regarded
                      as not executable. Reboot the system with a
                      'clean' disk! ( Category 1.3 ).
Countermeasures successful:---
Standard means......: Write-protect the disk. 
                      Write a well-known program to the boot sector;
                      'manually' change the checksum to a value other 
                      than $1234.
--------------------- Acknowledgement ---------------------------------
Location............: Virus Test Center, University Hamburg, FRG
Classification by...: Thomas Piehl  
Documentation by....: Thomas Piehl 
Information Source..: from George R. Woodside           
Date................: 5-June-1990
==================== End of "ACA"-VIRUS ===============================
 
 
======== Computer Virus Catalog 1.2 "ANTI-2" Virus (5-June-1990) ======
Entry............... "Anti-2" Antivirus Virus
Alias............... ---
Strain.............. ---
Detected when....... October 1988
         where...... Helmond (Netherlands)
Clssification....... Bootsector Virus
Length of virus..... 512 Bytes
------------------------Preconditions----------------------------------
Operating System(s). Atari TOS
Version\Release..... All versions
Computer models..... All Atari ST
-------------------------Attributes------------------------------------
Easy identification. The string : "This Anti-Virus beeps" can be found 
                        in the bootsector at Byte Nr. $1E, or in memory 
                        at Dskbufp+$600+$1E.
Type of infection... Any non-executable Bootsector will be overwritten
Infection Trigger... Execution of BIOS disk function Getbpb.
Media affected...... Any kind of media. 
Interrupts hooked... hdv_bpb vector (used by BIOS disk functions).
Damage.............. ---
Damage trigger...... ---
Particularities..... The Program can be used as an anti-virus. If the
                        bootsector is executable, the program produces 
                        a sound and the screen flashes.
Similarities........ ---
-----------------------------------------------------------------------
Countermeasures..... Make sure that the virus is not in memory. Modify
                        the last byte in bootsector to another value.
Standart means...... Clear all bytes in bootsector beginning at
                        offset 30 decimal.
-----------------------Acknowledgements--------------------------------
Location............ Virus Test Center, University of Hamburg, FRG
Classification by... Andre' Schaper
Documentation by.... Andre' Schaper
Information Source.. George R. Woodside
Date................ 5-June-1990
==================== End of "Anti-2" Virus ============================
 
 
======== Computer Virus Catalog 1.2: "Blot" Virus (5-June-1990) =======
Entry............... "Blot" Virus
Alias............... ---
Strain.............. ---
Detected when....... May 1988
         where...... Amherst (USA)
Classification...... Boot sector virus
Length of virus..... 681 Bytes
------------------------Preconditions----------------------------------
Operating System(s). Atari TOS
Version\Release..... ROM TOS from 02.06.1986; in other versions,
                         no action is performed.
Computer models..... All Atari ST
-------------------------Attributes------------------------------------
Easy identification. In memory at Phystop +34 and in the boot sector at 
                     the same offset, the following bytes can be found:
                         $0206198600FC0018 
Type of infection... Boot sector of drive A.
Infection trigger... Usage of drive A.
Media affected...... Drive A. 
Interrupts hooked... 200 Hz interrupt , Bios Parameter Vector.
                     Critical Error Handler at infection time.
                     Phystop is decremented by 1 KByte.
Damage.............. The screen is blacked out from bottom to middle 
                     and from top to middle at same time. 
Damage trigger.....  Virus is about 3 hours in Ram. (Depends on value 
                     of 200 Hz timer).  
Particularities..... Only boot sectors that aren't executable are in-
                     fected.
Similarities........ The general concept of the virus is similar to the 
                     'Screen'-Virus
-----------------------------------------------------------------------
Countermeasures..... Make sure that the virus is not in memory.
                     Search bootsector for the string mentioned above.
                     Modify last byte in boot sector to another value.
Standard means...... Clear all bytes in bootsector (sector 0) beginning  
                     at offset 30 (dec) and clear all bytes in sector 5.
-------------------- Acknowledgements----------------------------------
Location............ Virus Test Center, University of Hamburg FRG
Classifcation by.... Ralf Stegen
Documentation by.... Ralf Stegen
Information Source.. George R. Woodside
Date................ 5-June-1990
==================== End of "Blot" Virus ==============================
 
 
====== Computer Virus Catalog 1.2: "GOBLINS" Virus (5-June-1990) ======
Entry............... "GOBLINS" Virus
Alias............... -
Strain.............. -
Detected when....... May 1989
         where...... Utrecht (Netherlands)
Clssification....... System (Boot sector) Virus
Length of virus..... 512 Bytes
------------------------Preconditions----------------------------------
Operating System(s). Atari TOS
Version\Release..... TOS 1.2
Computer models..... All Atari ST
-------------------------Attributes------------------------------------
Easy identification. The string  "The Little Green Goblins" can be 
                     found in the boot sector $1B6, or in memory
                     at pystop -$8200 +$1B6.
Type of infection... The actual boot sector will be overwritten.
Infection Trigger... Execution of BIOS disk function Getbpb.
Media affected...... Floppy disk drive with device 0 (A:) or 1 (B:).  
Interrupts hooked... hdv_bpb vector (used by BIOS disk Getbpb).
Damage.............. - First text line or menu line is modified until
                       next execution of the damage routine.
                     - A message is printed on the screen.
Damage trigger...... Copy Counter in Memory:
                     (Counter mod 16) = 0    :   Modify screen
                     (Counter mod 128)= 0    :   Print message.
Particularities..... The virus is reset-resident!
Similarities........ ---
-----------------------------------------------------------------------
Countermeasures..... Make sure that the virus is not in memory.
                     Modify the last byte in boot sector to other value.
Standard means...... Clear all bytes in boot sector beginning at
                     offset 30 (decimal).
-----------------------Acknowledgements--------------------------------
Location............ Virus Test Center, University of Hamburg, FRG
Classification by... Andre' Schaper
Documentation by.... Andre' Schaper
Information Source.. George R. Woodside
Date................ 5-June-1990
==================== End of "GOBLINS" Virus ===========================
 
 
======== Computer Virus Catalog 1.2: "KOBOLD 2" (5-June-1990) =========
Entry............... "Kobold 2" Virus
Alias............... ---
Strain.............. ---
Detected when....... ---
         where...... Utrecht (Netherlands)
Classification...... System (Boot sector) Virus, Reset-resident
Length of virus..... 512 Bytes
------------------------Preconditions----------------------------------
Operating System(s). Atari TOS
Version\Release..... TOS 1.0 and 1.2
Computer models..... Atari ST 
-------------------------Attributes------------------------------------
Easy identification. If the boot sector is infected, the string
                     'KOBOLD#2 AKTIV!' can be found in the middle of the
                     boot sector; in memory, this string can be found
                     at beginning of transient programm area (TPA).
Type of infection... Any boot sector that can be written to.
Infection trigger... Execution of XBIOS disk functions.
                     Execution of boot code.
Media affected...... Drive which is set as boot device or accessed by 
                     XBIOS.
Interrupts hooked... Vertical Blank Interrupt at infection time;
                     hdv_bpb (harddisk bios parameter block);
                     resetvector.
Damage.............: Permanent Damage: Overwriting Bootsectors.
                     Transient Damage: Speeding up mouse motion 
                         in directions UP and LEFT. 
Damage trigger.....: Internal counter 
Particularities..... With TOS 1.2, mouse motion is not changed.
Similarities........ ---
Countermeasures..... Make sure that the virus is not in memory.
                     Search boot sector for string mentioned above.
                     Modify last byte in boot sector to other value.
Standard means...... Clear all bytes in boot sector beginning at
                     offset 30 decimal.
-----------------------Acknowledgements--------------------------------
Location............ Virus Test Center, University of Hamburg FRG
Classifcation by.... Thomas Piehl
Documentation by.... Thomas Piehl
Information Source.. George R. Woodside
Date................ 5-June-1990
==================== End of "KOBOLD #2" VIRUS =========================
 
 
======== Computer Virus Catalog 1.2: "LAB"-VIRUS (5-June-1990) ========
Entry............... "LAB" Virus
Alias............... ---
Strain.............. ---
Detected when....... 1989
         where...... Utrecht (Netherlands)
Classification...... System (Boot sector) Virus, Reset-resident
Length of virus..... 512 Bytes
------------------------Preconditions-------------------------------------
Operating System(s). Atari TOS
Version\Release..... Version TOS 1.0 AND TOS 1.2
Computer models..... All Atari ST with TOS 1.0 or blitter TOS
-------------------------Attributes------------------------------------
Easy identification. If the bootsector is infected, the string "Virus"
                     can be found at bootsector position $02. In memory,
                     the same string can be found behind screen memory.
Type of infection...: Self-Identification: No identification.
                      The virus installs itself RAM-resident behind
                      screen memory.
Infection Trigger...: Each time a new diskette is inserted, the virus 
                      will infect the new diskette.
Storage media affected: The virus infects drive A,B
Interrupts hooked...: No Interrupts used.
                      hdv_bpb changed to infect Bootsector of new Disk.
Damage..............: Permanent Damage: Overwriting Bootsectors.
                      Transient Damage: Painting screen black.
Damage Trigger......: Damage action after 10 infections. 
Particularities.....: If virus is installed and harddisk is connected,
                      sometimes harddisk access maybe impossible.
Similarities........: ---
--------------------- Agents ------------------------------------------
Countermeasures.....: Programs that calculate the checksum and change 
                      it, if it is $1234; the sector is then regarded
                      as not executable. Reboot the system with a
                      'clean' disk! (Category 1.3).
Countermeasures successful:---
Standard means......: Write-protect the disk. 
                      Write a well-known program to the boot sector;
                      'manually' change the checksum to a value other 
                      than $1234.
--------------------- Acknowledgement ---------------------------------
Location............: Virus Test Center, University Hamburg, FRG
Classification by...: Thomas Piehl  
Documentation by....: Thomas Piehl 
Information Source..: from George R. Woodside           
Date................: 5-June-1990
===================== End of "LAB"-VIRUS ==============================
 
 
=========Computer Virus Catalog 1.2: "MAD" Virus (5-June-1990) ========
Entry............... "MAD" Virus
Alias............... -
Strain.............. -
Detected when....... October 1988
         where...... Helmond (Netherlands)
Clssification....... Boot sector virus
Length of virus..... 512 Bytes
------------------------Preconditions----------------------------------
Operating System(s). Atari TOS
Version\Release..... All versions
Computer models..... All Atari ST
-------------------------Attributes------------------------------------
Easy identification. The words : $7FE,$80F,$8100,$400  can be found 
                     on boot sector at Byte $1D6, and in memory
                     at phystop-$300+$1D6.
Type of infection... Any Boot sector that can be written to.
Infection Trigger... Execution of BIOS disk functions.
Media affected...... Floppy disk drive with device 0 (A:) or 1 (B:). 
Interrupts hooked... hdv_rw vector (used by BIOS disk functions).
Damage.............. Only screen damage:
                        -Change screen address
                        -Rotate screen bytes
                        -Invert screen
                        -Split screen into upper and lower half and
                         change them 
                        -Make a sound (beep)
Damage trigger...... Copy counter = 6 (6 bootsectors infected).
Particularities..... ---
Similarities........ "Anti-2" Virus
-----------------------------------------------------------------------
Countermeasures..... Make sure that the virus is not in memory.
                     Modify the last byte in boot sector to other value.
Standard means...... Clear all bytes in boot sector beginning at
                     offset 30 decimal.
-----------------------Acknowledgements--------------------------------
Location............ Virus Test Center, University of Hamburg, FRG
Classification by... Andre' Schaper
Documentation by.... Andre' Schaper
Information Source.. George R. Woodside
Date................ 5-June-1990
==================== End of "MAD" Virus ===============================
 
 
== Computer Virus Catalog 1.2: "Maulwurf" (Mole) Virus (5-June-1990) ==
Entry...............: "Maulwurf" (=Mole) Virus
Alias(es)...........: Maulwurf I SSG (=Subversive Software Group) Virus
Virus Strain........: ---
Virus detected when.: 14 May 1989
              where.: Utrecht (Netherlands)
Classification......: System (BootSector) Virus, Reset-resident, 
                      Overwriting
Length of Virus.....: 512 Byte
--------------------- Preconditions -----------------------------------
Operating System(s).: ATARI-TOS 
Version/Release.....: Only TOS Version 1.0
Computer model(s)...: Atari ST with TOS 1.0
--------------------- Attributes --------------------------------------
Easy Identification.: ---
Type of infection...: Self-Identification: The virus tests, if its 
                      whole code from boot sector is behind screen 
                      memory; if not, virus installs itself reset-
                      resident and  patches system initialisation
                      after reset.
Infection Trigger...: Each time a new diskette is inserted, the virus 
                      will infect the new diskette.
Storage media affected: The virus infects only drive A,B
Interrupts hooked...: -VBL Interrupt: 1.to check if hdv_bpb is changed 
                                        back to old address; 
                                      2.to test if time is right to 
                                        deadlock the system.
                      -Resetvector to patch system initialisation.
                      -hdv_bpb changed to infect boot sector of new disk.
Damage..............: Permanent Damage: Overwriting boot sectors.
                      Transient Damage: Whole screen filled with message
                      'Maulwurf I - SSG (Subversive Software Group)' 
                      and deadlock system also after reset if time is 
                      over.
Damage Trigger......: after 7 minutes + number of infections * 5 minutes     
                      The counter is located at start of virus+$1FC.
Particularities.....: ---
Similarities........: ---
--------------------- Agents ------------------------------------------
Countermeasures.....: Programs that checks hdv_bpb-, Reset-vector if 
                      adress points after screen memory (Category 1.2).
                      Programs that calculate the checksum and change 
                      it, if it is $1234; the sector is then regarded
                      as not executable. Reboot the system with a
                      'clean' disk! (Category 1.3).
Countermeasures successful:---
Standard means......: Write-protect the disk. 
                      Write a well-known program to the boot sector;
                      'manually' change the checksum to a value other 
                      than $1234.
--------------------- Acknowledgement ---------------------------------
Location............: Virus Test Center, University Hamburg, FRG
Classification by...: Thomas Piehl  
Documentation by....: Thomas Piehl
Information Source..: from George R. Woodside
Date................: 5-June-1990
===================== End of "Maulwurf I" Virus =======================
 
 
======== Computer Virus Catalog 1.2: "OLI" VIRUS (5-June-1990) ========
Entry............... "OLI" Virus
Alias............... ---
Strain.............. ---
Detected when....... May 1989
         where...... Utrecht (Netherlands)
Classification...... Boot sector virus
Length of virus..... 512 Bytes
------------------------Preconditions----------------------------------
Operating System(s). Atari TOS
Version\Release..... All versions
Computer models..... All Atari ST
-------------------------Attributes------------------------------------
Easy identification. If the boot sector is infected, the string
                     "OLI-VIRUS installed ." can be found at end of
                     the boot sector; in memory, the same string can 
                     be found at $7B6.
Type of infection... Any boot sector that can be written to.
Infection trigger... Execution of XBIOS disk functions.
                     Execution of boot code.
Media affected...... Drive which is set as boot device or accessed by 
                     XBIOS.
Interrupts hooked... TRAP #14, TRAP #12 set to old value of TRAP #14.
                     Vertical Blank Interrupt at infection time.
Damage.............. Transient damage:1.Message on screen: 
                                  "OLI-VIRUS installed. "
                               2. The computer slows down until stop; 
                                  all CPU time is used by Vertical
                                  Blank Interrupt; time until stop 
                                  depends on the time the computer has 
                                  been used (=number of VBI's).
Damage trigger.....  Internal counter =0 (3rd byte in boot code
                        +$414 in RAM).
Particularities..... The virus simulates an uninfected boot sector by
                     modifying the read buffer. The disk information
                     is left unchanged, and the virus code is over-
                     written with $4E ='N'. 
                     The virus is recognised by Sagrotan because of 
                     direct programming of the FDC.
Similarities........ ---
-----------------------------------------------------------------------
Countermeasures..... Make sure that the virus is not in memory.
                     Search bootsector for the string mentioned
                     above. Modify the last byte in boot sector
                     to another value.
Standard means...... Clear all bytes in boot sector beginning at
                     offset 30 decimal.
-----------------------Acknowledgements--------------------------------
Location............ Virus Test Center, University of Hamburg, FRG
Classifcation by.... Ronald Greinke
Documentation by.... Ronald Greinke
Information......... George R. Woodside
Date................ 5-June-1990
==================== End of "OLI" Virus ===============================
 
 
==== Computer Virus Catalog 1.2: "PIRATE TRAP" VIRUS (5-June-1990) ====
Entry............... "PIRATE TRAP" Virus
Alias............... ---
Strain.............. ---
Detected when....... May 1989
         where...... 
Classification...... System (Boot sector) Virus, Reset-resident
Length of virus..... 512 Bytes
------------------------Preconditions----------------------------------
Operating System(s). Atari TOS
Version\Release..... all TOS versions
Computer models..... All Atari ST
-------------------------Attributes------------------------------------
Easy identification. In memory behind screen memory and in the boot
                     sector, the following string can be found.:
                     "*** The Pirate Trap ***
                      * Youre being watched *
                      *** [C] P.M.S. 1987 ***"
Type of infection... Boot sector of drive A.
Infection trigger... Execution of XBIOS floprd on bootsector of drive A.
                     Execution of boot code.
Media affected...... Drive A. 
Interrupts hooked... TRAP #14 XBIOS, reset vector.
Damage.............. The the message mentioned above appears on screen,
                     and the computer waits for a keystroke; then, the 
                     computer continues execution.
Damage trigger.....  Internal counter = 0. 
Particularities..... A lower counter on disk than the one in memory
                     is not changed.
Similarities........ ---
-----------------------------------------------------------------------
Countermeasures..... Make sure that the virus is not in memory.
                     Search boot sector for the string mentioned
                     above. Modify the last byte in boot sector
                     to another value.
Standard means...... Clear all bytes in boot sector beginning at
                     offset 30 decimal.
-----------------------Acknowledgements--------------------------------
Location............ Virus Test Center, University of Hamburg, FRG
Classification by... Ronald Greinke
Documentation by.... Ronald Greinke
Information Source.. George R. Woodside
Date................ 5-June-1990
==================== End of "PIRATE TRAP" Virus =======================
 
 
======= Computer Virus Catalog 1.2: "SCREEN" VIRUS (5-June-1990) ======
Entry............... "SCREEN" Virus
Alias............... ---
Strain.............. ---
Detected when....... May 1989
         where...... Utrecht (Netherlands)
Classification...... Boot sector virus
Length of virus..... 456 Bytes (512)
------------------------Preconditions----------------------------------
Operating System(s). Atari TOS
Version\Release..... ROM TOS from 02.06.1986; in other versions,
                         virus will not be installed.
Computer models..... All Atari ST
-------------------------Attributes------------------------------------
Easy identification. In memory at Phystop +34 and in the boot sector at 
                     the same offset, the following bytes can be found:
                        $0206198600FC0018 
Type of infection... Boot sector of drive A.
Infection trigger... Usage of drive A.
Media affected...... Drive A. 
Interrupts hooked... 200 Hz interrupt($114) for time-control and damage.
                     hdv_bpb to infect bootsector.
                     Critical Error Handler at infection time.
                     Phystop is decremented by 512.
Damage.............. The screen is blacked out from bottom to middle 
                     and from top to middle at same time; no more action 
                     can be performed as screen is permanently black. 
Damage trigger.....  Between 3 and 30 minutes (depends on value of 
                     200 Hz timer; action when timer >=360000). 
Particularities..... Only boot sectors that are not executable are in- 
                     fected. The word at offset 30 from beginning of 
                     bootsector varies from infection to infection. If 
                     a reset is performed, the virus becomes inactive
                     but is still in RAM. If the virus is on a disk
                     used after reset and the damage was active before 
                     reset, it reappears after 3 minutes. 
Similarities........ Same screen damage as BLOT VIRUS (same routine).
-----------------------------------------------------------------------
Countermeasures..... Make sure that the virus is not in memory.
                     Search boot sector for the string mentioned
                     above. Modify the last byte in boot sector
                     to another value.
Standard means...... Clear all bytes in boot sector beginning at
                     offset 30 decimal.
-----------------------Acknowledgements--------------------------------
Location............ Virus Test Center, University of Hamburg, FRG
Classification by... Ronald Greinke
Documentation by.... Ronald Greinke
Information Source.. George R. Woodside
Date................ 5-June-1990
====================== End of "SCREEN" Virus ==========================
 
 
====== Computer Virus Catalog 1.2: "5th Generation" (5-June-1990) =====
Entry...............: "5th. Generation"  
Alias(es)...........: ---
Virus Strain........: ---
Virus detected when.: May 1989
              where.: Utrecht (Netherlands)
Classification......: Bootsector-Virus
Length of Virus.....: 326 Bytes
--------------------- Preconditions -----------------------------------
Operating System(s).: Atari-TOS
Version/Release.....: 1.0, 1.2 (1.4 not yet tested)
Computer model(s)...: All types of the Atari ST Series
--------------------- Attributes --------------------------------------
Identification......: First word in the boot sector = $601C. 
Type of infection...: Infects the boot sector of the disk A, if it is 
                      regarded to be non-infected.
Infection Trigger...: check if bootsector is executable
Media affected......: Infection of disc in drive A.
Interrupts hooked...: BIOS-Trap used and changed by this virus.
Damage..............: Infects the boot sector of the disk, if it is 
                      regarded to be un-infected. Clear Track 0 
                      with the FAT and the directory.
Damage Trigger......: If counter (at start of virus + 324) = 0. Initial
                      value depends on number of infections.
Particularities.....: ---
Similarities........: ---
--------------------- Agents ------------------------------------------
Countermeasures.....: Programs that calculate the bootsector's checksum 
                      and modify it, if it is $1234; then, the sector  
                      is regarded as not executable. The suspected  
                      more dangerous second part of the virus might 
                      not be recognized because it does not need
                      to have the correct checksum.
Countermeasures successful: ---
Standard means......: Write protect the disk / Write an easily 
                      identifiable bootsector / 'Manually' change the 
                      checksum to a value other than $1234 .
--------------------- Acknowledgement ---------------------------------
Location............: Virus Test Center, University Hamburg, FRG
Classification by...: Ralf Stegen
Documentation by....: Ralf Stegen
Information Source..: George R. Woodside
Date................: 5-June-1990
===================== End of "5th Generation"-Virus ===================
 
 
======================================================================== 
== The Computer Virus Catalog may be copied free of charges provided  ==
== that the source is properly mentioned at any time and location     ==
== of reference.                                                      ==
==                                                                    ==
==  Editor:   Virus Test Center, Faculty for Informatics              ==
==            University of Hamburg                                   ==
==            Schlueterstr. 70,  D2000 Hamburg 13, FR Germany         ==
==            Prof. Dr. Klaus Brunnstein, Simone Fischer-Huebner      ==
==            Tel: (040) 4123-4158 (KB), -4175 (SFH), -4162(Secr.)    ==
==  Email (EAN/BITNET): Brunnstein@RZ.Informatik.Uni-Hamburg.dbp.de   ==
======================================================================== 
==  Critical and constructive comments as well as additions are       ==
==  appreciated. Especially, descriptions of recently detected viruses =
==  will be of general interest. To receive the Virus Catalog Format, == 
==  please contact the above address.                                 ==
========================================================================
 
========================================================================
==                  End of ATARIVIR.690 document                      ==
==              (640 Lines, 3.407 Words, 35k Bytes)                   ==
========================================================================
</pre>