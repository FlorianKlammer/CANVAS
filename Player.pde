class Player{
  TuioCursor myCursor;

  float cursorX;
  float cursorY;

  float xPos;
  float yPos;
  float mySize;
  color myColor;
  
  float spring = 0.5;
  float friction = 0.45;
  float v = 0.5;
  float r = 0;  

  float vx = 0;
  float vy = 0;

  int splitNum = 20;
  int diff = 8;
  
  float oldR = 0;
  float oldX = 0;
  float oldY = 0;


  Player(TuioCursor tc){
    myCursor = tc;
    mySize = default_player_size * SF;
    myColor = randomColor(c_palette);

    xPos = myCursor.getScreenX(int(DS_WIDTH)) * SF;
    yPos = myCursor.getScreenY(int(DS_HEIGHT)) * SF + DS_HEIGHT*SF;

    
  }
  
  // void update(){
  //   xPos = myCursor.getScreenX(int(DS_WIDTH)) * SF;
  //   yPos = myCursor.getScreenY(int(DS_HEIGHT)) * SF + DS_HEIGHT*SF;
  //   ellipseMode(CENTER);
  //   fill(myColor);
  //   ellipse(xPos, yPos, mySize, mySize);
  //   ellipse(xPos, yPos-DS_HEIGHT*SF, mySize, mySize);
  // }


void update(){
  cursorX = myCursor.getScreenX(int(DS_WIDTH)) * SF;
  cursorY = myCursor.getScreenY(int(DS_HEIGHT)) * SF + DS_HEIGHT*SF;


  vx += (cursorX - xPos) * spring;
  vy += (cursorY - yPos) * spring;
  vx *= friction;
  vy *= friction;

  // Function 
  v += sqrt( vx*vx + vy*vy) - v;
  v *= 0.6;

  oldR = r;
  r = mySize - v;

  if(r < 1){
    r = 1;
  }


  for(int i = 0; i < splitNum; i++){
    oldX = xPos;
    oldY = yPos;

    xPos += vx/splitNum;
    yPos += vy/splitNum;

    oldR += (r-oldR)/splitNum;

    if(oldR < 1) {
      oldR = 1;
    }
    stroke(myColor);

    strokeWeight(oldR + diff); 
    line(xPos,yPos,oldX,oldY);
    line(xPos,yPos - DS_HEIGHT*SF, oldX, oldY - DS_HEIGHT*SF);

    strokeWeight(oldR);
    line(xPos+diff*2,yPos+diff*2,oldX+diff*2,oldY+diff*2);
    line(xPos+diff*2,yPos - DS_HEIGHT*SF + diff*2, oldX+diff*2, oldY - DS_HEIGHT*SF+diff*2);

    line(xPos-diff,yPos-diff,oldX-diff,oldY-diff);
    line(xPos-diff,yPos - DS_HEIGHT*SF-diff, oldX-diff, oldY - DS_HEIGHT*SF-diff);



  }

  


}

  void setSize(float sizeChange){
    mySize = mySize+sizeChange;

    if(mySize < 30){
      mySize = 30;
    }
    
    if(mySize > 200){
      mySize = 200;
    }
  }

  void setColor(color newColor){
    myColor = newColor;
  }

}
