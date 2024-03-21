/* 
class Palette{
    color[] colors;
    color[] backgrounds = new color[2];

    
    Palette(String choice){
        if(choice.equals('bw')){
            colors = {
                #FFFFFF,
                #000000
            };
        }
        else if(choice.equals('monochrome')){
            colors = {
                #FFFFFF,
                #c0c0c0,
                #808080,
                #404040,
                #000000
            };
        }
        else if(choice.equals('random')){
            colors = new color[50];

            for(int i = 0; i < 50; i++){
                colors[i] = color(random(0,255),random(0,255),random(0,255))
            }

        }
        else if(choice.equals('p1')){
            colors = {
                #00202e,
                #003f5c,
                #2c4875, 
                #8a508f,
                #bc5090,
                #ff6361,
                #ff8531,
                #ffa600,
                #ffd380
            };
        }

        else if(choice.equals('p2')){
            colors = {
                #1abc9c,  
                #16a085,  
                #2ecc71,  
                #27ae60,  
                #3498db, 
                #2980b9,  
                #9b59b6, 
                #8e44ad,  
                #34495e,  
                #2c3e50,  
                #f1c40f,  
                #f39c12,  
                #e67e22,  
                #d35400,  
                #e74c3c,  
                #c0392b,  
                #ecf0f1,  
                #bdc3c7,  
                #95a5a6, 
                #7f8c8d
            }
        }
    
    }

    color getRandomColor(){
        int choice = (int) random(0,colors.length);

        return colors[choice];
    }

}

*/