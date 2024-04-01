// TODO: Create Eraser, Invisibility and Chameleon Pickup
// TODO: Add Start State where Players can choose a Palette
// TODO: Add Start State where Players can choose a Background Color
// TODO: Create a Pickupgenerator Class thats creating different Pickups determined by the Palette
// TODO: Change Size Pickup Effectiveness
// TODO: Fix Bleeding into the Edge
// TODO: (Lasch) Add Music
// TODO: (Lasch) Add Sound Effects
// TODO: coole Animations


// TODO: Sound Settings, Physics Settings
// TODO: Color Palette
// TODO: TouchOSC Reset / Save Image





import TUIO.*;
import java.util.HashMap;
import oscP5.*;
import processing.sound.*;

TuioProcessing tuioClient;

OscP5 oscP5;
int oscPort = 8000;
boolean oscReset = false;
boolean oscCPickup = false;

SoundFile music;
SoundFile sfx;

float SF = 0.25;   ///Declaration and Initialization of a variable


float DS_HEIGHT = 2160; ///This is the height of the wall and the
                        ///height of the floor
float DS_WIDTH = 3840;

float default_player_size;
float default_pickup_size;
float default_size_change;

int pickupLimit;


XML xml;

ArrayList<Player> playerList;
HashMap<Integer, Pickup> pickupMap;
ArrayList<Integer> keysToRemove = new ArrayList<Integer>();
int maxKey = 1; // Continously increasing value used for creating ids in the pickupMap

// Colors
color bg =  #eae3d0;

color[] c_palette = {
  #FFFFFF,
  #000000,
  #b91c1c,
  #ea580c,
  #7c2d12,
  #fcd34d,
  #a3e635,
  #365314,
  #34d399,
  #14b8a6,
  #67e8f9,
  #0284c7,
  #6d28d9,
  #f472b6,
  #e11d48
}; 

color randomColor(color[] palette) {
  color c;

  int choice = (int) random(palette.length);

  c = palette[choice];

  return c;
}


void settings(){
  xml = loadXML("settings.xml");
  SF = xml.getFloat("scaleFactor");
  println(SF);
  
  default_player_size = xml.getFloat("playerSize");
  default_pickup_size = xml.getFloat("pickupSize");
  default_size_change = xml.getFloat("sizeChange");
  pickupLimit = xml.getInt("pickupLimit");

  int isFullScreen = xml.getInt("isFullscreen");
  
  if(isFullScreen == 0){
    size(int(DS_WIDTH*SF), int(DS_HEIGHT*2*SF));
  }
  else{
    fullScreen(SPAN);
  }
}

void setup(){
  oscP5 = new OscP5(this,oscPort);

  music = new SoundFile(this, "sound/CANVAS_Soundtrack.mp3");
  music.amp(0.8);
  music.loop();


  sfx = new SoundFile(this, "sound/sine_pluck.wav");

  tuioClient  = new TuioProcessing(this);
  playerList = new ArrayList<Player>();


  // Canvas Setup
  noStroke(); 
  fill(bg);
  rect(0,0,width,height/2);
  fill(bg);
  rect(0,height/2, width, height);

  //Initialize Pickups
  pickupMap = new HashMap<Integer, Pickup>();

  for(int i = 0; i < 12; i++){
    pickupMap.put(maxKey, addPickup());
    maxKey++;
  }

  displayPickups();
  
}

void draw(){
  
  
  for(int i=playerList.size()-1; i>=0; i--){
    Player tPl = playerList.get(i);

    //Loop through all Pickups

    for(int j : pickupMap.keySet()){
      Pickup pickup = pickupMap.get(j);

      if(pickup.collision(tPl)){
        keysToRemove.add(j);
        changeBrushSettings(pickup, tPl);
        sfx.play();
      }

      else if(pickup.getFrameCreated()+1200<frameCount){
        keysToRemove.add(j);
      }
    }

    tPl.update();
  }

  //Remove Pickups marked for removal
  for(int key : keysToRemove){
    pickupMap.remove(key);
  }

  // Add new Pickups
  if( (frameCount % 120 == 0 && pickupMap.size()<= pickupLimit) || pickupMap.size() < 2){
    pickupMap.put(maxKey, addPickup());
    maxKey += 1;
  }


  displayFade();
  displayPickups();

  if(oscReset){
    resetCanvas();
    oscReset = false;
  }

  if(oscCPickup){
    pickupMap.put(maxKey, addPickup());
    maxKey += 1;
    oscCPickup = false;
  }

  
}

void displayFade(){
  fill(bg,80);
  noStroke();

  rect(0,height/2, width, height);

}

void displayPickups(){
  for(int i : pickupMap.keySet()){
    pickupMap.get(i).display();
  }
}


void changeBrushSettings(Pickup pickup, Player tPl){

  if(pickup instanceof ColorPickup){
    ColorPickup colorPickup = (ColorPickup) pickup;

    tPl.setColor(colorPickup.getColor());
  }

  if(pickup instanceof SizePickup){
    SizePickup sizePickup = (SizePickup) pickup;

    tPl.setSize(sizePickup.getSizeChange());
  }

}

// Return Random Pickup
Pickup addPickup(){
  int choice = (int) random(0,2); 

  Pickup p = new ColorPickup();

  // if(choice==0){
  //   p = new ColorPickup();
  // }
  // else{
  //   p = new SizePickup();
  // }

  return p;

}

void resetCanvas(){
  noStroke();
  rectMode(CORNER);
  fill(bg);
  rect(0,0,width,height/2);
}


void oscEvent(OscMessage theOscMessage) {
  println("### received an osc message.");
  
  if(theOscMessage.addrPattern().equals("/Basic/reset") && theOscMessage.get(0).floatValue()==1.0){
    oscReset = true;
  }

  if(theOscMessage.addrPattern().equals("/Basic/spawn_color") && theOscMessage.get(0).floatValue()==1.0){
    oscCPickup = true;
  }

}