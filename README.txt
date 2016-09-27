Chrono Trigger MSU-1
Version 1.1
by DarkShock

This hack adds CD quality audio to Chrono Trigger using the MSU-1 chip invented by byuu.

The hack has been tested on bsnes-plus v073+1, higan 096 and SD2SNES. BSNES 070, 075 is NOT RECOMMENDED, use bsnes-plus v073.

For those playing on SD2SNES, you need to exit to menu using L+R+Select+X shortcut or hit the physical reset button on the console after saving in order to write the save back to the SD card.

Note they are two patches
- chrono_msu1.ips for emulators prior to higan v096 and SD2SNES without resume support
- chrono_msu1_resume.ips for higan v096 and up and SD2SNES with resume support

If you hate the fact that dungeon music restarts at the beginning with no-resume patch, delete chrono_msu1-69.pcm.

================
= Installation =
================
1. Buy Chrono Symphony album in FLAC format (http://www.thechronosymphony.com/). Extract them all to a folder.
2. Run convert_tracks.bat to create the music_pack
3. Create a copy of your original ROM named chrono_msu1.sfc
4. Patch the ROM using Lunar IPS or Floating IPS (http://www.smwcentral.net/?p=viewthread&t=78938)

Please support the original author of the album. I known some sites will host the complete music pack in PCM format, I do not endorse them at all.

Original ROM specs:
CHRONO TRIGGER
U.S.A.
4194304 Bytes (32.0000 Mb)
Interleaved/Swapped: No
Backup unit/emulator header: No
Version: 1.0
Checksum: Ok, 0x788c (calculated) == 0x788c (internal)
Inverse checksum: Ok, 0x8773 (calculated) == 0x8773 (internal)
Checksum (CRC32): 0x2d206bf7

===============
= Using higan =
===============
3. Launch it using higan
4. Go to %USERPROFILE%\Emulation\Super Famicom\chrono_msu1.sfc in Windows Explorer.
5. Rename program.rom to chrono_msu1.sfc
6. Copy manifest.bml and the .pcm file there
7. Launch the game

====================
= Using on SD2SNES =
====================
Drop the ROM file, chrono_msu1.msu and the .pcm files in any folder. (I really suggest creating a folder)
Launch the game and voil�, enjoy !

===========
= Credits =
===========
* Qwertymodo - Conversion script update & video patch merge
* DarkShock - ASM hacking & coding, music editing
* Blake Robinson - Music reorchestration

Special Thanks:
* Geiger - Chrono Trigger documentation
* zarradeth - Chrono Trigger music engine documentation

=============
= Compiling =
=============
Source is availabe on GitHub: https://github.com/mlarouche/ChronoTrigger-MSU1

To compile the hack you need

* bass v14 (https://web.archive.org/web/20140710190910/http://byuu.org/files/bass_v14.tar.xz)
* sox (http://sox.sourceforge.net/)
* normalize-audio (http://normalize.nongnu.org/)
* wav2msu (https://github.com/mlarouche/wav2msu)
