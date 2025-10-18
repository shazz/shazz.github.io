Title: LABOR - ATARI ST Viruses
Slug: ataristviren
Name: LABOR - Zeitschrift für World Processing - Issue 2
Date: 1989-03-01 12:34
Location: Germany
Category: Atari ST, Virus
Lang: en
Author: Unknown
status: published
summary: Translated German article on Atari ST Viruses from LABOR - Zeitschrift für World Processing, 2nd issue
image: {filename}../images/chaos.png
Tags: archives


Here’s a full English translation of the German article titled **“ATARI ST-VIREN”** from LABOR - LABOR - Zeitschrift für World Processing, 2nd issue, which catalogs various viruses and trojans affecting the Atari ST system. The original sources include contributions from VEC Project (University of Hamburg), ZerberusNetz, and SkyLink Mailbox.

---

**ACA (also: Boot Sector Virus #04):**  
Created by the Swedish ACA crew. Deletes the entire first track of a floppy disk, including the FAT and boot sector, rendering the disk unusable. [[3]](#3)

**ALADIN Virus:**  
The Apple logo in the menu bar turns into an Atari bomb, and the message “Frankie says: No more Software piracy” appears. Then it jumps back to GEM. Occasionally, instead of the message, it causes serious crashes. [[2]](#2)

**Boot Sector Virus #03:**  
A weaponized boot virus from *c’t* magazine (issue 7/88). Copies itself to all newly inserted disks (A:, B:) that don’t have an executable boot sector. Eventually displays the message “ARRRGGGHHH Diskvirus has struck again” on screen. Due to a bug, it can also destroy the configuration sector of a hard disk (!). Resistant to reset. [[3]](#3)

**Boot Sector Virus #05:**  
Discovered by a buyer of the AntiVirusKit. Copies itself to almost all inserted disks A:/B:, maintains a generation counter, but surprisingly does nothing else. [[3]](#3)

**Boot Sector Virus #06:**  
Sent from Düsseldorf. Copies itself to all disks in drive A:, highly reset-resistant (AutoReset and new reset routine). When a counter reaches 5, it manipulates the keyboard processor (mouse movement becomes vertically inverted). [[3]](#3)

**Boot Sector Virus #07:**  
Sent from Münsterland. Appears to be a “test version,” as the word “VIRUS” is visible in the boot sector. Activates only after a reset. Uniquely, it loads an additional sector whose number is encrypted in the boot sector. Since only the first part is known, its full behavior is unclear. A relief for Blitter-TOS users: the virus is ineffective under this OS version. [[3]](#3)

**Boot Sector Virus #08:**  
Encountered at the Atari Show in September 1988. Doesn’t spread automatically, so technically it’s a Trojan horse. During booting, the screen fills with familiar bomb icons. Since this reaction is unlikely to be seen as helpful by users, it’s included in this list. We're running out of names... [[3]](#3)

**CAMPUS:**  
Extreme caution is advised with certain copies of CAMPUS CAD 1.3. Contains a link virus that has caused major issues for at least seven users, especially targeting boot sectors of hard drives and disks. [[7]](#7)

**EMIL 1A:**  
Infects the boot sector. According to B. Koehler (VEC), it can be identified by the first word in the boot sector – $6038. Other boot sector programs with this word won’t be overwritten, as the virus considers them already infected. However, $6038 also appears in non-infected sectors. After infection, it searches for a matching key on the disk’s bootsector (first long word = $60381092). If the key matches, it loads the sector and executes the damage code, regardless of checksum. EMIL 1A can be countered by programs that detect executable boot sectors via checksum and deactivate them by altering the sum. Since the damage code doesn’t need to be marked as executable, the virus may go undetected. Standard remedy: deactivate the boot sector and replace it with a clean one. [[1]](#1)

**EMIL 2A (also: MAD or Boot Sector Virus #2):**  
Infects the boot sector. Checks for $60 in the first byte to see if an executable program is present. Copies itself to the boot sector of every uninfected disk A:/B:, incrementing a variable. Initially harmless [used to be harmless – when it was called MADLIB.ACC and could be clicked to annoy users]. After five infections, it begins (randomly) shifting, inverting, flipping the screen, and emitting beeps. A “demo virus” that a skilled programmer could easily weaponize. Remedy: reset and reboot with a clean disk, then disinfect the boot sector using an antivirus program. [[1]](#1)[[3]](#3)

**FREEZE:**  
Causes system crash. Formats with 11 sectors. [[3]](#3)

**LARRY:**  
Trojan horse. Destroys the FAT when a score of 222 is reached.

**Link Virus #03:**  
Sent from Switzerland. Can attach to all *.PRG, *.TOS, *.TTP, *.APP files, in the current version only in the active drive, but in all folders. Full range of action not yet analyzed (doesn’t look good). [[3]](#3)

**MILZBRAND:**  
Link virus (from *c’t* 4/87). Copies itself into all *.PRG files larger than 10,000 bytes. When the ST calendar hits the year 1987, it deletes the FAT of the current drive and displays a small virus image on screen. Since the virus was published as source code and explained in detail, it can be easily modified. [[3]](#3)

**MOUSER:**  
Boot sector virus. After ten successful infections, it swaps the screen origin, causing mouse movements to be reversed. After each further infection, it toggles again, confusing the user until all disks are infected. Appears to be a test for a malicious virus. It’s cleverly and compactly programmed, reset-resistant using a little-known method. Installs itself twice and hooks into the `hdv_bpb` call like most boot sector viruses. [[6]](#6)

**SCREEN Virus:**  
Self-modifying; only affects German TOS. [3]](#3)

**SIGNUM Virus (also: SLEEPER or Boot Sector Virus #01):**  
One of the first discovered viruses on the Atari ST. Copies itself to all newly inserted disks A:/B:. Can start certain boot sectors without booting them; however, these boot sectors haven’t yet appeared. [[3]](#3)[[5]](#5)

**VICOSE:**  
Link virus created with the Virus Construction Set. Can copy itself into all *.PRG, *.TOS, *.TTP files, possibly across all drives from A: to P:. No further details on its actions, as they can be customized. [[3]](#3)

Sources:

- <a name="1">[1]</a> VEC Project, University of Hamburg; edited by Bert Koehler, November 27, 1988
- <a name="2">[2]</a> Zerberus Network (/Z-NETZ/VIRUSES) by JOECOOL, January 12, 1989
- <a name="3">[3]</a> From: SkyLink Mailbox, scouted by: THE FRONTIER, February 1989
- <a name="4">[4]</a> LABOR E.B., RAINER ZUFALL, POETRONIC
- <a name="5">[5]</a> Zerberus Network, BANANACO.@ABC.ZER, STEFAN@UMS
- <a name="6">[6]</a> Zerberus Network (/Z-NETZ/VIRUSES), BANANACO.@ABC.ZER, January 9, 1989
- <a name="7">[7]</a> Zerberus Network (/Z-NETZ/VIRUSES) by GHOSTWRITER@IUS.ZER, February 19, 1989

---

Those virus names map to:

| Article Virus name                               | Museum Virus Name | Confidence | Virus Type |
|--------------------------------------------------|-------------------|------------|------------|
| ACA / Boot Sector Virus #04                      | ACA               | high       | Bootsector |
| ALADIN Virus                                     | Aladin            | high       | Mac        |
| Boot Sector Virus #03                            | CT                | high       | Bootsector |
| Boot Sector Virus #05                            | Counter           | medium     | Bootsector |
| Boot Sector Virus #06                            | Master or ACIA ?  | low        | Bootsector |
| Boot Sector Virus #07                            | Swiss             | medium     | Bootsector |
| Boot Sector Virus #08                            | Help              | low        | Bootsector |
| CAMPUS                                           | ?                 |            | Link       |
| EMIL 1A                                          | Signum BPL        | high       | Bootsector |
| EMIL 2A / MAD / Boot Sector Virus #02            | Mad               | high       | Bootsector |
| FREEZE                                           | Freeze            |            | Bootsector |
| LARRY                                            | ?                 |            | Trojan     |
| Link Virus #03                                   | ?                 |            | Link       |
| MILZBRAND                                        | Milzbrand         |            | Link       |
| MOUSER                                           | Ghost             | high       | Bootsector |
| SCREEN                                           | Screen            | medum      | Bootsector |
| SIGNUM Virus / SLEEPER / Boot Sector Virus #01   | Signum BPL        | high       | Bootsector |
| VICOSE                                           | Vicose            | high       | Link       |


Original article: [VIRATARI.TXT]({attach}../../pages/txt/VIRATARI.TXT)


