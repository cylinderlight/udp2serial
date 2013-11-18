udp2serial
==========

a bridge between udp packets and a tty serial port, framing the udp packet data on the serial line with slip developed to use the OSC protocol on the Arduino Yun

version 1.0  11/18/2013

on Arduino (1.5.4) it has been tested with the OSC library: https://github.com/CNMAT/OSC
on Processing (2.1) with the OSC library: http://www.sojamo.de/libraries/oscP5/

the included slip.py is copyright of Roman Haeflei https://github.com/reduzent/pyslip

the OSC packets sent from the Arduino go forwared to the last peer that sent a packet to the Yun.

Setup procedure:

on linino the serial port is attached the the console, for proper functioning the console must be disabled
edit /etc/inittab  
commenting this line #ttyATH0::askfirst:/bin/ash --login
and rebooting

copy udp2serial.py and slip.py in /usr/bin of the Yun
for example: scp udp2serial.py root@arduino.local:/usr/bin

to run the program interactively from an ssh console type python /usr/bin/udp2serial.py
this is recomended since the code is not heavily tested and the program may stop

the UDP ports are coded as constants, defaults are: receive on port 10000, send on port 11000


Examples:
the included example for Arduino OSC_Echo_SLIP receives an osc message and echoes it back to the sender
the Processing examples sends a message to the Yun and receives it back (press i or b)  

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

