#!/bin/bash

SERVER=$1

scp udp2serial.py slip.py root@$SERVER:/usr/bin
scp udp2serial root@$SERVER:/etc/init.d
scp inittab root@$SERVER:/etc/
scp udp2serial_OSC.service root@$SERVER:/etc/avahi/services
ssh root@$SERVER /etc/init.d/udp2serial enable
ssh root@$SERVER reboot
