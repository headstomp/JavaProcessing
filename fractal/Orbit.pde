import java.util.ArrayDeque;

int k = -4;

class Orbit {
  float x;
  float y;
  float r;
  int n;
  Orbit parent;
  Orbit child;
  float speed;
  float angle;
  ArrayDeque<PVector> points;

  Orbit(float x_, float y_, float r_, int n_, float angle_) {
    this(x_, y_, r_, n_, null, angle_);
  }

  Orbit(float x_, float y_, float r_, int n_, Orbit p, float angle_) {
    x = x_;
    y = y_;
    r = r_;
    n = n_;
    speed = (radians(pow(k, n-1)))/resolution;
    parent = p;
    child = null;
    angle = angle_;
  }
  
  void addChildren(int n){
    if (n > 1){
    addChild();
    this.child.addChildren(n-1);
    }
    else{
      this.points = new ArrayDeque<PVector>();
    }
  };

  Orbit addChild() {
    float newr = r / 3.0;
    float newx = x + (r + newr)*sin(this.angle);
    float newy = y + (r + newr)*cos(this.angle);
    child = new Orbit(newx, newy, newr, n+1, this,angle);
    return child;
  }

  void update() {
    if (parent != null) {
      angle += speed;
      float rsum = r + parent.r;
      x = parent.x + rsum * cos(angle);
      y = parent.y + rsum * sin(angle);
    }
    if (this.child != null) this.child.update();
    if(this.points != null){
      if(this.points.size() > 50 * resolution){
        this.points.pop();
      }
      this.points.offer(new PVector(this.x,this.y));
    }
  }

  void show() {
    /*stroke(255, 100);
    strokeWeight(1);
    noFill();
    if (parent != null) {
      line(parent.x, parent.y, x, y);
    }
    ellipse(x, y, r*2, r*2);*/
    if (this.child != null) this.child.show();
    else{
      beginShape();
        stroke(map(this.angle,0,2*PI,0,255),map(this.x,0,600,0,255),map(this.y,0,600,0,255));
        noFill();
      for (PVector v : this.points){
          vertex(v.x,v.y);
      }
      endShape();
    }
  }
}
