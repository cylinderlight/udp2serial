
import oscP5.*;
import netP5.*;

OscP5 oscP5;
NetAddress myRemoteLocation, myRemoteLocationLocal, myRemoteLocationArduino;

void setup() {
  size(200, 200);
  oscP5 = new OscP5(this, 11000);

  myRemoteLocation = new NetAddress("arduino.local", 10000); 
  myRemoteLocationArduino = new NetAddress("arduino.local", 10000);
  myRemoteLocationLocal = new NetAddress("127.0.0.1", 10000);
}

void draw() {
  background(100, 0, 100);
}


void keyPressed() { // click the window to send the OSC message

  switch (key) {
  case 'i':
    send_RGB();
    break;
  case 'b':
    send_rgb_blob();
    break;  
  case 'A':
    myRemoteLocation=myRemoteLocationArduino;
    println("remote address Arduino=",myRemoteLocation);
    break;  
  case 'L':
    myRemoteLocation=myRemoteLocationLocal;
    println("remote address Localhost=",myRemoteLocation);
    break;
  }
} 


void send_rgb_blob() {
  byte[] bb;
  bb=new byte[6];

  bb[0]=81;
  bb[1]=82;
  bb[2]=83;
  bb[3]=84;
  bb[4]=10;
  bb[5]=86;

  OscMessage myMessage = new OscMessage("/new_blob");
  myMessage.add(bb); 

  oscP5.send(myMessage, myRemoteLocation);
}



//--------------------------------------------------------------------------
void send_RGB() {
  OscMessage myMessage = new OscMessage("/new_i");

  myMessage.add(11); 
  myMessage.add(10);
  myMessage.add(13); 

//  println("Outgoing Message:-------");
//  myMessage.print(); 


  oscP5.send(myMessage, myRemoteLocation);
}




/* incoming osc message are forwarded to the oscEvent method. */
void oscEvent(OscMessage theOscMessage) {
  
  print("### received an osc message. ");
  println(hour(),minute(),second());
  theOscMessage.print();

  //this prints correctly only if a message is a blob
  if (theOscMessage.checkTypetag("b")){
     byte[] bb;
     bb=new byte[6];
     bb = theOscMessage.get(0).blobValue();
     println("decoding blob:");
     println(bb[0]);
     println(bb[1]);
     println(bb[2]);
     println(bb[3]);
     println(bb[4]);
     println(bb[5]);
     }
}

