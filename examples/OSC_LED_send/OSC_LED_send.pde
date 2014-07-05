// mtest OSC protocol with linino and udp2serial
// by Marco Brianza May, 15, 2014
import oscP5.*;
import netP5.*;

OscP5 oscP5;
NetAddress myRemoteLocation;

String HOST="arduino.local";

void setup() {
  size(100, 300);
  background(0, 0, 0);
  frameRate(10);
  
  oscP5 = new OscP5(this, 11000);
  myRemoteLocation = new NetAddress(HOST, 10000); 
}

void draw() {
  float v=(1-(float)mouseY/(float)height)*100;
  //println (v);
  background(v*2.55,0,0);
  sendLed(v);   
}

void sendLed(float ledValue){
  OscMessage myMessage = new OscMessage("/led/13");
  myMessage.add(ledValue);
  oscP5.send(myMessage, myRemoteLocation);
}


/* incoming osc message are forwarded to the oscEvent method. */
void oscEvent(OscMessage theOscMessage) {
  print("### received an osc message. ");
  println(hour(),minute(),second());
  theOscMessage.print();
}

