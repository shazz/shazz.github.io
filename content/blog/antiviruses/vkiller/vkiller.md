Title: Vkiller
Slug: vkiller
Name: Vkiller
Date: 2025-10-30 18:10
Location: Russia
Category: Atari ST, Antivirus
Lang: en
Author: draedon
status: hidden
summary: This article is about Vkiller...
image: {filename}../../../gallery/antiviruses/vkiller.png
Tags: Antivirus

## Basic Information
* *Version*: 3.84
* *Author*: George R. Woodside
* *Language*: English
* *Release Date*: April 1991
* *Recognizes*: 35 bootsectors

![photo]({attach}vkiller_photo_0.png)

### Recognized Viruses:

* **Boot Viruses**: 5th Generation, ACA, Batman, batvir2?, BHP, BLOT, Flying Chimp, CHOPIN, COOKIE, Freeze, GILLUS, Green Goblin, Signum/BPL, Kobold #2, Label, MAD, Maulwurf I, MEDIACH, Ghost, Evil Nick, OLI, P.M.S, PLANTIAC, PLANTIAC 2, Screen, TOI, UPSIDEDOWN
* **File Viruses**: None
* **Others**: 8 others bootsectors

## Tasks

### Task 1: Recognize boot viruses not loaded into memory

#### Instructions:

To test a floppy disk with Vkiller, follow these steps:

* Insert the test floppy into drive A:
* Click on the floppy disk image labeled Drive A below

![photo]({attach}vkiller_photo_1.png)

* Then the boot sector details and the analysis result will appear

| Virus<p>Difficulty                      | Analysis                                               | Result                                                                         |
|:---------------------------------------:|:------------------------------------------------------:|:------------------------------------------------------------------------------:|
| [Ghost](/ghost-en.html)<p>(1/5)         | <img src="{attach}vkiller_photo_2.png" width="60%"/>   | Vkiller correctly recognized the Ghost virus                                   |
| [Signum BPL](/signum-en.html)<p>(1/5)   | <img src="{attach}vkiller_photo_3.png" width="60%"/>   | Vkiller correctly recognized the Signum BPL virus                              |
| [Macumba 3.3](/macumba3-en.html)<p>(4/5)| <img src="{attach}vkiller_photo_4.png" width="60%"/>   | Vkiller said this is a very suspicious boot sector                             |
| [Carpe Diem](/carpediem-en.html)<p>(2/5)| <img src="{attach}vkiller_photo_5.png" width="60%"/>   | Vkiller said this is a very suspicious boot sector.                            |
| [OLI](/oli-en.html)<p>(1/5)             | <img src="{attach}vkiller_photo_6.png" width="60%"/>   | Vkiller correctly recognized the OLI virus                                     |
| [OLI2](/oli2-en.html)<p>(1/5)           | <img src="{attach}vkiller_photo_7.png" width="60%"/>   | Vkiller said this is a very suspicious boot sector                             |
| [EICAR](/eicar-en.html)<p>(3/5)         | <img src="{attach}vkiller_photo_8.png" width="60%"/>   | Vkiller said this is a safe disk                                               |

### Task 2: Recognize boot viruses loaded into memory

#### Instructions

* Boot from the infected floppy disk in drive A:
* Change the disk to the Vkiller disk
* Enter Vkiller

It will not check if vectors are infected and doesn't check memory very well, only reads information from the diskette...

#### One of the most common viruses: Ghost

Test results: Vkiller correctly recognized the Ghost virus in the boot sector

#### Key virus and its key disk: Signum BPL

Test results:

Vkiller correctly recognized the Signum BPL virus in the boot sector

#### Polymorphic virus: Macumba 3.3

Test results: Vkiller did not recognize the Macumba 3.3 virus in the boot sector

#### Trojan virus: Carpe Diem

Test results: Vkiller did not recognize Carpe Diem in the boot sector.

#### Stealth virus: OLI

Test results: Vkiller recognized the OLI virus when it was loaded into memory!

#### Super Stealth virus: OLI2

Test results: Vkiller did not recognize but detected the OLI2 virus when it was loaded into memory!

#### Non-executable boot sector: EICAR

Test results: Vkiller said this is a safe disk.

### Task 3: Recognize a file virus

Vkiller cannot scan files for viruses

### Task 4: Restore a damaged boot sector

Vkiller cannot restore a saved boot sector but can restore the BPB... I won't give a point for this :).

### Task 5: Vaccinate a non-executable floppy disk

#### Instructions

* Insert the test floppy into drive A:
* Click on the floppy disk image labeled Drive A below
* Click on the Guard
* Select Display or Monitor guard

Now when booting from this disk you will see this:

![photo]({attach}vkiller_photo_9.png)

The vaccine helped me and when the virus tried to get onto the disk, the vaccine beeped and the screen blinked! The virus still won and overwrote the boot sector... But it miscalculated and I already know that there's a virus on the disk because the vaccine warned me about it.

### Task 6: Analyze a suspicious boot sector

#### Instructions

* Insert the test floppy into drive A:
* Click on the floppy disk image labeled Drive A below

Vkiller checks:

* Disk BPB
* Checksum
* Vkiller does not check vectors
* Vkiller Vkiller does not check Magic Long Word ($12123456)
* Vkiller performs (small) heuristic disk analysis
* Vkiller shows us FAT sectors! A very cool antivirus!

### Task 7: Detect malware when Vkiller is not running

Vkiller has a resident virus scanner and if a virus gets into your boot sector, Vkiller will immediately report it and offer to remove it.

## Summary and Conclusion

In the following table we have summarized the task completion results:

| Task                                                            | Result  |
|-----------------------------------------------------------------|:-------:|
| Recognize boot viruses not loaded into memory                   |   3/7   |
| Recognize boot viruses loaded into memory                       |   3/7   |
| Recognize a file virus                                          |   0/1   |
| Restore a damaged boot sector                                   |   0/1   |
| Vaccinate a non-executable floppy disk                          |   1/1   |
| Analyze a suspicious boot sector                                |   4/6   |
| Detect malware when Vkiller is not running                      |   2/2   |
| **Total**                                                       |  13/25  |

In conclusion, Vkiller is a good antivirus that detects many common viruses and also shows us FAT sectors. Vekiller detects a Bat virus that uses Magic LongWord, but it doesn't check for the presence of Magic LongWord. Strange!

## Appendix

### VKiller 3.84 database description

#### The E. Collingnon Anti Virus:

This is not a virus, but simply an executable boot sector. The program
in the boot sector is designed to search for known viruses in memory
at boot up time.
The program acts only when the ST is booted up or reset. It checks memory
for resident, executable code. It is able to recognize only a specific code
type, which is used by only one known virus. It displays a normal signon
message if no such pattern is found. If one is found, it offers to clear
memory and perform a system reset. Since the prompts are in French, the
possible responses are 'O' for 'Oui' (Yes) and 'N' for 'Non' (No).
This Anti Virus is not harmful, and does not spread itself to other disks.
It is created only by the program 'KILLER', by Emmanuel Collignon.

#### The 'Floppy Shop' Anti-Virus:

#### The 'Simeon Pashley' Anti - Virus:

This virus refers to itself as an 'anti-virus', but it spreads just as
fast as any other virus. It does not, however, destroy anything.
This anti virus is designed to provide a confirmation that the disk
contains no other virus.  The program acts only when the ST is booted up or
reset. It flashes the screen colors briefly to let you know that it is 
present, rather than a destructive virus. It has no other effect, and
represents no real threat to your system or disks. It does, however,
spread as rapidly as any real virus.

#### The 'Mark Powell' Anti Virus:

This is not a virus, but simply an executable boot sector. The program
in the boot sector is designed to provide a confirmation that the disk
contains no virus.
The program acts only when the ST is booted up or reset. It flashes the
screen colors briefly, and sounds a tone, to let you know that it is
present, rather than a destructive virus. It has no other effect, and
represents no threat to your system or disks. It does not spread
itself.

#### The 'Medway' Anti-Virus:

#### The 'ANTI' Virus:

This virus refers to itself as an 'anti-virus', but it spreads just as
fast as any other virus. It does not, however, destroy anything.
The anti-virus displays a signon message when the ST is booted up or
reset. Then, as the ST runs, it checks each disk for an executable boot
sector. When it finds one, it flashes the screen colors briefly, and
generates a warning tone. It has no other effect, but it will spread
itself as rapidly as any other virus.

#### The 'Le Fele' Anti Virus:

This virus refers to itself as an 'anti-virus', but it spreads just as
fast as any other virus. It does not, however, destroy anything.
It checks disk boot sectors to see if they match either of two known
patterns. The patterns tested for are so simple, however, that the
anti virus is more often wrong than right in identifying what is on
the disk. When it finds a recognized pattern, it will set the background
color red or purple. If it thinks it recognizes itself on the disk, it
changes the background to blue.

#### The Anti Virus Number 4:

This virus is an attempt to wipe out other viruses. It reproduces itself
onto every disk that is accessed, no matter what was there before.
It was apparently constructed by modifying a real virus, and contains
software errors that can result in hanging the system any time it tries
to reproduce itself.

#### The ACA Anti Virus:

This virus is an attempt to eliminate the very dangerous 'ACA' virus.
It reproduces itself onto every disk that is accessed, unless that disk
appears to have a copy of this anti-virus already. The test used is so
simple, however, that it is often wrong in identifying itself. It can
easily let another real virus pass by undetected, or spread itself onto
a disk which should be left intact.

#### The VKILLER Display Type Anti Virus

This is not a virus, but simply an executable boot sector. The program
in the boot sector is designed to provide a confirmation that the disk
contains no virus.
The program acts only when the ST is booted up or reset. It displays the
message 'Virus free disk', to let you know that it is present, rather than
a destructive virus. It has no other effect, and represents no threat to
your system or disks. It does not spread itself.

#### The VKILLER Monitor Type Anti Virus:

This is not a virus, but simply an executable boot sector. The program
in the boot sector is designed to warn you if a disk with an executable
boot sector is inserted in either drive.
This monitor displays a signon message when the ST is booted up or reset.
Then, as the ST runs, it checks each disk for an executable boot sector.
When it finds one, it flashes the screen colors briefly, and generates a
warning tone. It has no other effect, and does not spread itself.

#### The '5th Generation' Virus:

After five copies are made, it starts attacking. It attacks by
completely destroying the boot sector, File Access Tables, and
directories of every disk inserted into the ST. The destruction is
complete, leaving it almost impossible to recover anything from the
disk once the virus has struck.

#### The 'ACA' Virus:

After ten copies are made, it starts attacking. It attacks by
completely destroying the boot sector, File Access Tables, and
directories of every disk inserted into the ST. The destruction is
complete, leaving it almost impossible to recover anything from the
disk once the virus has struck.

#### The 'Batman' Virus:

This is an extremely devious virus. While it does alter the boot sector
to spread, it does not make the boot sector executable. It hides the rest
of itself in the end of the disk directory, making it very difficult to
detect.  This virus will destroy an executable boot sector, and may wipe
out portions of the disk directory.
An hour after the virus is installed, it starts flickering the screen
colors and changes the shape of the mouse pointer to the Batman symbol.
To eliminate this virus, the infected portion of the Disk Directory must
be erased. The virus has already destroyed any active entries that may
have been in that portion of the directory, so there will be no further
loss of data. There is no way to recover any entries which may have
already been destroyed by the virus.
This virus was launched in October, 1989, in France. As it spreads, it
updates an identifying counter (this one reads 12345678).

#### The 'batvir2' Virus:

####  The 'BHP' or 'Bayerische Hacker Post' Virus:

Not much is known about this virus. No complete copy of it is
available. It appears to do a thorough job of destroying disks when it
attacks. If you have detected the presence of this virus, please
preserve the disk, and contact the author of this program, at the
address in the 'About' dialog box.

#### The 'BLOT', 'SWISS', or 'FAT' Virus:

This virus will only infect systems with a ROM date of 2/06/1986. This
system's ROMS are dated mm/dd/yyyy. This virus is too big to fit into the
boot sector. It hides the rest of itself in the last FAT sector on an
infected disk. It uses time delays to make itself more difficult to
detect. When it becomes active, it does randomly timed accesses to either
the screen memory, or memory above the screen address. That will either
cause blots to appear on the screen, or (if the system has 4 megabytes of
memory) memory access errors (two bombs). It looks like an ST that
develops memory errors after it has been running for a while.

#### The 'Flying Chimp' Virus:

This virus attacks only by posting a message, and causing a delay.
Every five times it reproduces, or 20 times a disk boot sector is
accessed, the virus strikes. It posts a message on the screen reading
```
'Zapped by Waldo the Flying Chimp!'
```

#### The 'CHOPIN' Virus:

After making 26 copies of itself, it attacks by playing Chopin's
Funeral Dirge, and printing the message 'FUCK! YOU'VE GOT A VIRUS!'
on the screen. It keeps the system in a loop, repeating the music and
message indefinitely.

#### The 'COOKIE' Virus:

After making 30 copies of itself, and after every 20 subsequent copies,
it attacks. It clears the screen and displays the following message:
'YOU KNOW WHAT? I WANT A COOKIE!', then waits for input. You must type
the word 'cookie' to exit the virus attack. Twenty disks later, it repeats
the same thing.

#### The 'Freeze' Virus:

The virus attacks by setting up a timer routine. Each time it elapses,
the virus makes a random decision to see if it should act. It acts by
freezing the system briefly. Each time it acts it makes the duration of
the freeze a little longer. This virus does not directly destroy disks
or files, but will continue to cause longer and longer delays to
whatever program is executing.

#### The 'GILLUS' Anti Virus:

This virus refers to itself as an 'anti-virus', but it spreads just as
fast as any other virus. It does not, however, destroy anything.
The anti-virus displays a signon message when the ST is booted up or
reset. It runs a rainbow background on color systems, or a somewhat
rippling effect on monochrome systems. It has no other effect, but it
will spread itself as rapidly as any other virus.

#### The 'Green Goblin' Virus:

Every sixteen times the boot sector of a disk is read, the virus
inverts a small portion of the screen. Every 128 times a boot sector is
read, the virus displays this message:
```
'The Little Green Goblins Strike Again'.
```

#### The 'KEY', 'Signum/BPL', or 'Type 1' Virus:

It is waiting for a special disk to come along with a 'KEY' value in
that boot sector. When it finds one, it will execute the code on that
'KEY' disk immediately. This disk does not have the 'KEY' value, so it
is not an immediate threat. However, this virus will reproduce itself
onto every disk used in your system. Then, when the 'KEY' disk comes
along, you will be a victim of whatever it instructs your system to do.
KEY Disk for the 'KEY' Virus:
 
This disk contains the key value for a virus, and represents a very
real danger. It works in conjunction with the 'KEY' virus. It is not
known what this disk contains. Before you destroy it, send a copy of it
to the author of this program (use the address on the 'About' box). The
general version of the 'KEY' virus waits for another disk, with a key
value, to come along. This disk has that key value, so it can cause
very real damage. It is important that you send a copy of this disk to
the author of this program.

#### The 'Kobold II' Virus:
 
This is the most complex ST virus detected to date. It takes over so
many system vectors and functions that it is not yet fully understood.
It is extremely sophisticated, however, and quite dangerous. It is
reported to have wiped out entire libraries of disks when it has
struck.

#### The 'Label' Virus:

After ten copies are made, it strikes by periodically wiping the screen
completely black. This virus will only infect systems with a ROM date of
04/22/1987. This system has a ROM date of mm/dd/yyyy.

#### The 'MAD' Virus:

After five copies are made, it starts attacking. When it acts, it
randomly selects one of eight different routines. Seven of them are
screen display sabotage routines, while the eighth is a sound effect.
This virus does not destroy disks or files, but will destroy screen
displays and cause delays to whatever is executing.

#### The 'Maulwurf I' Virus:

The virus acts by using a system timer. It sets the timer to a random
value, attacks when the timer elapses, then resets the timer to another
random value. When the virus it attacks, it displays the message

```
'Maulwurf I - SSG (Subversive Software Group )'
```

#### The 'MEDIACH' Virus:

The virus is named for the disk vector it steals, which is used to detect
disk (media) changes. It attacks after 5 different disks have been seen.
It generates a single audio tone, and changes the screen foreground and
background colors.

#### The 'Mouse Inversion' or 'Ghost' Virus:

After five copies are made, it starts attacking. Every five times the
boot sector of either floppy disk is accessed, the virus reverses the
vertical orientation of the mouse.

#### The 'Old Nick' or 'Evil' Virus:

The virus acts by counting accesses to either floppy disk. After 100
disk accesses, it starts reversing the screen colors on each subsequent
disk access.

#### The 'OLI' Virus:

The virus attacks as soon as it is installed, but is very subtle. It
introduces delays of increasing duration to all disk I/O activity. When
it is active in a system, it is extremely difficult to detect, because
it masks it own presence anytime an infected disk boot sector is read.

#### The 'Pirate Trap' or 'P.M.S.' Virus:

It runs a counter from some starting value, down to zero. Each time it
copies itself, the copy's counter gets a lower starting value. When the
counter gets to zero, the virus starts displaying this message:
```
*** The Pirate Trap ***
* Youre being watched *
*** [C] P.M.S. 1987 ***
```

#### The 'PLANTIAC' Virus Number 1:

The virus attacks after it has spread 5 times. It acts by executing a
delete of every file on the disk. Imbedded in the virus is this message:
```
Plantiac puke virus! Please contact Stefan Posthuma, Negende Donk 4,
NL-5233 PJ Den Bosch, HOLLAND
```

#### The 'PLANTIAC' Virus Number 2:

The virus attacks after it has spread 5 times. It acts by wiping out the
first part of the disk, thus destroying every file and folder. The virus
also intercepts disk reads, and conceals itself from other programs, making
it extremely difficult to detect. Imbedded in the virus is this message:
```
This is Plantiac puke: Please contact Stefan Posthuma, Negende Donk 4,
NL-5233 PJ Den Bosch, HOLLAND
```

#### The 'GRIM REAPER' Virus:

This virus attacks after making 48 copies of itself. When it attacks, it
turns the screen image upside down, completely wipes out the directory of
the disk in drive A, then erases itself from memory. This message, while
not displayed, is imbedded in the virus:
```  
  -= The Jumper strikes again =-  
Pirates, the grim reaper draws near
```

#### The 'Screen' Virus:

This virus executes only on ST's with ROMs dated 02/06/1986. This system
has ROMs dated mm/dd/yyyy. The virus works by installing a timer routine.
After 30 minutes, it starts attacking. Each time after that when the
timer elapses, the virus steps on two words in the screen. It keeps
changing which screen words it will step on. This virus does not directly
attack files or disks.

#### The 'TOI' variant of the 'Mouse Inversion' or 'Ghost' Virus:

After five copies are made, it starts attacking. Every five times the
boot sector of either floppy disk is accessed, the virus attacks. It
may reverse the vertical orientation of the mouse, like the Mouse
Inversion virus from which it was derived. It may also randomly alter
the contents of a system vector, causing unpredictable results.
 
Reported to be the work of the 'TOI' programming group, from Denver,
Colorado, USA.

#### The 'UPSIDEDOWN' Virus:

This virus attacks after it makes five copies of itself, and every two
copies thereafter. It turns the screen display upside down

