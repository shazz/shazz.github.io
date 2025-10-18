Title: Types of virus polymorphisms
Slug: PolymorphismVirusTypes
Date: 2025-10-16 8:16
Location: Montreal / Canada
Category: Atari ST
Lang: en
Author: shazz
status: published
summary: The article describes tthe various virus types regarding polymorphisms
image: {filename}images/max_t.png
Tags: learning, tricks, technical details

## Computer Virus Morphology Comparison

| Virus Type | Complexity | Code Structure | Mutation Capability | Detection Difficulty | Primary Characteristic |
|-----------|------------|----------------|---------------------|----------------------|------------------------|
| <b>Monomorphic</b> | Low | Static | Minimal | Easy | Uses simple encryption with minimal variation |
| <b>Oligomorphic</b> | Moderate | Limited variation | Restricted mutations | Moderate | Limited set of mutation techniques |
| <b>Polymorphic</b> | High | Highly variable | Extensive mutations | Difficult | Generates multiple encrypted variations |
| <b>Metamorphic</b> | Very High | Complete rewriting | Total code transformation | Extremely Difficult | Completely rewrites own code with each infection |


## Detailed Virus Type Breakdown

### Monomorphic Viruses

<b>Monomorphic viruses</b> are the most basic type of mutating viruses. They use a simple encryption mechanism to slightly alter their appearance, but their core code remains fundamentally unchanged. This makes them relatively easy for antivirus software to detect and neutralize.

Typical mutation technics:

- None

### Oligomorphic Viruses

<b>Oligomorphic viruses</b> have a more sophisticated approach. They can generate a limited number of variations of themselves, typically using a small set of predefined mutation techniques. While more challenging to detect than monomorphic viruses, they still have a constrained mutation capability.

Typical mutation technics seen on Atari ST:

- Generation counter

### Polymorphic Viruses

<b>Polymorphic viruses</b> represent a significant leap in complexity. They can generate numerous variations of their code, using advanced encryption and mutation techniques. Each time they replicate, they create a different version of themselves, making detection substantially more difficult for traditional antivirus software.

Typical mutation technics (in addition to Oligomorphic technics) seen on Atari ST:

- Simple encryption scheme with hardcoded key
- Mixed Simple encryption schemes with dynamic key

### Metamorphic Viruses

<b>Metamorphic viruses</b> are the most advanced and dangerous type. Unlike other virus types, metamorphic viruses completely rewrite their own code with each infection. This means every iteration of the virus is structurally different, making detection extremely challenging. They essentially recreate themselves from scratch while maintaining their original malicious functionality.

Typical mutation technics (in addition to Polymorphic technics) seen on Atari ST:

- Multiple layers of encryption
- Code structure variations (bootsector branch, intial virus bootcode)
- Bootcode Packing


## Detection and Prevention Strategies

- For monomorphic and oligomorphic viruses: Standard signature-based detection works well
- For polymorphic viruses: Advanced heuristic analysis and behavior-based detection are necessary
- For metamorphic viruses: Complex machine learning and AI-powered detection techniques are required for unknown viruses.

### Atari ST examples

The vast majority of Atari ST viruses are Monomorphic or Oligomorphic (generation counter).

But in the latest years of the ST and Falcon computers, some Polymorphic viruses appears mostly using simple XOR, ADD, SUB or mixed of those "encryption" schemes with sometimes a hardcoded key, sometimes a dynamically generated key:

 - Macumba 3.3 and Zorro (same codebase, XOR encyption with dynamic key)
 - Macumba 5.2 (XOR encyption with dynamic key)
 - Hide (XOR encyption with dynamic key)
 - Darkness (SUB/ADD encryption with dynamic key)
 - Horror (XOR encyption with dynamic key)
 - Fastload (XOR encyption with dynamic key)
 - Trojan (XOR encyption with dynamic key of the hidden malware)

Very few of them are somewhat (definitively not full code rewrite, only parts) early metamorphic, to some extend, using multiple layers of encryption and also some code modification and reorder:

- Beilstein (2 layers of encryption)
- Recoder (different bootsector branches, dynamic encryption)
- Pharaoh (2 keys for the mixed encryption scheme, different bootcode starting offsets and different bootcode starting instructions)
