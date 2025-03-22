Title: Important system vectors and memory locations
Slug: AtariVectors
Date: 1994-10-06 12:34
Location: Slovenia
Category: Atari ST
Lang: en
Author: Lucky Lady

### Important system vectors and memory locations

In previous section, we mentioned cold and warm reset. For every virus coder it is very important to know what's going on at reset sequence especially concerning memory locations and system vectors. 
In generally: in both reset cases memory is zeroed from (`phystop` - `$200`) to `$800`. 

Just before that, TOS searches memory in steps of two memory pages (512 bytes) in "hope" to find a following contents: longword `$12123456` and a longword of actual double memory page. 
In successful case, TOS first does a word checksum, which has to be `$5678`. If that is correct, the code on that double memory page is executed through JSR with return address in A6.

As you can see, there are two areas to place a code to survive a warm reset: down from address `$800` or up from `phystop` by simply lowering the `phystop` itself. System vectors begins at address `$400` but there are many of other vectors in area from `$0` to `$800`. The most popular address to place a virus or antivirus or any kind of a reset proof code is `$140`. 
At that address Multi-Function Peripheral Port Vectors are placed, but they have any meaning only on a machines based on TOS 3.0x (TT, Medusa T40 and Eagle computers). Of course, you can place a virus at $140 on TOS 3.0x as well, but it can not be reset proof.

 "In the old days" of virus coding there was always one simple rule: If you turned off your computer - no code could survive a cold reset! Nowadays that is not true anymore! A cold reset can code survive on a systems such as Mega ST, Mega STE, TT, Falcon030, Medusa T040 and Eagle or on a updated other ST or STE through a placing it to NVM (Non Volatile Memory), this is the battery backed-up memory, which remains untouched even if your computer stays shut off for a long time (some months).
 Well, there is another way, more comfortable as space concerns, but more of this one will be told in further versions of UVD. 

