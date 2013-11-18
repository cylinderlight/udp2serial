
import socket,select,tty
import slip
import time

UDP_PORT_IN = 10000 # UDP server port
UDP_PORT_OUT = 11000
MAX_UDP_PACKET=512 # max size of incoming packet to avoid sending too much data to the micro
SERIAL_PORT='/dev/ttyATH0'

udp_client_address=('127.0.0.1',UDP_PORT_OUT) #where to forward packets coming from serial port
udp_server_address = ('',UDP_PORT_IN) #udp server

serial=open(SERIAL_PORT,'r+b') #open the file corrisponding to YUN serial port
tty.setraw(serial) #this avoids the terminal to change bytes with value 10 in 13 10

udp_socket = socket.socket(socket.AF_INET,socket.SOCK_DGRAM)
udp_socket.bind(udp_server_address)

slip_processor=slip.slip()

while True:
        (rlist, wlist, xlist) = select.select([udp_socket,serial], [], [])
        if serial in rlist:
                serial_data = serial.read(1)
                slip_processor.append(serial_data)
                slip_packets=slip_processor.decode()
                for packet in slip_packets:
                        udp_socket.sendto(packet,udp_client_address)        
                    
        if udp_socket in rlist:
                udp_data,udp_client = udp_socket.recvfrom(MAX_UDP_PACKET)
                slip_data=slip_processor.encode(udp_data)
                serial.write(slip_data)
                serial.flush()
                udp_client_address=(udp_client[0],UDP_PORT_OUT)
                time.sleep(0.001) #avoid flooding the microcontroller (to be controlled)
                

        



