Title: Computer Virus Catalog (Version 1.2) - A89
Slug: CVA89
Name: ATARIVIR.789
Date: 1989-10-31 12:34
Location: Germany
Category: Atari ST, Virus
Lang: en
Author: Virus Test Center
status: published
summary: Computer Virus Catalog (Version 1.2) - A89 
image: {filename}../images/hamburg.png
Tags: archives


<pre>
========================================================================
==                Computer Virus Catalog (Version 1.2)                ==
========================================================================
==        Status:      October 31, 1989                               ==
==        Classified: 15 MSDOS-Viruses (MSDOSVIR.A89)                 ==
==                    24 AMIGA-Viruses (AMIGAVIR.A89)                 ==
==                     6 Atari-Viruses (ATARIVIR.A89: this document)  ==
========================================================================
= This document contains the classifications of the following viruses: =
==             1) Anthrax = Milzbrand Virus                          =+=
==             2) c't Virus                                           ==
==             3) Emil 1A Virus = "Virus 1A"                          == 
==             4) Emil 2A Virus = "Virus 2A" = mad Virus              ==
==             5) Mouse (Inverter) Virus                             =U=
==             6) Zimmermann-Virus                                    ==
========================================================================
== Remark: updates or additions sind  last edition (July 31st, 1989)  ==
== are marked =U= or =+= in column 72. We have problems to get        ==
== viruses, since many users wish to exchange their viruses (like     ==
== stamps) against our's, which we principally refuse: the Virus Test ==
== Center's ethical standard is, that we do not spread viruses!       ==
========================================================================
 
======================================================================== 
== The Computer Virus Catalog may be copied free of charges provided  ==
== that the source is properly mentioned at any time and location     ==
== of reference.                                                      ==
==                                                                    ==
==  Editor:   Virus Test Center, Faculty for Informatics              ==
==            University of Hamburg                                   ==
==            Schlueterstr. 70,  D2000 Hamburg 13, FR Germany         ==
==            Prof. Dr. Klaus Brunnstein, Simone Fischer-Huebner      ==
==            Tel: (040) 4123-4158 (KB), -4715 (SFH), -4162(Secr.)    ==
==  Email (EAN/BITNET): Brunnstein@RZ.Informatik.Uni-Hamburg.dbp.de   ==
======================================================================== 
==  Critical and constructive comments as well as additions are       ==
==  appreciated. Especially, descriptions of recently detected viruses =
==  will be of general interest. To receive the Virus Catalog Format, == 
==  please contact the above address.                                 ==
========================================================================
 
 
== Computer Virus Catalog 1.2: Milzbrand=Anthrax Virus (Nov.9, 1989) ===
Entry...............: Milzbrand Virus
Alias(es)...........: Anthrax
Virus Strain........: ---
Virus detected when.: April 1987
              where.: C'T (a german computermagazin)
Classification......: Program Virus (Extending V.)
Length of Virus.....: 1222 Bytes 
--------------------- Preconditions -----------------------------------
Operating System(s).: ATARI-TOS
Version/Release.....: All Versions of ATARI TOS 
Computer model(s)...: All Atari ST models
--------------------- Attributes -------------------------------------
Wasy Identification.: if killing the FAT it shows six 'Viruses' on screen
                      the Virus body (readable with HexDump-facilities)
                      include the text : 'DIES IST EIN VIRUS'
                                         (=`This is a Virus')
Type of infection...: Executable File infection(.PRG) extending
Infection Trigger...: all programs>1000 Bytes
Storage media affected: Infects programs on disks and hard disks 
                        (in the actuell path)
Interrupts hooked...: ---
Damage..............: overwriting bootblock and FAT on disks A and B
Damage Trigger......: year=1987
Particularities.....: shows six 'Viruses' on screen
Similarities........: ---
--------------------- Agents ------------------------------------------
Countermeasures.....: Category 1.1 Monitoring Files: program which
                                   monitors (attempted) changes of
                                   files
                      Category 2: Alteration Detection: a program which
                                  detects changes of given files
                      Category 3: Eradication: a program which erases
                                  specific virus code from files
Countermeasures successful: --- 
Standard means......: Write protect the disk
--------------------- Acknowledgement ---------------------------------
Location............: Virus Test Center, University Hamburg, FRG
Classification by...: ---
Documentation by....: Ralf Stegen
Date................: Nov.9 1989
Information Source..: C'T April 1987
===================== End of MILZBRAND Virus ==========================
 
 
===== Computer Virus Catalog 1.2: c't-Virus (July 30, 1989) ============
Entry...............: c't Virus 
Alias(es)...........: ---  
Virus Strain........: ---
Virus detected when.: ---
              where.: ---
Classification......: System (=BootSector) Virus, Reset-resident.
Length of Virus.....: 512 Byte
--------------------- Preconditions ------------------------------------
Operating System(s).: ATARI-TOS
Version/Release.....: 1.0 (06.02.86), 1.2 (TOS 1.4 not tested)
Computer model(s)...: All types of the Atari ST Series
--------------------- Attributes ---------------------------------------
Identification......: ---
Type of infection...: The virus tests two longwords near the top of the
                      available memory at locations (memtop)-$200 and
                      (memtop)-$200+$A.
                      The first longword is checked for $12123456, the
                      second one for $07A31CDF. If one of these doesnot
                      match, the virus is installed.
                      The virus is reset-resident.
                      1st: Virus is copied to a new location in memory;
                      2nd: Virus's age is increased by 1.
Infection Trigger...: Each time a diskette is changed, the new one
                      will be infected.
Storage media affected: Infects only diskettes. Damages Hard disks.
Interrupts hooked...: No interupts used.hdv_bpb and hdv_mediach vectors 
                      are changed for installation in the system.
Damage..............: Transient/Permanent damage:
                      A damage can occur only if a harddisk is connected 
                      to the system. Because of an error in the virus, 
                      the partition information will be destroyed, if 
                      the virus tries to write to the harddisk.
                      Otherwise, the following message is displayed on 
                      the screen after every 20th infection:
                      "ARRRGGGHHH Diskvirus hat wieder zugeschlagen" 
Damage Trigger......: Value of infection counter: every 20th infection.
Particularities.....: ---
Similarities........: ---
--------------------- Agents -------------------------------------------
Countermeasures.....: Programs that calculate the checksum and change 
                      it, if it is $1234; the sector is then regarded as 
                      not executable. (Category 1.3)
Countermeasures successful: ---
Standard means......: Write-protect the disk. Write a well-known program
                      to the boot sector; 'manually' change the check-
                      sum to a value other than $1234 .
--------------------- Acknowledgement ----------------------------------
Location............: Virus Test Center, University Hamburg, FRG
Classification by...: 
Documentation by....: Michael Gaudlitz          
Translated by.......: Bert K④hler  
Date................: July 30, 1989
Information Source..: c't (Computer Magazine)                              
===================== End of c't Virus =================================
 
 
===== Computer Virus Catalog 1.2: Emil 1A Virus (July 30, 1989) ========
Entry...............: Emil 1A Virus  
Alias(es)...........: "Virus 1A"
Virus Strain........: ---
Virus detected when.: 1987? 
              where.: FR Germany
Classification......: System (Boot Sector) Virus
Length of Virus.....: 512 Byte
--------------------- Preconditions ------------------------------------
Operating System(s).: Atari-TOS
Version/Release.....: 1.0, 1.2 (1.4 not tested)
Computer model(s)...: All types of the Atari ST Series
--------------------- Attributes ---------------------------------------
Easy Identification.: Boot sector will not be infected, if first word 
                      is $6038.
Type of infection...: Infects the boot sector of the disk, if it is
                      regarded as not infected.
Infection Trigger...: Each time a floppy disk is changed, the new 
                      disk will be infected.
Storage media affected: Floppy disks.
Interrupts hooked...: No interrupts used; diskvector hdv_bpb changed.
Damage..............: Infects the boot sector of the disk, if it is 
                      regarded to be non-infected.
                      If the memory resident virus finds a fitting 
                      key on a boot sector (first longword = $60381092),
                      then that sector is loaded and executed, regard-
                      less of the checksum. (Normally, the checksum
                      should be $1234 to indicate that this boot sector
                      is executable).
Damage Trigger......: Keyword ($60381092) in other Boot sectors. 
Particularities.....: ---
Similarities........: See Emil 2A Virus.
--------------------- Agents -------------------------------------------
Countermeasures.....: Programs that calculate the checksum and 
                      change it, if it is $1234; then, the sector  
                      is regarded as not executable. The suspicious 
                      (dangerous) second part of the virus might 
                      not be recognized because it does not need
                      to have the proper checksum (see: Damage).
Countermeasures successful: --- 
Standard means......: Write protect the disk.
                      Write a well-known program to the boot sector;
                      'manually' change the checksum to a value other 
                      than $1234 .
--------------------- Acknowledgement ----------------------------------
Location............: Virus Test Center, University Hamburg, FRG
Classification by...: Thomas Piehl/ Michael Nagel
Documentation by....: Bert K④hler
Translated by.......: Bert K④hler/Paul Drake (Racal-Milgo/TEMEX)/
Date................: July 30, 1989
Information Source..: ---
===================== End of Emil 1A Virus =============================
 
 
===== Computer Virus Catalog 1.2: Emil 2A Virus (July 30, 1989) ========
Entry...............: Emil 2A Virus  
Alias(es)...........: "Virus 2A" = mad Virus
Virus Strain........: ---
Virus detected when.: 1987?
              where.: FR Germany
Classification......: System (Boot Sector) Virus
Length of Virus.....: 512 Byte
--------------------- Preconditions ------------------------------------
Operating System(s).: ATARI-TOS
Version/Release.....: 1.0, 1.2 (TOS 1.4 not tested)
Computer model(s)...: All ATARI ST Computer models
--------------------- Attributes ---------------------------------------
Easy Identification.. First byte in infected boot sector is $60.
Type of infection.... Infects the boot sector of a disk, if it is 
                      regarded as not yet infected (value other than
                      $60 in first byte) and increments a variable.
Infection Trigger...: Every access to non-infected floppy disk.
Storage media affected: Floppy disks.
Interrupts hooked...: No Interrupts used;
                      hdv_rw vector changed to infect new disks.
Damage............... Permanent Damage: overwrites Boot sectors.
                      Transient damage: After each 5th infection, the 
                      screen is randomly shifted (upside down) or
                      inverted, together with a beep.
Damage Trigger......: Random.
Particularities.....: Evidently, this is a "Demo Virus"; but it may 
                      easily be changed to a dangerous one with only 
                      moderate programming experiences.
Similarities........: See Emil 1A Virus.
--------------------- Agents -------------------------------------------
Countermeasures.....: Programs that calculate the checksum and change 
                      it, if it is $1234; then, the sector is regarded 
                      as not executable.
Countermeasures successful: --- 
Standard means......: Write protect the disk.
                      Write a well-known program to the boot sector;
                      'manually' change the checksum to a value other 
                      than $1234.
                      Reboot the system with a 'clean' disk.
--------------------- Acknowledgement ----------------------------------
Location............: Virus Test Center, University Hamburg, FRG
Classification by...: Ralf Stegen
Documentation by....: Ralf Stegen
Translation by......: Bert K④hler
Date................: July 30, 1989
Information Source..: ---
===================== End of Emil 2A Virus =============================
 
 
== Computer Virus Catalog 1.2: Mouse (Inverter) Virus (Nov.11 1989) ==
Entry...............: Mouse (Inverter) Virus
Alias(es)...........: Ghost 
Virus Strain........: ---
Virus detected when.: ---
              where.: ---
Classification......: System (BootSector) Virus, Reset-resident, 
                      Overwriting
Length of Virus.....: 512 Byte
--------------------- Preconditions -----------------------------------
Operating System(s).: ATARI-TOS 
Version/Release.....: All Version of TOS
Computer model(s)...: All types of the Atari ST Series
--------------------- Attributes -------------------------------------
Easy Identification.: ---
Type of infection...: Self-Identification: The Virus tests adresse $140
                      for the first Virus instruction; virus installs
                      itself reset- and RAMresident if virus code does
                      not match.
Infection Trigger...: Each time a new diskette is inserted, the virus 
                      will infect the new diskette.
Storage media affected: The virus infect drive A,B!
Interrupts hooked...: No Interrupts used.
                      Resetvector for installation changed.
                      hdv_bpb changed to infect Bootsector of new Disk.
Damage..............: Permanent Damage: Overwriting Bootsectors.
                      Transient Damage: Inverting Mouse Up-Down Moving-
                                        direction.
Damage Trigger......: Damage Action after 10 infections. Always after     
                      5 new infections,the Mouse Movingdirection is 
                      again inverted.
Particularities.....: ---
Similarities........: ---
--------------------- Agents ------------------------------------------
Countermeasures.....: Programm that checks hdv_bpb-, Reset-vector if 
                      adresse is not lower $400(Exception vectors)
                      (Category 1.2).
                      Programs that calculate the checksum and change 
                      it, if it is $1234; the sector is then regarded
                      as not executable. Reboot the system with a
                      'clean' disk! ( Category 1.3 ).
Countermeasures successful: Poke instruction 'move.l #$D6,d3' to 
                      adresse $140 (this excludes Virus' installation).
Standard means......: Write-protect the disk. 
                      Write a well-known program to the boot sector;
                      'manually' change the checksum to a value other 
                      than $1234.
--------------------- Acknowledgement ---------------------------------
Location............: Virus Test Center, University Hamburg, FRG
Classification by...: Thomas Piehl  
Documentation by....: Thomas Piehl             
Date................: Nov. 11,1989
Information Source..: ---
===================== End of Mouse (Inverter) Virus ====================
 
 
===== Computer Virus Catalog 1.2: Zimmermann-Virus (July 30, 1989) =====
Entry...............: Zimmermann-Virus  
Alias(es)...........: ---
Virus Strain........: ---
Virus detected when.: 1988?
              where.: FR Germany
Classification......: Program Virus (Extending V.)
Length of Virus.....: 1414 Byte
--------------------- Preconditions ------------------------------------
Operating System(s).: ATARI-TOS
Version/Release.....: All versions
Computer model(s)...: All types of the Atari ST Series             
--------------------- Attributes ---------------------------------------
Easy Identification.: Infected System: The virus checks if the Trap 1-
                      vector points to a certain byte-sequence. Infected
                      programs are recognized by enlargement of the file
                      length and by typical virus specific code.
Type of infection...: Program virus: the virus code is appended at the
                      end of the program; the loader table is adjusted.
Infection Trigger...: Every time when a program is executed.
Storage media affected: Floppy disks only.
Interupts hooked....: VBL-Interupt for time control.
                      Trap #1 to control program start. 
Damage..............: Permanent Damage: the virus only infects files 
                      with extensions PRG, TTP and TOS in the current 
                      directory on drives A and B. The program's 
                      startup-time is considerably increased.
Damage Trigger......: ---
Particularities.....: After installation in the system, the virus is
                      distributed every time a program is started from 
                      disk A or B. Approximately 30 minutes after the 
                      installation, the virus generates a file, 50 bytes
                      long, with an unusual name consisting of special 
                      characters: "@^#%&   .(-: ".  The file is read-
                      only and contains the following text:
 
                      ";-) As MAD Zimmermann will be watching you )-;"
 
                      The characters at the ends of the line can be 
                      regarded as a happy face on the left and a sad 
                      face on the right side; probably kind of ASCII-
                      comic with political background: F.Zimmermann is 
                      a well-known conservative politician in FRG, and
                      a strong opponent of privacy and data protection; 
                      as former minister of Interior, he was responsible
                      for several intelligence agencies, though not for 
                      the German military intelligence service "MAD".
Similarities........: ---
--------------------- Agents -------------------------------------------
Countermeasures.....: The virus can be detected in and removed from  
                      infected files by 'Zimmermann Virusfilter 
                      Program', written by Thomas Piehl (see below).
Countermeasures successful: 4DETECT detects the Zimmermann-Virus, if you 
                      set 'System Supervision' to 'On'; 4DETECT then
                      tells when the trap #1 vector is changed. 
                      4DETECT also supervises suspicious write accesses
                      to boot sectors and program files.
Standard means......: Write-protect the disk.
--------------------- Acknowledgement ----------------------------------
Location............: Virus Test Center, University Hamburg, FRG
Classification by...: Thomas Piehl           
Documentation by....: Thomas Piehl
Translated by.......: Bert K④hler
Date................: July 30, 1989
Information Source..: ---
===================== End of Zimmermann-Virus ==========================
 
========================================================================
==                  End of ATARIVIR.789 document                      ==
==              (375 Lines, 2.045 Words, 21k Bytes)                   ==
========================================================================
</pre>