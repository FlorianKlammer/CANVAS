// --------------------------------------------------------------
// these callback methods are called whenever a TUIO event occurs
// there are three callbacks for add/set/del events for each object/cursor/blob type
// the final refresh callback marks the end of each TUIO frame

// --------------------------------------------------------------
// called when a cursor is added to the scene
void addTuioCursor(TuioCursor tcur) {
  playerList.add(new Player(tcur));
}

// called when a cursor is moved
void updateTuioCursor (TuioCursor tcur) {
 
}

// called when a cursor is removed from the scene
void removeTuioCursor(TuioCursor tcur) {
    for(int i=playerList.size()-1; i>=0; i--){
      Player tPl = playerList.get(i);
      if(tPl.myCursor == tcur) playerList.remove(i);
    }
}

// called when an object is added to the scene
void addTuioObject(TuioObject tobj) {
  
}

// called when an object is moved
void updateTuioObject (TuioObject tobj) {
  
}

// called when an object is removed from the scene
void removeTuioObject(TuioObject tobj) {
  
}



// --------------------------------------------------------------
// called when a blob is added to the scene
void addTuioBlob(TuioBlob tblb) {
  
}

// called when a blob is moved
void updateTuioBlob (TuioBlob tblb) {
 
}

// called when a blob is removed from the scene
void removeTuioBlob(TuioBlob tblb) {
 
}

// --------------------------------------------------------------
// called at the end of each TUIO frame
void refresh(TuioTime frameTime) {
  
}
