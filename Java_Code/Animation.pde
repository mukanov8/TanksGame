//class for displaying an explosion.

//technically, it is not animation, since I decided to use 
//only one frame from the spritesheet.

public class Animation  {
  
private PImage spriteSheet;
private PImage aniArray[][];
private float timeI;
private boolean draw = true;

public Animation(){
   setupSprites();
}

void setupSprites(){
  aniArray = new PImage[6][6];
  spriteSheet = loadImage("data/spritesheet.png");
  for(int j =0; j<6; j++){
    for(int i =0; i<6; i++){
      aniArray[j][i] = spriteSheet.get(i*100, i*100, 100, 100);
    }
  }
}

void drawAnimation(float x, float y){
    
    // if(timeI<6&&draw==true){
      // if(timeI>5) draw = false;
      image (aniArray[0][2] ,x ,y);
      // (int)timeI
      // updateTime();
    // }
}
  
// void updateTime(){ timeI = (timeI+0.18) % 6; }


}