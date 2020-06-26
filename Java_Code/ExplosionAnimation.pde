//class for displaying an explosion.


public class ExplosionAnimation{
  
  private float x,y, size, scalingFactor, scaling;
  private float startTime, msDuration;
  private color hue;
  private int hueInc;
  private boolean increase, implode;

  public ExplosionAnimation(FCircle bullet,  float startTime){
      // time= millis();
      x = bullet.getX();
      y = bullet.getY();
      hue = bullet.getFillColor();
      size = bullet.getSize();
      scalingFactor = 0.2;
      scaling= 1;
      msDuration = 500;
      increase = true;
      this.startTime = startTime;
      implode = true;
      hueInc = 0;
      // start();
     
  }

  private void draw(){

    fill(hue+color(0,hueInc+=4,0));
    noStroke();
    pushMatrix();
    translate(x, y);
    float perc= (float)(millis()-startTime)/msDuration;
    if(millis()-startTime<500){
      scale(scaling+=(easeQuadraticInOut(perc)*(scalingFactor)));
    }else if (millis()-startTime<1000){
      perc = 1-perc;
      scale(scaling-=(easeQuadraticInOut(perc)*(scalingFactor+1)));
    }
    else{
      implode = false;
    }
    ellipse(0,0,size,size);
    popMatrix();
  }

  private boolean on() {return implode;}


  float easeQuadraticInOut(float t)
    {
      float sqt= t*t;
      return sqt / (2.0f * (sqt-t) + 1.0f);
    }
}  

