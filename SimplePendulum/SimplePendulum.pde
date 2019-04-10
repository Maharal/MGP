final float dt = 0.05;
final float G = 100.0;
float teta, omega, alpha;
float r, l;

void setup() {
  size(600, 600);
  fill(128);
  strokeWeight(1.5);
  omega = 0;
  alpha = 0;
  teta = PI + PI/4;
  l = 250;
  r = 50;
}

void draw() {
  background(#FFFFFF);
  alpha = (G / l) * sin(teta);
  omega += alpha * dt;
  teta += omega * dt;
  translate(width/2, 10);
  line(0, 0, l * sin(teta), -l * cos(teta));
  ellipse(l * sin(teta), -l * cos(teta), r, r);
}