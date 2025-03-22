Title: Virus detection and stealth 
Slug: patterns
Date: 2024-10-29 20:34
Location: Montreal / Canada
Category: Atari ST, Virus
Lang: en
Author: shazz
status: published
summary: Learn more about the lifecycle of computer viruses, particularly focusing on Atari ST bootsector viruses, which have two main phases: the initial phase when they are unknown and proliferate, and the subsequent phase when they become known and are targeted by antivirus software. <br>It outlines various characteristics and tactics of these viruses, including symptoms, replication mechanisms, incubation periods, and stealth techniques used to evade detection by antivirus programs.
image: {filename}images/max_t.png
Tags: Learning

## Virus lifetime phases

This time, we're not going to dive into the details of a particular virus, many more to come, but into virus tactics.
First of all we will look at common patterns found in Atari ST bootsector viruses. Patterns that along the years, antivirus software lean to detect.
As you may know, like biological viruses, computer viruses' life is composed of 2 distinct phases:

 - When they appear and they are not yet explicitly known by users and antivirus software. This the the phase they need to expand and conquer as much as they can as they don't have yet enemies looking to eradicate them.
 - Then, when they start to get known, due to their consequences or just because somebody found them, most of the time, by chance, antivirus software will easily identify them and destroy them.

<p class="digression">In the history of Atari ST viruses, starting in 1987, antivirus were mostly inexistent, some hackers like my good friend Tsunoo Rhilty wrote a little program to detect and destroy one virus (not sure which one, I need to reverse engineer it), then some bootsectors appear to indicate they were free of viruses and finally some specific antivirus like Sagrotan, Virtuell, Antibiotic... That will be probably the topic of another blog post soon!</p>

But for now let's study typical characteristic and patterns found in bootsector viruses.

## Bootsector viruses patterns.

As biological viruses, computer viruses have:
- symptoms
- an attachment
- replication mechanisms
- an incubation period
- specific bindings 
- triggers
- action mechanisms

### Symptoms

Symptoms can be as broad and diverse as their author's imagination and creativity (and skills as in less than 512 bytes, hard to do much). So symptoms can help users to recognize they've got infected floppies but that doesn't really define common technical patterns per say. 

Common symptoms are:
- system slow down or lockup
- screen effect (display bugs, color changes, distortion,...)
- data loss on floppy or hard drive
- sound effect (usually pretty limited)
- text on screen (at boot or not)
- system errors (memory errors, application errors,...)
- messing with inputs: keyboard, mouse displacement or icon...

We'll come back to symptoms later when we'll dig into the bindings look at some technical details linked to symptoms.

### Attachment

For now, we are considering only one attachment: floppy and hard drive bootsector. They are other kind of viruses (link viruses, midi viruses, FAT viruses, hybrid viruses...) but we won't tackle them for now as they were pretty rare and fairly different in terms of constraints, replication and so on.

As you may know, bootsectors are the first sector of floppies in addition to the floppy description (the BPB), they can also contain code limited to the size of the sector, 512 bytes minus the 28 bytes of the BPB. This piece of code can be executed by the TOS under certain conditions:
- if the bootsector pre-PBP contains a branch instruction and the sector word-checksum is equal to 0x1234
- if the bootsector is loaded in memory and in some specific locations (TOS-specific) a special header is found by TOS.

### Replication

Again, like any biological viruses, computer viruses always implement some functions to replicate themselves from floppies to floppies (and sometimes hard drives), from bootsectors to bootsectors. This is their main purpose, to replicate.

Replication is not straight forward and usually use most of the sector space. To replicate a virus will use the following tactics:
- in-memory counter: a counter which usually increments at every replication, most of the time to decide when to trigger symptoms
- generation counter: a counter which is embedded into the bootsector code and is incremented in the virus offsprings.
- floppy event: usually viruses replicate when an application or the system reads or writes the floppy, that's the main source of replication

### Incubation period

Like biological viruses, computer viruses can have different time/event periods before they start to replicate and when they start to show symptoms.
It could be:
- time based: after a given number of VBLs (50,60 or 70Hz depending of the resolution and country standard) or ticks using hardware timers.
- counter based: as we saw, the replication usually manage in-memory or generation counters than can be used for this purpose.
- key based: some viruses will trigger effects only when they will detect a specific bootsector (which also contain the symptoms code). Both stay "inactive" unless they find each other.
- ...

### Bindings

As biological viruses, computer viruses bind to some specific components of their host and they need those binding to survive.
Common bindings are:
- `Trap 14 XBIOS` vector: system vector called each time a specific `XBIOS` system function is called (typically `Floprd()`, `Flopwr()`)
- `Trap 13 BIOS` vector: system vector called each time a `BIOS` system function is called (typically `Getbpb()`, `Rwabs()`, `Mediach()`)
- `hdv_rw` vector: system vector called each time `Rwabs()` BIOS function is called
- `hdv_bpb` vector: system vector called each time `Getbpb()` BIOS function is called
- `hdv_mediach` vector: system vector called each time `Mediach()` BIOS function is called
- VBL vectors: system vectors usually set to run display routine at each VBL: `_vbl_list`, `VBL_vector`, `VBL_queue`
- MFP Timers (A, C...)

In addition to those vectors dedicated to "wake up" virus routines, they usually also bind to the `resvec` Reset Vector which allow a routine to survive to wam resets and that will be executed after a warm reset

### Triggers

...

### Action mechanism

To implement the various aspects, the virus will use software patterns that can be also recognized:

1. System calls aka Traps

Any usage of the `trap` instruction, particularly: 

- `Protobt()` to generate an executable bootsector
- `Floprd()` to read tracks and sectors
- `Flopwr()` to write tracks and sectors
- `Rwabs()` to read/write logical sectors

2. Use of system registers

- `hdv_init`
- `hdv_boot`
- `hdv_rw`
- `hdv_bpb`
- `hdv_mediach`
- `trap 14`
- `trap 13`
- `diskbufp`
- `resvalid`
- `resvector`
- `phystop`
- `memtop`
- `bootdev`
- `_vbl_list`
- `vbl_vector`

3. Typical routine (set of instructions)

- bootsector read or write
- system vector setup
- undocumented resident routine setup

## Antivirus response

The first generation of antivirus software was efficient in detecting known viruses. Meaning they had a copy of the virus bootsector to perform similarity analysis or at least typical viruses signatures (portion of code specific of a given virus).
That was very efficient to detect known viruses but extremely inefficient to detect new and never-seen-before viruses.

So a few years after, antivirus software started to add detection heuristics based on the virus patterns I just described. Usually, a "risk score" was computed based on the number of patterns found to raise warnings.

False positive was always a major issue as bootsectors were often use by games to implement track loading, software protection and demos for similar reasons. And also by Vaccines, bootsectors dedicated to check the memory and bindings. 
As you can imagine, some of the previously described patterns can also be used for some other purposes, especially bootsector vaccines. And deleting a lawful bootsector is usually enough to break a game, a demo, a vaccine.

But at least, using those heuristics, users started to be more aware and cautious. And this was a major threat to the virus existence which has to spread as much as tey can before being "exactly" known.

## Survival requires stealth

As soon as Antivirus started to apply heuristics, virus creators quickly started to think of how to deceive the antivirus software, how to become stealthy.

Year after year, new viruses appeared showing new capabilities to "stay under the radar", from very simple coding tricks to pretty complex obfuscation.

### Code obfuscation

As most heuristics were based on the recognition of code patterns using static analysis, virus creators used code obfuscation to hide those patterns:
- replace hardcoded trap opcode value by register (ex: `move.w d7, -(sp)` instead of `move.w #$8, -(sp)`)
- use auto-modified mode to replace at runtime trap value (ex: `trap #$c` modified elsewhere in `trap #$e`) and jump destinations
- replace hardcoded system registers value by register and/or calculation
- Use memory indirection (pc-relative address, address register relative offsets,...)
- Hide magic numbers like `$1234` or `$12123456`

### Undocumented TOS features

### Tampering protection

Even if the early, that was very common to see binary code patched by other (less skilled) programmers to take credit. People were modifying cracktros, replacing images or text. Ripping was a sport.
So some viruses add protection against tampering. Pretty often as simple as any text displayed at boot was encoded or the virus was checking for some signature into the code to be sure it was not modified.
This protection was not that useful against antivirus software but efficient against early 80's script kiddies!


### Write-protect behavior and error handling

As viruses tend to force write of floppy disks to replicate without the consent of the user, it could happen that using flopwr() or rwabs() calls trigger an error especially if the floppy is write-protected or if it tries to write on a bad/unavailable sector. And this error must reveal its presence. That's why many viruses try to silent those possible errors using different more or less portable technics:

 - etv_critic vector handler to catch Rwabs() and Flopwr() errors
 - undocumented TOS routines to detect write-protect floppy latch position (TOS_102_WPLATCH)
 - catch Rwabs() EWRPRO error code

### Vaccine camouflage

As explained at the beginning of this article, Vaccine became pretty frequent on floppies and usually, to reassure the user, they were displaying messages like "no virus in bootsector" at boot.
Some viruses were mimicking those vaccines and displayed similar or exactly the same message to deceive users (and let them think that they don't need to check those floppies using an antivirus) and possibly antivirus which used signatures to recognize bootsectors.

### Memory hideouts

To get the available total / free RAM, the TOS provide some systems registers (`MEMTOP`, `PHYSTOP`, `THEMD`...) to applications. Viruses learnt to use those registers which are R/W and decrease their value of enough bytes to create an hideout, after the high boundary. A good way to avoid accidental overwriting by an application or memory scan by an antivirus.

Viruses also reused unused system vectors (at least on ST family, not always true on Falcon and TT) and memory locations safe to warm reset

### Code encryption

Last generation of viruses had their code frequently encrypted (simple and very small footprint methods like XOR, ADD or SUB transformation) based on key/offset possibly randomly generated and stored in the bootsector, sometimes "hidden" in unused BPB locations (serial, hidden sectors,...)

Some virus also included, in addition to the obviously required decryption routine, the encryption routine, to be used at replication time to create offspring totally different from the parent virus. Random keys were typically generated from any hardware counters (`FRCLOCK`, `HZ200`)

### System functions hijacking / spoofing

Some virus hijack system functions used by antivirus software to read the bootsector (typically `Rwabs()` and `Floprd()`) to return a fake/safe/non-executable bootsector 

### Non executable bootsectors (or looking like)


### Delayed action

Considering the limitation of the TOS which was not a full multitasking OS (at least before MinT), viruses could be detected at boot time by vaccines or when an antivirus scan was explicitly run (some vaccines were memory-resident but not that often and could be easily swiped from memory by applications, demos or games). So a typical evasion strategy for viruses was to delay its presence, symptoms, bindings to a later time:
- after the first reset since the bootsector was loaded (using the reset vector or the undocumented resident routine)
- after a time delay, to evade vaccines and possible antivirus checks

### Trace safety

Some virus were hooking the Illegal Instruction vector often used by debuggers to break and trace code.

### Unwanted bugs / code mutation

Pretty often, there are bugs in viruses and it makes them hard to understand. In the early times of the ST, debugging a bootsector and how the TOS interacts with it was certainly pretty complex, so it is not surprising, like in any piece of code, that viruses have bugs. In addition, like biological viruses, computer viruses tend to mutate over time, modified by somebody on purpose or to test, or simply that floppies are not safe storage media and errors on disk can happen, some bytes can be modified, sometimes disabling the virus, sometimes only making it buggy (less probable as the checksum would change)

### External code

Some hybrid virus were using external content to extend their capabilities and hide code in locations that antivirus won't look for. Typical extensions mechanisms are:
- additional payload located after the FAT sectors (or elsewhere on the disk in a safe location)
- key bootsector

### Appendix: viruses stealth mapping