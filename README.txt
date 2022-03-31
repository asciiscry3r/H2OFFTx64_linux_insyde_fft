InsydeFlash for Linux (Use IHISI) Version 1.1c -- READ ME
===========================================================

This tool must use with InsydeH2O BIOS.

===========================================================
Important
===========================================================
Tool build environment:
IA32 version -> CentOS release 5.10 - kernel version 2.6.18 with GNU C Library 2.5 and GNU CC version 4.1.2
x64 version -> CentOS release 5.10 - kernel version 2.6.18 with GNU C Library 2.5 and GNU CC version 4.1.2

1.If you just need to test flash utility, please put your file to data folder, and use
  "./H2OFFT.sh (filename) (command)".

Note: The linking address is case-sensitive.
  
===========================================================
Package
===========================================================
The release package will include:

Read.me
ReleaseNotes.txt

utility 
  H2OFFT(x64).sh          -- Console Flash scrip file (run this file)
  H2OFFT(x64)-G.sh        -- Graphic Flash scrip file (run this file)
  h2offt                  -- Console Flash application (run this file directly after driver inserted)
  h2offt-g                -- Graphic Flash application (run this file directly after driver inserted)
  platform.ini            -- Flash setting file
                             Some default values of [ReturnErrorCode] and [ReturnCodeDefinition] in this 
                             INI file are great than 256 (0-255). Please manually modify they to 0-255 
                             on Linux system for getting correct return value
  message.ini             -- Message setting file
  Logo.png                -- Logo

  driver\
        phy_alloc.c              -- driver source code
        phy_alloc.h              -- driver header file 
        Makefile                 -- Makefile for this driver
	
  SecurityFlash\
        SecurityFlash_x86_WIN_100.00.01.02.zip  -- SecurityFlash tool under windows
        Using the Insyde Win Flash Package.pdf  -- Install Guide about SecurityFlash tool

===========================================================
Driver
===========================================================
Below driver file will not be included in release package 
but these have to be put in folder of release package when launching flash function.
Change directory to driver folder you need and run make to build driver.
If H2OFFT runs on embedded system, modify Makefile with correct kernel and compiler.

  driver/phy_alloc.ko     	-- The driver runs on normal system

	    
DRIVER =>

  If it is success to build driver, you can see "phy_alloc.ko" in this folder.
  Copy the driver file to tool folder instead of driver folder/ 
  
3.If you see the following message: insmod: error inserting 'phy_alloc.ko': -1 Invalid module format
  (This is caused by incorrect kernel version. Please check kernel version and remove driver.) 

===========================================================
Print help
===========================================================
usage:
In to the data folder
$ ./H2OFFT.sh -h

===========================================================
CMOS Feature
===========================================================
usage:
Read CMOS:
Only CMOS - 
$ ./H2OFFT.sh xxx.bin -cr
CMOS and BIOS - 
$ ./H2OFFT.sh xxx.bin -cr -g

Write CMOS:
$ ./H2OFFT.sh xxx.bin -cw
If xxx.bin < 256 bytes - 
Only CMOS in file
IF xxx.bin > 256 bytes - 
BIOS and CMOS

===========================================================
Read rom data from IHISI
===========================================================
usage:
In to the data folder
$ ./H2OFFT.sh (Filename) -g

===========================================================
Decompress the bin file
===========================================================
usage:
$ ./H2OFFT.sh [folder_name]
ex: ./H2OFFT.sh insyde
It will be decompress the binary files to the folder named insyde.

===========================================================
Vendor.opt
===========================================================
Options can be defined in vendor.opt by vendor.

For example:
If BIOS need flash logo and boot block (PEI), and do not reboot
after flash. The vendor.opt can be "-FL -B -N".

The command can write in "vendor.opt".
Than you just only type "./H2OFFT.sh".
This filename is "bios.rom".

It support you to write file name in vendor.opt.

The format is the same of your command.
Ex:
  $ ./H2OFFT.sh xxx.bin -all

===========================================================
Varable feature
===========================================================
vr -- Variable read feature
vw -- Variable write feature
ve -- Variable erase feature
vf -- Variable access by file

If data by file, please use ":(filename)".
This feature support "vr" and "vw".

Ex: Read Variable by Variable.bin
$ ./H2OFFT.sh Variable -vr:Variable.bin

Variable.ini -- Variable GUID and Name here.
Format: Number,Name,GUID

Variable.opt -- Use with "-vf".
Format: Name,GUID,Action,Length,Data

Action:
		R - Read
		W - Write
		E - Erase
		N - Skip

===========================================================
How to run in silent mode.
===========================================================
usage:
	$ ./H2OFFT.sh xxx.bin -all -silent
	
===========================================================
How to define program return code.
===========================================================
	Please reference [ReturnCodeDefinition] and [ReturnErrorCode] sections in platform.ini.
  
===========================================================
How to run in embedded system.
===========================================================
Build driver in embedded mode. Change the KERNEL_DIR and CROSS_COMPILE in Makefile then run make.
  $ make embedded

Copy phy_alloc.ko to H2OFFT folder, and run H2OFFT.sh

Check /dev/mem and /dev/phy_alloc, if they doesn't exist, run below command to create them.
  $ mknod /dev/mem c 1 1
  $ mknod /dev/phy_alloc c 231 1

Make sure /dev/mem and /dev/phy_alloc exist and phy_alloc.ko inserted, you can run H2OFFT.
