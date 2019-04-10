class Agent {

  PVector pos;
  PVector vel;
  PVector acc;
  float energy;

  Agent() {
    pos = new PVector(random(width), random(height));
    vel = new PVector(randomGaussian() * 3, randomGaussian() * 3);
    acc = new PVector(randomGaussian(), randomGaussian());
    energy = 255;
  }

  void update() {
    if (energy > 0) {
      acc.limit(0.1);
      vel.add(PVector.mult(acc, dt));  
      vel.setMag(3);
      pos.x = limite(pos.x + vel.x * dt, -5, width+5);
      pos.y = limite(pos.y + vel.y * dt, -5, height+5);
      acc.add(new PVector(randomGaussian(), randomGaussian()));
      energy = energy - rate * dt < 0 ? 0 : energy - rate * dt;
      for (int i = 0; i < NUM_FOOD; i++) {
        if (dist(pos.x, pos.y, food[i].x, food[i].y) < 6) {
          energy = energy + ENERGY;     
          food[i].x = limite(px + randomGaussian() * disp, 0, width);
          food[i].y = limite(py + randomGaussian() * disp, 0, height);
        }
      }
    }
  }

  void drawAgent() {
    if (energy > 0) {
      fill(#FF5349, 230);
      ellipse(pos.x, pos.y, 10, 10);
      stroke(#18CDCA);
      strokeWeight(1);
      noFill();
      ellipse(pos.x, pos.y, energy/15,  energy/15);
      strokeWeight(1.5);
      noStroke();
      
    }
  }
}