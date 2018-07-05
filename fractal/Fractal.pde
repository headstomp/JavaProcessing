ArrayList<PVector> path;

float angle = 0;
int resolution = 50;
int count = 5;

Orbit suns[];
Orbit end;
void setup() {
  size(600, 600);
  path = new ArrayList<PVector>();
  suns = new Orbit[count];
  for(int i = 0 ; i < count; i++){
    suns[i] = new Orbit(width/2, height/2, width/4, 0, (i*2*PI)/count);
    
    suns[i].addChildren(10);
  }
 /* for (int i = 0; i < 10; i++) {
    next = next.addChild();
  }*/
  //end = next;
}

void draw() {
  background(51);
  for (int i = 0; i < resolution; i++) {
    for (Orbit sun: suns) sun.update();
  }
  for (Orbit sun: suns)sun.show();
 
}
