import peasy.*;

final float dt = 3;
final float h = 0.001;
final int PATH_SIZE = 50;
final int NUM_PARTICLE = 1000;
final float MIN_MAG = 0.1;
final int a = -500;
final int b = 500;
final int l = 200;
final int step = 10;

ArrayList<Particle> system;
PeasyCam cam;
PVector gradient;

void setup() {
  
  size(displayWidth, displayHeight, P3D);
  noFill();
  
  system = new ArrayList<Particle>();
  for (int i = 0; i < NUM_PARTICLE; i++) {
    system.add(new Particle(new PVector(
        random(a, b)
      , random(a, b)
      , 0 
    )));
  }
  
  cam = new PeasyCam(this, 100);
  cam.setMinimumDistance(100);
  cam.setMaximumDistance(4000);
  
}

void draw() {
  background(10, 10, 10);
  strokeWeight(1);
  stroke(255, 255, 255);
  box(b-a, b-a, l);
  strokeWeight(1.5);
  for (int i = a; i < b; i+=step) {
    for (int j = a; j < b; j+=step) {
      stroke(256.0 - 256.0 * (100.0 + f(i, j))/200.0, 50, 256.0 * (100 + f(i, j))/200.0);
      point(i, j, f(i, j));
    }
  }
  
  for (int i = 0; i < system.size(); i++) {
    gradient = g(system.get(i).position.x, system.get(i).position.y);
    if (gradient.mag() < MIN_MAG || !system.get(i).border()) {
      system.remove(i);
      system.add(new Particle(new PVector(
          random(a, b)
        , random(a, b)
        , 0 
      )));
    } else {
      system.get(i).updateParticle(gradient);
    }
  }
  
  for (int i = 0; i < system.size(); i++) {
    system.get(i).drawParticle();
  }
}

float f(float x, float y) {
  return sin(x/100) * l/4 + cos(y/100) * l/4;
}

float fx(float x, float y) {
  return (f(x + h, y) - f(x, y))/h;
}

float fy(float x, float y) {
  return (f(x, y + h) - f(x, y))/h;
}

PVector g(float x, float y) {
  return new PVector(fx(x, y), fy(x, y), 0);
}