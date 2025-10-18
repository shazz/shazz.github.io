Title: Atari ST Key Viruses: The Sophisticated Bootsector Malware
Slug: keyviruses
Date: 2025-10-17 15:04
Location: Montreal / Canada
Category: Atari ST, Virus
Lang: en
Author: shazz
status: published
summary: Learn more about Key viruses. Those bootsectors viruses extend their capabilities by waiting for another bootsector to show up which is containing the inactive symptoms code.
image: {filename}images/max_t.png
Tags: learning, viruses


## Technical Overview of Key Virus Mechanism

Key viruses represented a sophisticated class of Atari ST malware that used a unique infection and activation strategy.<BR>
Unlike traditional viruses, these malicious programs would:

- Replicate themselves silently
- Remain dormant until a specific "key" was detected
- Execute specialized routines when the key was present

## Notable Key Viruses and Their Characteristics

### Signum/BPL Virus A

- *Discovery Date*: **November 22nd 1987** by Klaus Seligmann.
- *Infection Scope*: Estimated 1.5 million copies worldwide
- *Key Mechanism*: 
    - Waits for a specific disk with a unique code
    - Executes hidden routine when key is found
- *System Vector*: Attaches to `Hdv_bpb` vector
- *Replication*: Copies to current drive (A or B)
- *Key*: if bootsector[2:4] == $1092 and bootsector[4:6] > signum[0:2], `jsr` is called on the detected keyed disk (so needs to be a valid branch)

### Bad Taste Virus

- *Discovery Date*: **April 4th 1989** by Pulsion. <br>This virus was spread using a program called The Infector - The virus Diffusion Set 1.0.
- *Author*: Trap #16 / Bad Tast
- *Reset Resistance*: Survives system reset
- *Infection Strategy*: 
  - Checks every inserted disk (using `Hdv_bpb` vector)
  - Executes external routine if special key is found on the inserted disk bootsector.
- *Payload Variation*: Depends on specific key disk
- *Keyed Disk Variations*:
    1. Keydisk #1: Inverts screen
    2. Keydisk #2: Changes 16 colors each VBL (Vertical Blank Interrupt)
    3. Keydisk #3: Formats FAT and directory
- *Key*: if bootsector[30:32] == $4344, `jsr` is called on the detected keyed disk to an relative address set in the bootsector

## Technical Infection Mechanism

Key viruses typically employed the following techniques:

1. <b>Silent Replication</b>: Copy to other disks without immediate payload
2. <b>Key Detection</b>: Scan inserted disks for specific markers
3. <b>Conditional Execution</b>: Trigger specialized routines based on key presence


## Infection Detection and Prevention

<b>Antivirus tools like the Ultimate Virus Killer (UVK) 2000 could detect these viruses by:</b>

- Monitoring system vector modifications
- Checking specific memory offsets
- Verifying bootsector integrity

But as far as I know, no antivirus was checking specific keys based on known locations find malicious content. As as of today, the key bootsector for the Signum BPL virus was never found despite millions of copies of the virus. 

For each key virus, a vaccine exists which contains the lookup key and a virus destruction routine which is triggered by the virus itself.

## Technical Significance

These key viruses demonstrated:

- Advanced conditional execution techniques
- Sophisticated memory residence strategies
- Exploiting operating system design vulnerabilities (vectors)


## Conclusion

Key viruses on the Atari ST represented a fascinating chapter in early computer malware, showcasing how viruses could be designed with complex, conditional activation mechanisms. The ability to remain dormant and execute specific routines based on unique "key" disks highlighted the creativity and technical sophistication of early virus writers.
