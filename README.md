udp2serial
==

A bridge between UDP packets and a tty serial port, framing the udp packet data on the serial line with slip. 
Developed to use the OSC protocol on the Arduino Yun

version 2.0     2014/07/05

Tested on: OpenWrt-Yun 1.1
With: Arduino IDE 1.5.6-r2
OSC library: https://github.com/CNMAT/OSC
Examples for:
Processing (2.2.1) with the OSC library: http://www.sojamo.de/libraries/oscP5/
TouchOSC 1.9.1http://hexler.net/software/touchosc (available for purchase for both IOS and Android)
	

Setup procedure:
==

Connect to the same network of your Yun and execute from you workstation  >setup_push_udp2serial.sh arduino.local
This script copies the requred files to the Yun using scp. You need to authenitate several times witing you arduino password.
After the files are copyed the Yun reboots.

The UDP ports are constants in udp2serial.py, defaults are: receive on port 10000, send on port 11000
The OSC packets sent from the Arduino go forwared to the last peer that sent a packet to the Yun.

Insights:
==
on opewnWRT the serial port is attached the the console and the kernel messages are also sent to the serial.
For proper functioning the console must be disabled editing 
/etc/inittab  
commenting this line 
 #ttyATH0::askfirst:/bin/ash --login
 effect of this requires a reboot

The startup script  takes care to mute the kernal messages executing 
echo 0 > /proc/sys/kernel/printk
before lounching the service

udp2serial.py and slip.py are the program files
and go in /usr/bin on the Yun
slip.py is copyright of Roman Haeflei https://github.com/reduzent/pyslip

To run the program interactively from a terminal type: python /usr/bin/udp2serial.py

An initscrip is provided  in /system/etc/init.d/udp2serial 
you may need to enable it to execute: (chmod +x udp2serial) 
this script also resets the arduino microcontoller for clean buffers status because they are filled by data from the bootloader and linux boot kernel messages.

The OSC service is published on the lan with multicast DNS (avahi)
the UDP receive (10000) is in this file:  /system/etc/avahi/services/OSC.service

Examples:
===
The included example OSC_Serial_LED.ino controls the light intensity of the LED wired on pin 13 of arduino.
Arduino reacts to the osc message /led/13 with a float value in the range 0 ..100
it responds back with the message /reply with a float value in the range 0..255 (the PWM value of Arduino)

The interface for Processing is OSC_LED_send.pde (move the mouse up and down to change the value)

The interface is for ToucOSC testLED.touchosc. To load the interface on your mobile you need to use TouchOSC Editor
  

////////////////////////////////////////////////////////////////////////


License:

Written by Marco Brianza. Copyright (c) 2014

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

