import peasy.*;

PeasyCam cam;
Torus t;
int W = 200;
int H = 100;
float wrinkle = 100;
float Da = 1.0;
float Db = 0.5;
float f = 0.0545;
float K = 0.062;
float dt = 1.0;
float s = 0, z = 0;

void setup() {
  size(800, 600, P3D);
  colorMode(HSB, 1);
  cam = new PeasyCam(this, 100);
  cam.setMinimumDistance(1000);
  cam.setMaximumDistance(3000);
  t = new Torus(600, 300, W, H);
}

void draw() {
  background(0);
  t.update();
  t.drawTorus();
}

void keyPressed() {
  t = new Torus(600, 300, W, H);
}