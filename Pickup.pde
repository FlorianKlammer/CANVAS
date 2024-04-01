class Pickup{
    float x,y;
    float size;
    int frameCreated;

    Pickup(){
        x = int(random(default_pickup_size*SF, width));
        y = int(random(height/2+default_pickup_size*SF, height-default_pickup_size*SF));
        size = default_pickup_size*SF;
        frameCreated = frameCount;
    }

    void display(){
        noStroke();
        fill(255);
        ellipse(x,y,size*SF,size*SF);
    }

    boolean collision(Player p){
        boolean b;
        
        float distX = p.xPos - x;
        float distY = p.yPos - y;
        float distance = sqrt( (distX*distX) + (distY*distY) );


        if( distance <= (p.mySize/2) + (size/2) ){
            b = true;
        }
        else{
            b = false;
        }
        

        return b;
    }

    int getFrameCreated(){
        return frameCreated;
    }




}


//FIX
/* class PalettePickup extends Pickup{
    String choice;
    Palette palette;


    PalettePickup(float temp_x, float temp_y, String choice){
        size = default_pickup_size*SF;

        x = temp_x;
        y = temp_y;

        palette = new Palette(choice);
    }

    Palette getPalette(){
        return palette;
    }

    @Override void display(){
        
    }
}

*/

class ColorPickup extends Pickup{
    color myColor;

    ColorPickup(){
        super();

        myColor = randomColor(c_palette);
    }

    ColorPickup(color c){
        super();

        myColor = c;
    }

    @Override void display(){
        noStroke();
        fill(myColor);
        ellipse(x,y,size, size);
        fill(bg);
        ellipse(x,y,size*0.9, size*0.9);
        fill(myColor);
        ellipse(x,y,size*0.7, size*0.7);
    }

    color getColor(){
        return myColor;
    }
}


class SizePickup extends Pickup{
    float sizeChange;

    boolean b = true; //Used for animation in display
    int animationFrames = 180;


    SizePickup(){
        super();

        int choice = (int) random(0,2);

        sizeChange = default_size_change * SF;
        
        if(choice==1){
            sizeChange = -sizeChange;
        }

    }

    @Override void display(){

        noStroke();
        fill(255);
        ellipse(x,y,size,size);

        float temp_size = size * 0.8;
        float start,end;

        if(sizeChange>0){
            start = 0;
            end = 1;
        }
        else{
            start = 1;
            end = 0;
        }

        float fraction = map(frameCount%animationFrames, 0, animationFrames-1, start, end);

        if(b){
            fill(255);
            ellipse(x,y,temp_size, temp_size);
            fill(0);
            ellipse(x,y,temp_size*fraction, temp_size*fraction);
        }
        else{
            fill(0);
            ellipse(x,y,temp_size, temp_size);
            fill(255);
            ellipse(x,y,temp_size*fraction, temp_size*fraction);
        }


        if((frameCount+1)%animationFrames==0){
            b = !b;
        }
        


    }

    float getSizeChange(){
        return sizeChange;
    }

}

