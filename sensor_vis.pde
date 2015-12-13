import processing.serial.*;

PImage nasa;
int numOfPics = 9;
int picNum = 0;
PImage[] images = new PImage[numOfPics];

Serial port;
int sval;

void setup() {
  
  String portName = Serial.list()[1];
  println(Serial.list()[1]);
  port = new Serial(this, portName, 9600);
  
  size(640, 394);
  nasa = loadImage("logo-nasa.jpg");
  nasa.resize(640, 394);
  
  for (int i = 0; i < numOfPics; i++) {
    images[i] = loadImage( "pic" + i + ".jpg" );
  }
  
  blendMode(BLEND);
  tint(0, 153, 204, 126);
  filter(INVERT);
  
}

void draw() {
  imageMode(CORNERS);
  //image(nasa, 0, 0);
  background(nasa);
  //image(images[picNum], 0, 0);
  
  //println(port.available());
  if ( port.available() > 0) {
    sval = int(port.read());
    println(sval);
  }
  
  imageMode(CORNERS);
  if (sval > 50) {
    tint(int(random(sval, 255)), int(random(sval, 255)), int(random(sval, 255)), int(random(sval, 255)));
  }
  
  clip(0, 0, width, height);
  image(images[picNum], 0, 0);
  noClip();
  
  clip(width/4, height/4, width*0.75, height*0.75);
  image(images[4], 0, 0);
  noClip();
}

void keyPressed() {
  //println(key, keyCode);
  
  if (key == 'p') {
    if (picNum >= numOfPics-1) {
      picNum = -1;
    }
    picNum++;
  }

}
