import processing.sound.*;
import peasy.*;

PeasyCam cam;

ArrayList<Boid> boids;

void setup() {
   
  fullScreen(P3D);  
  colorMode(HSB, 1);

  cam = new PeasyCam(this, 1000);
  cam.setMinimumDistance(500);
  cam.setMaximumDistance(3500);
  
  boids = new ArrayList<Boid>();
  for (int i = 0; i < 600; i++) {
    boids.add(new Boid());
  }
}

void draw() {
  background(0);
  for(Boid b : boids) {
    b.update(boids);
    b.draw();
  } 
}
