udp2serial
==========

A bridge between udp packets a/nd a tty serial port, framing the udp packet data on the serial line with slip. 
Developed to use the OSC protocol on the Arduino Yun

version 1.1  04/01/2014

on Arduino (1.5.6-r2) it has been tested with the OSC library: https://github.com/CNMAT/OSC
on Processing (2.1) with the OSC library: http://www.sojamo.de/libraries/oscP5/

the included slip.py is copyright of Roman Haeflei https://github.com/reduzent/pyslip

The OSC packets sent from the Arduino go forwared to the last peer that sent a packet to the Yun.

Setup procedure:

on linino the serial port is attached the the console and the kernel messages are also sent to the serial.
For proper functioning the console must be disabled editing 
/etc/inittab  
commenting this line 
 #ttyATH0::askfirst:/bin/ash --login
 effect of this requires a reboot


The startup script of version 1.1 takes care to mute the kernal messages executing 
echo 0 > /proc/sys/kernel/printk
before lounching the service


copy udp2serial.py and slip.py in /usr/bin of the Yun
for example using scp: 
scp udp2serial.py root@arduino.local:/usr/bin
scp sli.py root@arduino.local:/usr/bin

to run the program interactively from an ssh console type: python /usr/bin/udp2serial.py

an initscrip is provided  in /system/etc/init.d/udp2serial 
copy it to the linino corresponding folder for automatc startup, you may need to enable it to execute: (chmod +x udp2serial) 
this script also resets the arduino microcontoller for clean buffers status because they are filled by data from the bootloader and linux boot kernel messages.

The UDP ports are coded as constants, defaults are: receive on port 10000, send on port 11000

If you are using OSC and want to publish this sevice with multicast DNS you can copy the on the YUN the file
/system/etc/avahi/services/OSC.service
the UDP port hard coded in this file is 10000 


Examples:
the included example for Arduino OSC_Echo_SLIP receives an osc message and echoes it back to the sender
the Processing example sends a message to the Yun and receives it back (press i or b)  

////////////////////////////////////////////////////////////////////////


License:

Written by Marco Brianza. Copyright (c) 2013

Permission to use, copy, modify, distribute, and distribute modified versions
of this software and its documentation without fee and without a signed
licensing agreement, is hereby granted, provided that the above copyright
notice, this paragraph and the following two paragraphs appear in all copies,
modifications, and distributions.
 
IN NO EVENT SHALL REGENTS BE LIABLE TO ANY PARTY FOR DIRECT, INDIRECT,
SPECIAL, INCIDENTAL, OR CONSEQUENTIAL DAMAGES, INCLUDING LOST PROFITS, ARISING
OUT OF THE USE OF THIS SOFTWARE AND ITS DOCUMENTATION, EVEN IF REGENTS HAS
BEEN ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 
REGENTS SPECIFICALLY DISCLAIMS ANY WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
PURPOSE. THE SOFTWARE AND ACCOMPANYING DOCUMENTATION, IF ANY, PROVIDED
HEREUNDER IS PROVIDED "AS IS". REGENTS HAS NO OBLIGATION TO PROVIDE
MAINTENANCE, SUPPORT, UPDATES, ENHANCEMENTS, OR MODIFICATIONS.

