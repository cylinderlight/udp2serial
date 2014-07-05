
// Marco Brianza
// May 15 2014

#include <OSCMessage.h>
#include <SLIPEncodedSerial.h>

#define OUT_PIN 13

SLIPEncodedSerial SLIPSerial(Serial1); //connection with Yun

// ---------------------------------------

void setup(){  
 SLIPSerial.begin(250000);   //this is the standard speed on the Yun
 Serial.begin(115200); // to  debug on usb port
}
  
// ----------------------------------------  

  
void loop(){
OSCMessage msg;  
int s;

if (SLIPSerial.available()){
while(!SLIPSerial.endofPacket())
//Serial.println("new");
      if( (s =SLIPSerial.available()) > 0)
      
      {
       while(s--)
       msg.fill(SLIPSerial.read());
      }
        if(!msg.hasError())
        {
          msg.dispatch("/led/13",led_13); 
          
          }
     }           
} // end main---------------------


 
 //------------------------
 
 void led_13(OSCMessage &msg)
 {
     float r=msg.getFloat(0); 
     int R=int(r*2.55);
     if (R>255) R=255;
     if (R<0) R=0;
     
//     Serial.print("/All/R");
//     Serial.println(R);
   analogWrite(OUT_PIN,R);
     
   msgReply(R);  
 }
 

void msgReply(float ledI){
 OSCMessage msg("/reply");   
  msg.add(ledI);
  SLIPSerial.beginPacket(); // mark the beginning of the OSC Packet       
  msg.send(SLIPSerial);
  SLIPSerial.endPacket(); 
  msg.empty();
}


  
 
 



