class Engine {

  private PVector position, velocity, acceleration;

  Engine() {
    position = PVector.random2D();
    acceleration = new PVector(0, 0);
    position.mult(random(0, DIAMETER_PETRI/2) - AGENT_SIZE);
    velocity = PVector.random2D();
  }

  void update() {
    acceleration.add(PVector.random2D().mult(0.1));
    acceleration.setMag(5);
    velocity.add(acceleration.mult(dt));
    velocity.setMag(10);
    position.add(PVector.mult(velocity, dt));
    position.limit((DIAMETER_PETRI - AGENT_SIZE) * 0.5);
    if (position.mag() > 0.45 * DIAMETER_PETRI) {
      velocity.add(PVector.mult(position, -0.1 * dt));
    }
  }
}
