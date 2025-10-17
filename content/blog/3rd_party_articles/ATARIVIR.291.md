Title: Computer Virus Catalog (Version 1.2) - 291
Slug: CVC291
Name: ATARIVIR.291
Date: 1991-02-15 12:34
Location: Germany
Category: Atari ST, Virus
Lang: en
Author: Virus Test Center
status: published
summary: Computer Virus Catalog (Version 1.2) - 291
image: {filename}../images/hamburg.png
Tags: archives

<pre>
======================================================================
==                Computer Virus Catalog (Version 1.2)              ==
==                      *** 20 Atari Viruses ***                    ==
======================================================================
==      Status:        Feburary 15, 1991                            ==
==      Classified:  6 Atari viruses (ATARIVIR.A89): Nov. 15, 1989  ==
==                 +12 Atari viruses (ATARIVIR.690): June  5, 1990  ==
==                 + 2 Atari viruses (ATARIVIR.291): Feb. 15, 1991  ==
======================================================================
==       List of 20 classified Atari Viruses:                    =Doc=
==       ------------------------------------                    =---=
==    1) ACA Virus                                               =690=
==    2) ANTI-2 Virus                                            =690=
==    3) ANTHRAX = Milzbrand Virus                               =A89=
==    4) Blot Virus                                              =690=
==    5) c't Virus                                               =A89=
==    6) Emil 1A Virus = "Virus 1A"                              =A89= 
==    7) Emil 2A Virus = "Virus 2A" = mad Virus                  =A89=
== +  8) Freeze Virus                                            =291=
== +  9) Gauweiler Virus                                         =291=
==   10) Goblins Virus                                           =690=
==   11) Kobold 2 Virus                                          =690=
==   12) Lab Virus                                               =690=
==   13) Mad Virus                                               =690=
==   14) Maulwurf (=Mole) Virus                                  =690=
==   15) Mouse (Inverter) Virus                                  =A89=
==   16) Oli Virus                                               =690=
==   17) Pirate Trap Virus                                       =690=
==   18) Screen Virus                                            =690=
==   19) Zimmermann-Virus                                        =A89=
==   20) 5th Generation Virus                                    =690=
==                                                                  ==
== Remark: new entries are marked "+" in column 13; the suffix (A89,==
== 690,291) refers to the documents where entry is published.       ==
==                                                                  ==
== We have problems to get Atari viruses, as many users wish to ex- ==
== change their viruses (like stamps) against our's, which we gene- ==
== rally refuse: the Virus Test Center's ethical standard says, that =
== we do not help to spread viruses! Please send infected programs  ==
== without preconditions; we may only then continue our work.       ==
======================================================================
 
====== Computer Virus Catalog 1.2: Freeze Virus (31-January-1991) ====
Entry...............: "Freeze" Virus
Alias...............: ---
Strain..............: ---
Detected when.......: October 1988
         where......: Helmond (Netherlands)
Clssification.......: System (bootsector) virus, overwriting
Length of virus.....: 512 Bytes
------------------------Preconditions---------------------------------
Operating System(s).: Atari TOS
Version\Release.....: All versions
Computer models.....: All Atari ST
-------------------------Attributes-----------------------------------
Easy identification.: The words : $487A,$0010 can be found in the boot
                         sector at Positon $100, or in memory at 
                         :phystop-$300+$100 (all: hex).
Type of infection...: Executable bootsectors are not infected.
Infection Trigger...: Execution of BIOS disk functions.
Media affected......: The virus infects drive A and B. 
Interrupts hooked...: Timer interrupt installed for damage; hdv_bpb 
                         changed to infect bootsector of new disk.
Damage..............: Every second the timer-routine increases a delay 
                         counter by 1 and then counting it down to 
                         zero; this will slowdown the system.
Damage trigger......: When the virus is booted.
Particularities.....: If harddisk SH204 is connected, the virus 
                         causes an address error and will not be 
                         installed.
Similarities........: The same installation routine as MAD virus; only 
                         different damage action and damage trigger. 
----------------------------------------------------------------------
Countermeasures.....: Make sure that virus is not in memory; modify
                         last byte in bootsector to another value.
Standard means......: Clear all bytes in bootsector beginning at
                         offset 30 (decimal).
-----------------------Acknowledgements-------------------------------
Location............: Virus Test Center, University of Hamburg FRG
Classification by...: Thomas Piehl
Documentation by....: George R. Woodside
Date................: 31-January-1991
===================== End of FREEZE Virus ============================
 
=== Computer Virus Catalog 1.2: "Gauweiler" Virus (31-January-1991) ==
Entry...............: "Gauweiler" Virus  
Alias(es)...........: ---
Virus Strain........: ---
Virus detected when.: November 1990 (?origin) 
              where.: Kassel, FRG   (?)
                      (when/from where VTC received the sirus code)
Classification......: Bootsector virus
Length of Virus.....: 510 Bytes
--------------------- Preconditions ----------------------------------
Operating System(s).: Atari-TOS
Version/Release.....: 1.0, 1.2 ,1.4
Computer model(s)...: All types of the Atari ST series
--------------------- Attributes -------------------------------------
Identification......: At the end of the boot sector, following text 
                         "AIDS" and "Gauweilers Rache V 3.0 4.7.88"; 
                         at the begin of bootsector:  $52F6498A (hex).
                      Remark: Dr. Gauweiler is a Bavarian politician
                         well known for his resentments against people
                         seeking asylum in Bavaria.
Type of infection...: Infects bootsector of the disk A, if it is 
                         regarded to be uninfected,  or if  an old 
                         version of this virus is on bootsector (V2.0).
Infection Trigger...: Check if bootsector is executable.
Media affected......: Infection of disk in drive A.
Interrupts hooked...: BIOS-trap used and changed by this virus.
Damage..............: Infects the bootsector of the disk, if it is 
                         regarded to be uninfected; clears first 
                         9 sectors of track 0 with the FAT.
Damage Trigger......: If counter at start of virus + 6 modulo 32=0;
                         value depends on number of infections.
Particularities.....: ---
Similarities........: ---
--------------------- Agents -----------------------------------------
Countermeasures.....: Programs that calculate bootsector's checksum 
                         and modify it, if = $1234. Then, the sector  
                         is regarded as not executable. The suspected  
                         more dangerous second part of the virus might 
                         not be recognized because it does not need
                         to have the correct checksum.
Countermeasures successful: ---
Standard means......: Write-protect the disk; write an easily 
                         identifiable bootsector; "manually" change 
                         the checksum to a value other than $1234.
--------------------- Acknowledgement --------------------------------
Location............: Virus Test Center, University Hamburg, FRG
Classification by...: Ralf Stegen
Documentation by....: Ralf Stegen 
Date................: 31-January-1991
Information Source..: ---
===================== End of "Gauweiler" Virus =======================
 
======================================================================= 
== The Computer Virus Catalog may be copied free of charges provided ==
== that the source is properly mentioned at any time and location    ==
== of reference.                                                     ==
==                                                                   ==
==  Editor:   Virus Test Center, Faculty for Informatics             ==
==            University of Hamburg                                  ==
==            Schlueterstr. 70,  D2000 Hamburg 13, FR Germany        ==
==            Prof. Dr. Klaus Brunnstein, Simone Fischer-Huebner     ==
==            Tel: (040) 4123-4158 (KB), -4175 (SFH), -4162(Secr.)   ==
==  Email (EAN/BITNET): Brunnstein@RZ.Informatik.Uni-Hamburg.dbp.de  ==
======================================================================= 
==  Critical and constructive comments as well as additions are      ==
==  appreciated. Especially, descriptions of recently detected viruses=
==  will be of general interest. To receive the Virus Catalog Format,== 
==  please contact the above address.                                ==
=======================================================================
 
=======================================================================
==                  End of ATARIVIR.291 document                     ==
==                     (158 Lines, 10k Bytes)                        ==
=======================================================================
</pre>