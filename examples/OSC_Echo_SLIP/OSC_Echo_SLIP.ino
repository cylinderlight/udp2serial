

#include <OSCMessage.h>
#include <SLIPEncodedSerial.h>
SLIPEncodedSerial SLIPSerial(Serial1);

void setup() {
    SLIPSerial.begin(250000);   //this is the standard speed on the Yun
    Serial.begin(115200); // to  debug on usb port
}

void loop(){
    OSCMessage msg,msgOut;
    int l;
    byte s;

    while(!SLIPSerial.endofPacket())
        if( (l =SLIPSerial.available()) > 0)
        {
            while(l--){
              s=SLIPSerial.read();
              msg.fill(s);
              //Serial.println(s);
            }
        }

    if(!msg.hasError())
    { 
      //Serial.prinln("OK");
       SLIPSerial.beginPacket(); // mark the beginning of the OSC Packet       
        msg.send(SLIPSerial);
        SLIPSerial.endPacket();  
    }
}

