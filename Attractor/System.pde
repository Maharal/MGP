class System {
  Particle particles[];
  System(int number, float varies) {
    particles = new Particle[number];
    for (int i = 0; i < number; i++) {
      particles[i] = new Particle(
        randomGaussian() * varies, 
        randomGaussian() * varies, 
        randomGaussian() * varies
        );
    }
  }
  void update() {
    for (int i = 0; i < particles.length; i++) {
      particles[i].varies(halvorsen(particles[i].position));
    }
  }
  void drawAll(float escala) {
    
    for (int i = 0; i < particles.length; i++) {
      particles[i].drawParticle(escala);
    }
  }
}
