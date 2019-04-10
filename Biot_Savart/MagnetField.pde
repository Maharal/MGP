class MagnetField {
  
  Particle particles[];
  
  MagnetField(ArrayList<PVector> wire) {
    particles = new Particle[NUM_PARTICLES];
    for (int i = 0; i < NUM_PARTICLES; i++) {
      particles[i] = new Particle(wire.get(int(random(0, wire.size()-1))));
    }
  }
  
  void update(ArrayList<PVector> wire) {
    for (Particle p : particles) {
      p.update(wire);
      if(p.t > SIZE_TRACE*2) {
        p.reset(wire);
      }
    }
  }

  void drawMagnetField() {
    for (Particle p : particles) {
      p.drawTrace();
    }
  }
}