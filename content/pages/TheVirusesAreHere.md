Title: The viruses are here
Slug: TheVirusesAreHere
Date: 1988-07-01 12:34
Location: Germany
Category: Atari ST
Lang: en
Author: Thomas Koziel, Guido Leister
status: hidden

## Boot sector viruses conquer the Atari ST

**By Thomas Koziel, Guido Leister / Computer & Technik - July 1988**


> *Note: this article from C'T was translated using Google Translate and edited by myself. You can find the original issue of C'T on the [Internet Archive](https://archive.org/details/ct-1988.01/C%27t%20-%201988.01/) or ask me, I have a scanned copy.*

The subject of computer viruses has now completely lost its theoretical character. For some computer models, a wide range of the unpopular species is haunting the country. The Atari ST is at the top of the group of computers at risk. The small programs often cause considerable damage; but even harmless versions can, if poorly programmed, have ugly side effects. Using the example of the 'disk virus', a specimen that recently penetrated the author's system, one such case is documented and early detection and treatment are discussed.

I first heard about 'viruses' in computer systems about four years ago - from a general science magazine. There I read about programs that behaved in a computer system like pathogens in a living organism. Once installed on a common computer model, such a product of perfidious programming could have an epidemic character. The c't article 'The viruses are coming' [1] was a little more practical - the author developed the concept of a functional virus before the eyes of the astonished reader. The topic suddenly became worryingly topical; there was a probability that several virus specimens were already in circulation, which, depending on the remaining morality of their creator, could cause great damage.

### Infection

So I was not completely unprepared in March 1988 when the amateur who first penetrated my system to demonstrate his intellectual fruits with a diskette appeared, unwittingly aiding him. The virus also took advantage of the fact that I boot the driver for my hard disk from the AUTO folder of a diskette, which is usually not write-protected.
The exact sequence of events was that I turned off the computer and started up the system with my friend's diskette. The hard disk remained in operation, but was not integrated into the system. I only managed to do this by subsequently starting the AHDI program. Later, after another reset, I noticed that only the standard Atari desktop appeared and the hard disk icons were completely missing. This indicated that there was no desktop info on the C: partition, which serves as the Atari's standard drive after the hard disk has been successfully initialized. However, I was completely sure that I had saved the `DESKTOP.INF` file there.

Apparently the computer did not recognize the hard disk when starting AHDI and aborted the initialization. In this case, the experienced Atari user first checks that the numerous cables on his computer are properly seated - without success. The hard disk made its usual noise when switched on. After the computer was subsequently started, a brief flicker of the Busy LED revealed that TOS was accessing the boot sector, which simultaneously marked the climax and the end of the communication between the computer and the hard disk.

Well, perhaps the boot disk had become defective in some way, even if it was hard to imagine. An attempt with the write-protected original didn't lead to the desired result. In my helplessness, I clicked on the floppy icon A: - and received an alert box with the information that the disk in drive A: was write-protected, which I should please change before the next attempt. Astonishment! 'Who' or rather 'what' was trying to write to the disk when I opened the drive?

### Diagnosis

The virus had given itself away. My friend and I quickly discovered that the boot sectors of our floppy disks were executable and contained useful program code. When we disassembled them, we discovered a small routine that 'bends' various operating system vectors.

The only strange thing is that my friend, who works with two floppy drives, had his computer abort the boot process with three bombs, while in my system with one drive the virus was able to boot unhindered and sneak into the memory. What's more, the hard disk was also infected. Although I could no longer access it, the check of sector zero, which the TOS performs every time the system starts [2], was enough to load the virus into the memory. 

Now the situation was fairly clear: sector zero of the hard disk contains, among other things, the partition information, without which the driver cannot initialize the disk. The virus had overwritten it; as a result, AHDI aborted the attempt to mount the hard disk without a sound. 

The listing shows the virus in disassembled form. It has two headers, each 32 bytes long. The first contains the description of the diskette format, which differs from the information on a healthy diskette only by the jump command used by the virus and three insignificant filler words. The virus later uses the second head in memory to remember important information.

To get into the computer, it takes advantage of the good nature of the TOS. When booting, the TOS automatically loads the first sector of the diskette into drive A: into memory and calculates the sum of all the bytes it contains. The result is shortened to word length (modulo `SFFFF`) and compared with `$1234`. If these values ​​match, the operating system calls the boot sector as a subroutine, without suspecting that it might be bringing a virus to life. 

This begins with the jump command mentioned above, which skips the two virus heads with the diskette and program information and branches to the virus's installation routine. This then determines whether the system is already infected by examining the byte sequence starting at `$200` bytes below the upper limit of the user memory (`memtop`). To do this, it checks for the presence of two magic long words. The virus thus plays it safe; the first long word `$12123456` could also belong to another utility.

If one of the two values ​​is not present, the virus knows that none of its doubles has yet nested in memory. It therefore overwrites the first sixteen bytes of its second header with the two magic long words, its age, a jump command, the new start address (`$200` below `memtop`) and the current values ​​of the system variables `hdv_bpb` and `hdv_mediach`, the vectors to the BIOS routines for fetching the BlOS parameter block and for detecting a disk change.

It then copies itself to its chosen location. While moving, it simultaneously recalculates its checksum, which has changed due to the loading of the variables. Finally, it places a checksum value at the last word boundary before `memtop` so that the new virus receives the word sum `$5678` in the top `$200` bytes of the user memory. The installation routine then returns control to the TOS with an RTS command - without having changed a single system variable or vector!

### Lab report

A dud then? Not at all: In order to understand how the intruder is finally activated, it is necessary to know a peculiarity of TOS that is often overlooked in the literature.

Even before the operating system ends its initialization phase by starting a program that may be in the AUTO folder, it searches the RAM area from the upper physical end down to address `$600` for a boundary between two `$200` bytes pages that meets the following conditions:

- The first long word contains the magic number `$12123456`.
- The second long word is a pointer to the memory page being examined.
- The word sum of all 512 bytes of this field is `$5678`.

This mechanism is used to reactivate resident programs in the Atari ST after a reset [3]. But thanks to the preparatory work of the installation routines, the virus also meets these requirements and is therefore reset-resident at the same time. 

The TOS therefore starts the virus again, which then manipulates the variables `memtop`, `hdv_bpb` and `hdv_mediach`. By changing `memtop`, it protects itself from being overwritten by user programs, and it hooks itself into the operating system via the hdv vectors; when the BIOS routines `Getbpb` and `Mediach` are called, the virus routines `vir_med` and `vir_bpb` are run first. 

These first copy the fourth-lowest stack word upwards, which contains the device word when the BIOS functions mentioned are called after the trap handler has been run through. A zero stands for drive A:, a one for B:, a two for C: and so on. The subroutine `new_vir` is then called, which first saves the registers and looks for the device word under the return address on the stack. The BIOS function `Rwabs` is used to read the boot sector of the addressed device and - if no error occurs - to check whether it is bootable.

If it is not yet bootable, the header bytes for the diskette version of the virus are entered, the age of the offspring is generated by increasing the virus's own age, the actual virus program is copied into the disk buffer and then a new boot sector is generated from it using the XBIOS function `Protobt`. A further call to `Rwabs` (again the device number is copied up from the fourth-lowest stack word) writes the new sector to the diskette; the virus has successfully replicated.

At this point it looks at its own age. If it is older than twenty, it starts a rather chaotic-looking routine that I have called `show_vir`. This decrypts a coded message in a loop by moving and logical links and writes it across the desktop using the BIOS function `Bconout`. The virus has revealed itself.

Actually a fairly harmless representative of its species, you would think. Before overwriting a boot sector, it even checks whether a program is already there; nothing is deleted. And anyway, how could it have ended up on the physical sector zero of the hard disk? `Rwabs` can only address logical devices. At most, one would expect it to nest in the logical sectors zero of the partitions. And that would have no noticeable consequences.

In this case, however, there is an unfortunate concatenation of two facts: 
 - The virus contains a bug and 
 - `Rwabs` can, under certain circumstances, access physical sectors in conjunction with the AHDI (although, to my knowledge, this is not documented anywhere).

The virus programmer has neatly placed the device word on top of the stack in the `vir_med` and `vir_bpb` routines. After the jump to `new_vir`, the same process is required again before calling `Rwabs`, since the return address is placed on the stack when the subroutine is called. Before doing this, however, the programmer pushes the registers `D0` to `D2` and `A0` to `A3` onto the stack and therefore accesses them with the command:

`move.w $4(A7),-{A7)`

not to the device number, but to the lower word of register `Dl`. What is written there, however, is known only to the gods and the TOS, which uses this register as an auxiliary variable in some routines.

This means nothing other than that 'something' is passed to Rwabs as a device. This something often seems to be zero, because infecting the logical drive A: almost always works. Sometimes, however, there is a different value in register `Dl`. What then happens can be understood using the 'Test-Rwabs' program. It reads the device and sector number from the console and then calls Rwabs for a read operation. I have not tried all possible values, but I have at least found that when the fourth bit is set (for example `$12` for C:), the function does not access the logical sector zero of this partition, but rather the physical sector zero of the hard disk.

### Therapy

Diskettes that are already infected should be cleaned immediately. To do this, it is absolutely necessary to boot the system virus-free. You can then use a diskette monitor to tinker with the boot sector. Although changing one byte is enough to make the sector 'unbootable', meticulous people can completely zero it; however, the diskette structure information in the `$08-$1D` area should be omitted.

Since an unnoticed infection can very quickly infect the entire disk box, a small C program should help you to check a large number of disks quickly and easily. After starting, the Boot Sector Check program asks you to insert the suspicious disk. The boot sector is read using the Rwabs function, checked for bootability and the result is displayed.

The program also displays the age of the virus described here. For boot sector viruses of other types, this value is of course meaningless. You can now decide whether the sector should be zeroed (omitting the disk structure information) and at the same time receive a checksum that definitely identifies it as non-bootable, or whether the sector should be left as it is (for example, because you have medical ambitions and would like to dissect the virus).

### Patient hard drive

As the owner of a hard drive, you can be particularly affected by the current form of the virus. The physical sector zero is higher than the logical drives and contains information about the hardware and partitioning of the disk. If the virus is installed there by passing on a 'nonsensical' device number, the disk is 'dead' for AHDI.

Of course, you could easily get out of this situation by reformatting the disk. Any prudent hard disk user will have backup copies of all important programs. However, such an undertaking is not very attractive. Therefore, other methods should be preferred.

Restoring the hardware and partition information for sector zero is necessary. The hardware fields do not pose a problem in this respect. The manual for the hard disk provides information about them. The partition data is a little more difficult: the meaning of the 12 bytes assigned to each partition is described, but what HDX.PRG writes into it during partitioning remains a secret. Where exactly (with several tens of thousands of sectors) the dividing line between two partitions is located could probably only be found out by disassembling the program.

My first approach was to compare it with a disk whose first partition is also 16 MB. Here there were only partial sequences: Partition C: was fully accessible again, for D: the system reported zero bytes in zero files; the dividing line was wrong. Its position depends on the total number of valid partitions.

Fortunately, during further investigations with the disk monitor and various test programs, I discovered a fact that was previously unknown to me and that solved all the problems in one fell swoop: the system information of the physical sector zero is contained in the same form in the logical sectors zero of the individual partitions; however, its position within the sector is shifted back by two bytes.

This makes the design of the 'Restore Partition' program strikingly simple: read the remaining logical sector zero of partition C:, move the important data forward by an offset of two bytes, overwrite the rest with zeros to be on the safe side and write it back to the physical sector zero of the disk. This also destroys the virus.

However, this requires some effort, as without the installed driver, direct access to the ST's DMA interface is required. For convenience, I used the routines published in [2] and wrote a new main program for it. For disks that already have entries in the bad sector list, there is a possibility that the C: partition does not begin directly behind physical sector zero. In this case, the sector to be read must be determined experimentally.

### Prevention

The prevention of RAM-resident boot sector viruses like the one described here involves three points:

 - If possible, always boot the system with its own, always write-protected diskette.

 - If this is not possible for some reason, switch off the hard disk and leave secondary drives empty to give the virus no chance to spread. After using a possibly infected diskette, switch off the system and start it again with a clean diskette. You should not forget that RAM-resident viruses (like the example presented here) can be reset-proof without further action!

 - If the second point cannot be observed for some reason, you should use a disk monitor or the 'Boot Sector Check' program to make sure that the boot sector contents are harmless before booting from the unknown diskette. Every copying process contributes to the further spread of a virus program. If the system complains about write protection during read operations, the 'monster' is definitely already in the system. Then the only thing that helps is to switch the system off immediately and boot with a write-protected and 'clean' diskette, which you should always have ready. You should then examine the boot sectors of all diskettes in use to determine the extent of the damage and prevent further spread.

Cleverly programmed viruses will of course not give themselves away by attempting to reproduce during a read operation. To detect them, you have to take a different approach: RAM-resident viruses, which spread by contaminating the boot sectors of clean diskettes, have to circumvent at least some of the vectors that the system uses to manage mass storage.

It would therefore be a useful approach to use a program to cyclically check the status of the corresponding vectors. The accessory printed out fulfils this task and generates an alarm message when a system variable changes. However, since useful programs such as RAM disk and hard disk drivers also hook into the TOS in this way, it is up to the user whether the vectors are reset to their original value. Anyone who regularly uses a RAM or hard disk should change the program so that it also monitors the legally changed vectors.

### Conclusion

We can expect a real flood of viruses in the future. Two distant relatives of the boot sector virus presented above have already appeared in the editorial office, which have never given themselves away through unauthorized write access. One of them reports irregularly with four bombs; the data of an application that is currently running is lost as a result.

It is also to be expected that such programs will become more refined and thus more difficult to detect. The protection efforts of individuals could lead to extensive quarantine of their own disk archives. Perhaps this would inadvertently take away the future of piracy? This raises the question of whether some viruses are not the products of software houses that were released in order to curb software piracy.

The public domain principle would also fall by the wayside. Who would want to copy a diskette if they were not aware of how dangerous it was? All virus programmers who see their work as a joke should keep such a situation in mind. They too will be among the victims, even if only indirectly. A user group will not be able to defend itself against ever new types of viruses by isolating each other, but only by increasing communication.

Literature

 - [1] Eckhard Krabel: The viruses are coming, c't 4/87
 - [2] Jens Abraham: Blitzstart, c't 8/87
 - [3] Alfons Krämer; Thomas Riebl; Winfried Hübner: The TOS-Listing, Verlag Heinz Heise, Hannover 1988
