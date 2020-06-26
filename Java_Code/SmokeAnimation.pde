//class for displaying an a smoke trail of a tank


public class SmokeAnimation{
  
  private float x,y;
  private color hue;
  private PVector p1, p2, p3;
  private float radius;
  String status;
  int deathFrame;


  public SmokeAnimation(PVector loc, color col){

      hue = col;
      status = "spawning";
      deathFrame = frameCount;
      x = loc.x;
      y = loc.y;
      radius = 20;
      // p1 = new PVector(x+random(-5, 6), y+random(-5, 6));
      // p2 = new PVector(x+random(-5, 6), y+random(-5, 6));
      // p3 = new PVector(x+random(-5, 6), y+random(-5, 6));
     
  }
  void update() {
    if (status == "spawning") {
      radius += 3/radius;
      if (frameCount - deathFrame == 10) {
        status = "dead";
      }
    } else if (status == "dead") {
      radius--;
      if (radius <= 0) {
        status = "removable";
      }
    }
  }

  void frUpd(){
    deathFrame = frameCount;
  }
  private void draw(PVector locUpd) {
    x = locUpd.x;
    y = locUpd.y;
    p1 = new PVector(x+random(-32, 33), y+random(-32, 33));
    p2 = new PVector(x+random(-32, 33), y+random(-32, 33));
    p3 = new PVector(x+random(-32, 33), y+random(-32, 33));
    fill(color(100,100,100));
    ellipse(p1.x, p1.y, radius*2, radius*2);
    ellipse(p2.x, p2.y, radius*2, radius*2);
    ellipse(p3.x, p3.y, radius*2, radius*2);
    println("smoke");
    // drawShadow();
  }

  private void drawShadow() {
    pushMatrix();
    translate(8,8);
    ellipse(p1.x, p1.y, radius*2, radius*2);
    ellipse(p2.x, p2.y, radius*2, radius*2);
    ellipse(p3.x, p3.y, radius*2, radius*2);
    popMatrix();
  }

  // public Smoke(float x, float y, int h) {
  //   super(x, y);
  //   radius = 1;
    
    
  //   hue = h;
  //   point1 = new PVector(pos.x+random(-20, ), pos.y+random(-20, 20));
  //   point2 = new PVector(pos.x+random(-5, 6), pos.y+random(-5, 6));
  //   point3 = new PVector(pos.x+random(-5, 6), pos.y+random(-5, 6));
  // }

  // void update() {
  //   if (status == "spawning") {
  //     radius += 3/radius;
  //     if (frameCount - deathFrame == 10) {
  //       status = "dead";
  //     }
  //   } else if (status == "dead") {
  //     radius--;
  //     if (radius <= 0) {
  //       status = "removable";
  //     }
  //   }
  // }

  // void draw() {
  //   fill(hue,100,250-frameCount/2 + deathFrame/2);
  //   ellipse(point1.x, point1.y, radius*2, radius*2);
  //   ellipse(point2.x, point2.y, radius*2, radius*2);
  //   ellipse(point3.x, point3.y, radius*2, radius*2);
  // }


}