import peasy.*;
PeasyCam cam;

final float DELTA_T = 0.002;
final int LENGTH_PATH = 50;
System particulas;

void setup() {
  size(800, 600, P3D);
  noFill();
  frameRate(1000);
  cam = new PeasyCam(this, 100);
  cam.setMinimumDistance(100);
  cam.setMaximumDistance(4000);
  particulas = new System(1000, 0.1);
}

void draw() {
  background(0);
  
  particulas.update();
  particulas.drawAll(120);
  stroke(255);
}
