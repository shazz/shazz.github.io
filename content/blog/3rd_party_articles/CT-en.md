Title: The Viruses Are Coming  
Slug: thevirusesarecoming 
Name: The Viruses Are Coming 
Date: 1987-04-01 12:34
Location: Germany
Category: Atari ST, Virus
Lang: en
Author: Eckhard Krabel
status: published
summary: C'T article on link viruses
image: {filename}../images/ct-0788-2pages.png
Tags: archives

> *Note: this article from C'T was translated using Google Translate and edited by myself. You can find the original issue of C'T on the [Internet Archive](https://archive.org/details/ct-1987.01/C%27t%20-%201987.04/page/108/mode/2up) or ask me, I have a scanned copy.*

<img src="{attach}../images/ct_virus1.png" width="70%"/>

## Computer viruses and defenses

**Eckhard Krabel**

So far, computer viruses have only caused sleepless nights for system operators and programmers of mainframe computers. Recently, viruses have also been available for personal computers. We'll show you how they work and how to fight against them. .

> 'January 1987. Finally, after waiting four weeks for the new Super Lechz program, I turn on my computer to drag a copy onto the hard disk. Shortly after the copy program, which I received as a gift from a hacker friend, has started, all the drives suddenly go crazy, and immediately afterwards strange images appear on the screen... ?'

This is how the first encounter with a computer virus could have went. It should be added that of course all files on the floppy disks and the hard disk are irreparably destroyed. Only absolute professionals are able to recognize the root of the evil, a computer virus, with the help of various monitor and debug programs. They can only eliminate it in individual cases. The average user is faced with almost unsolvable problems. The contaminated floppy disks are practically unusable, the contents of the hard drive are lost.

However, if you take protective measures in good time, you can be reasonably sure that you will not lose your entire program stock in the event of an infection with computer viruses. However, in order to develop effective strategies against the viruses, the function of a virus program must first be clarified.

## Historic

The first computer viruses emerged in the mainframe sector. There, system programmers once designed programs that copied themselves into the area of other colleagues in order to manipulate, copy or even delete data there, depending on the author's intention. Later, hackers, mostly from the American college scene, took up this idea and wrote programs that spread over all areas of the mainframe and then paralyzed it108. More detailed studies on viruses on mainframe computers also date from this time.

Little is known about computer viruses based on PCs or home computers. Unlike mainframes, it is not possible to unleash the virus on other users in the system. Who invests a lot of work in a program that then only annoys the programmer himself? One conceivable way in which PC viruses can also spread is through program exchange among hackers.

## Virus Technical

However, before the programmer can release his virus into the wide world with a 'clear conscience', he must provide it with properties that make it easier for him to survive there:First of all, the program must be able to reproduce itself. In addition, it must be small and not be recognisable by excessively long floppy disk accesses. Also, the length of a program must not change as a result of the 'infection' with the virus. Finally, he should be able to query a certain criterion - the date for example - and then, if this characteristic is present, start a 'killer routine'. Depending on the programmer's moral condition, this routine can output a simple message on the screen or format the floppy disks. The term 'formatting' does not apply exactly. To ensure that the shocked virus victim is not given the opportunity to tear the floppy disk out of the drive in a fit of last revolt, the destruction must take place within seconds. Formatting would be much too slow. Of course, hardened 'computer gangsters' will not forget a possible hard drive when deleting it.

First of all, it should be said that the virus presented here does not meet all these requirements. For example, the program length of the 'contaminated' program changes. This is to prevent unscrupulous 'journal programmers' from getting their hands on a tool with which they can only harm themselves and others. However, if you still want to know more precisely how such a 'pure' virus works in detail, out of purely personal interest, you will also find hints on this.

## Playing with fire

Naturally, the topic of software viruses heats up tempers. Those who can program viruses are only deterred by their own moral sensibility from harming their often helpless fellow human beings. That's why an article like this one is bound to get caught in the crossfire of criticism. 'Do you have to poke these hackers with your nose?' - Certainly not, but the editors are of the opinion that it is of no use to anyone if explosive topics are simply hushed up. Only those who know what the danger looks like can protect themselves from it. If, on the other hand, only a handful of insiders deal with the topic and otherwise only rumors circulate, the damage done will be greater in the end. This article proves that the development of virus programs cannot be avoided. The virus printed here is certainly not the first for the Atari, at most the idea of an anti-virus is new. No one is helpless in the face of viruses. Anyone who obtains the software through 'official' channels and provides their floppy disks with write protection does not need to fear the virus fiasco.

## With brains

In order to be able to unleash a virus on programs, you have to know how they are structured. The first 28 bytes of a program on floppy disk are taken up by the so-called header. In the header there are pointers to the different program segments. Each of these pointers is four bytes long. For example, from the third byte onwards, the pointer 'Textlen' is used. 'Textlen' contains the length of the executable program code. After the pointer 'Textlen' is the length of the predefined data area in 'Datalen' from the seventh position. This is followed by the length of the Bss segment, represented by 'Bsslen'. Behind this pointer you will find 'Commentlen'.

The header is followed by the text segment. Here is the machine code of the actual program. The text area is followed by the data segment with the initialized variables (or constants), which must have a certain initial value at the start of the program.

The Bss segment, the memory area for all uninitialized variables, is not explicitly displayed on floppy disk. This would also be a pure waste of storage space, since the initial values of this storage area are insignificant anyway. It is only represented by the BSS pointer in the header and then taken into account in the program's memory reservation.

The data sector is therefore immediately followed by the commentary table. This is where information is stored for debuggers (i.e. utilities that facilitate troubleshooting), which enables the creation of a reasonably documented (i.e. commented) disas sembler listing.

Actually, if you add the three pointers (Textlen, Datalen, Commentlen) with the header length (28 bytes), exactly the program length should come out. The fact that this is not the case is due to the TOS. This modern operating system must be able to run the programs anywhere in the memory. So the programs have to be stored relocatibly. This is solved by specifying all absolute addresses relative to the program start. After loading, the current start address is then added to each of these offset addresses. This means that the program can be run at any point in the memory. So that the operating system now knows where offset addresses are, the positions of these offsets are noted in the loader table. This table is at the very end of each program, where it is deleted after loading and adjusting the absolute addresses.

## Milzbrand

I have called the virus presented here for the Atari ST spleen brand. Once started, it first checks the current date. If the year 1987 has already begun, a subroutine is branched off, which irreparably destroys the files on the floppy disks in both drives. In any case, it was not possible for me to restore two floppy disks that had been destroyed in the development phase.

<center><img src="{attach}../images/ct_virus2.png" width="40%"/></center>
<center><b>Milzbrand has struck.</b></center>

The subroutine uses the TOS property to store the directory and FAT (File Allocation Table) in the first sectors on the floppy disk. These are simply overwritten. That should be enough. After all, the work of correctly restoring a floppy disk without FAT and directory is roughly equivalent to putting together a 1,5000-piece grass-and-meadow puzzle covering the living room floor.

If the year criterion is not met, Milzbrand searches the current floppy disk directory for files that contain the extension '. PRG'. If he finds anything of the kind, the file is checked for its length. This is because with small program files, a virus is much more likely to be detected by the length of the program than with large Milzbrand has struck. Files. If the length of the found program is less than 10000 bytes, it is simply ignored and the next file is searched.

If the program is long enough, a few check bytes are used to check whether the file is already 'infected'. Because it makes no sense to 'treat' a program more than once, even if it is theoretically possible. In attempts, I have contaminated a file 16 times. The infection rate then increases exponentially. The program file it finds is now opened, and the virus replaces the first program bytes with a jump command to its later copy, which it then attaches to the program.

In order for the virus to function and go unnoticed when it is invoked from any infected program, the old program must be 'restored' after the virus has done its nefarious job. Therefore, the start bytes replaced by the jump command are temporarily stored in the virus.

## Get to the loader table

However, such an infected program would only work under certain circumstances. It becomes problematic for the virus as soon as an absolute address appears in the first bytes of the program to be infected. Then, after loading, the jump command into the virus is destroyed by adding the start address. At the latest after a restoration of the original program header, the absolute address differs by the missing addition of the start address. In both cases, the program crashes. So the loader table must also be manipulated. It is at the end of the program after the BSS segment.

<center>
<img src="{attach}../images/ct_virus3.png" width="60%"/><br/>
<img src="{attach}../images/ct_virus4.png" width="60%"/>
</center>
<center><b>The length of a program affected by Milzbrand changes</b></center>

The loader table starts with the distance of the first absolute address to the program start. For the following absolute addresses, the distance to the previous one is indicated. Suppose there are absolute addresses in the machine program at positions 2, 10 and 18. Then the corresponding loader table looks like this: 2, 8, 8. Only the length of the 'attached' jump command is added up.

Now add the length of the virus program to the 'Data-len' pointer in the header, which is written after the data segment and before the comment and loader table. In this case, both tables are shifted back in their position by the length of the virus. Therefore, the commentlen pointer must also be corrected. The commentary table itself remains 'untouched'. With the closing of the file, the evil work is over.

The work of Milzbrand is completed by restoring the program file that calls it. To do this, the corresponding start bytes are copied back and any absolute addresses are corrected again. At the end there is the jump to the beginning of the program - and no one has noticed.

But real computer viruses, unlike Milzbrand, do not reveal themselves by changing the length of the program. The mode of operation of such a virus is shown in the figure.

<center><img src="{attach}../images/ct_virus5.png" width="60%"/></center>
<center><b>This virus does not change the program length, but copies the data section to another location</b></center>

The operating system reads only the bytes of a file from floppy disks that are within the file length specified in the directory. The loader table must be at the end of this area so that the loading process can be completed properly. A virus that does not want to change the program length entry must therefore hide those program parts anywhere on the floppy disk that are of no significance for the relocation. Actually, only the data segment comes into question for this. The virus then settles in the freed area. After loading the program, it works just like Milzbrand, except that it naturally reloads the data segment during restoration.

The next increase is RAM-resident viruses. This virus species is hidden in the 'Auto folder' or as an 'ACC' file on floppy disk and copies itself to RAM. There, the virus latches onto the cyclical processes of the operating system via bent exception pointers (see c't ll/ 86, page 144 and c't 1/87, page 136 - 'The operating system of the Atari ST'). Every time a floppy disk is changed or any floppy disk access is made, Milzbrand II spreads further. In view of these possibilities, the computer must therefore be switched off after a virus is discovered. A normal reset is not enough.


## Retaliatory action

But how can we protect ourselves from computer viruses, the exact structure of which we know nothing? Most of the time, the virus is only discovered when it has completed its destructive work. By then, however, it will be too late.

As an elementary protective measure, you should avoid unnecessary copying of programs on your own floppy disks. However, this is of little help against RAM-resident viruses. Uploading new programs to a 'quarantine disk' is also ineffective with this type of virus. In the case of 'normal' computer viruses, this at least helps to reduce the speed of spread.

Reliable information about the 'state of health' of a programme is provided by a checksum, which must be calculated at a time when no virus has yet struck with certainty. This sum is then compared each time the program is called. If the program has been contaminated by a virus in the meantime, there is a checksum difference that reveals the virus. A corresponding program for the Atari ST will be explained in more detail later.

Another checksum protection method is a program that writes the entire checksums of all files on the floppy disk to a file. This program is then called from time to time (but at the latest after infection by a virus) and outputs all programs that have been infected in the meantime. Thus, from floppy disks on which individual programs are already contaminated, at least the uncontaminated programs can be saved. However, care must be taken to ensure that the name of the checksum file is always chosen differently. This means that computer viruses cannot adjust to a file name in order to manipulate this file in their interest - i.e. checksum correction


## Penicillin versus Milzbrand

The antivirus, appropriately called penicillin, works in part according to a similar scheme to Milzbrand. Penicillin is designed as a TTP' application (TOS Takes Parameter). When the antivirus is invoked, the file name of the program to be protected must be specified. As a matter of principle, penicillin should only be used for backup copies, as according to Murphy it is not compatible with the most important program.

After the obligatory test to determine whether this file exists at all, check bytes are used to check whether this file is already protected. According to the motto 'Many antiviruses spoil the program', the user only receives a lapidary error message on the screen in this case. On the other hand, it does not check whether the file mentioned is a program. So everyone is free to protect their GEM Draw graphics as well, but this will destroy the images.

For files that are still unprotected, the antivirus proceeds in a similar way to its antagonist. The first program bytes are exchanged by a jump command to the later copy of the antivirus. The handling of the header and the loader table is carried out according to the same principle as for Milzbrand. The routines for restoring the calling program are also essentially identical to those of the virus. They will there fore not be discussed further here.

In the antivirus, a subprogram is called that forms a checksum of the selected program file. The distance between the bytes that go into the checksum is 512 bytes. So every 512th byte of the program to be protected is added, which together results in the checksum.

## Keep your distance

The spacing of 512 bytes is freely chosen, but must be reconsidered as most viruses are likely to be longer than 512 bytes for everything they have to do, but there is still the possibility that the program will only be infected with a short loading routine that only reloads the actual virus later. For example, a checksum determined with a step size of 512 bytes would not reveal the virus with certainty. Everyone should enter an individual step size when programming an antivirus. This also has the advantage that computer viruses cannot 'shoot' themselves to a step size and then manipulate the checksum themselves.

However, you don't have a completely free hand when it comes to choosing the distance. The checksum must be generated by the already protected program, otherwise the antivirus would later recognize itself as a virus. After that, the checksum must be noted in the program. For this purpose, it is stored in the tenth and eleventh bytes of the program header. Together with the header, this results in positions 38 and 39 in the program file. These bytes may not be used to create checksums, since they are changed afterwards.

A further increase in security against such viruses, which are based on frequently used increments, could be achieved by giving the checksum an initial value. In the case of the antivirus presented here, the starting value is zero. So an initialization of the non-zero checksum would have to be carried out. This achieves more protection against 'intelligent' viruses

The measures presented here are not only a good protection against destructive viruses, but they also help against all small programs that work in a similar way to viruses but have different goals.

## Timing

The first table shows the loading times of contaminated programmes. On the left side are the programs that were called up. These have a certain file length before and after the 'infection' with Milzbrand. The next columns show the loading times of the programs. The first time indicates the loading time of the uncontaminated program. In addition, there is the time it takes for the operating system to load an infected program, which, however, does not find any other program to infect.

Runtime if the following program is infected after startup:

| Program | AS68 | LINK68 | RELMOD |  SID |
|---------|:----:|:------:|:------:|:----:|
| AS68    |   -  |  14.5  |  15.0  | 15.5 |
| LINK68  | 13.5 |    -   |  14.0  | 14,5 |
| RELMOD  | 11.0 |  11.0  |    -   | 11.5 |
| SID     | 12.5 |  12.5  |  13.0  |   -  |

<center><b>If the virus starts working after loading, the time between the start of the loading process and the start of the actual program can almost double.</b></center>


The second table refers to the loading and launch of an infected program that infects the specified file with Milzbrand. However, these times should be viewed with caution, because on the one hand they are 'hand-stopped', on the other hand it always depends on how many programs are on the floppy disk and where they are in the directory. Loading times can thus be increased by up to one hundred percent. From this, an experienced computer user can certainly determine which programs have been 'contaminated' with a virus.

| Program | Size without MB in KB | Size with MB in KB | Loading time<br>without MB in seconds | Loading time<br>with MB in seconds |
|---------|:---------------------:|:------------------:|:-------------------------------------:|:----------------------------------:|
| AS68    |         52 864        |        54 126      |                  8,5                  |                10,5                |
| LINK68  |         35 072        |        36 334      |                  7,0                  |                 9,0                |
| RELMOD  |         12 928        |        14 190      |                  5,0                  |                 6,5                |
| SID     |          2 880        |        30 062      |                  6,5                  |                 8,                 |

<center><b>Although the program length changes only minimally, there is a significant increase in loading time. (MB: Milzbrand)</b></center>


## Result

Good programmers can certainly write far more powerful viruses than those printed here. Such viruses then meet all the requirements for compatibility and speed. At this point, I would like to urgently warn all hackers who have the ability and perseverance to develop such programs. Viruses, if intentionally or unintentionally get out of control, would cause great damage. It is important for the programmer to know that current legislation makes it a punishable offence to intentionally damage third-party software.

An old, updated saying goes: 'Prevention is better than buying new software'. Therefore, it is advisable to use the antivirus presented here for all important programs. So at least you are warned early.

Finally, a warning to all those who want to try out the virus: Be careful and pack away all important program disks beforehand. I lost several important programs during development.