class Agent {

  private color type;
  private Backpack bp;
  private Engine engine;

  Agent(TypeGoods t) {
    engine = new Engine();
    type = t.getType(); 
    bp = new Backpack(t, type);
  }

  void update() {
    engine.update();
  }
  
  float distAgent(Agent a) {
    PVector position = engine.position;
    PVector aposition = engine.position;
    return dist(position.x, position.y, aposition.x, aposition.y);
  }

  void interact(Agent a) {
  }
  
  void drawAgent() {
    PVector position = engine.position;
    PVector velocity = engine.velocity;
    pushMatrix();
    translate(position.x, position.y);
    noStroke();
    fill(type);
    ellipse(0, 0, AGENT_SIZE, AGENT_SIZE);
    fill(#FFFFFF);
    float teta = atan2(velocity.y, velocity.x);
    float radius = 0.2 * AGENT_SIZE;
    triangle(1.5 * radius * cos(teta), 1.5 * radius * sin(teta), 
      radius * cos(teta + (float)TWO_PI/3), radius * sin(teta + (float)TWO_PI/3), 
      radius * cos(teta + (float)2/3 * TWO_PI), radius * sin(teta + (float)2/3 * TWO_PI));
    popMatrix();
  }

  void drawFieldOfVision() {
    PVector position = engine.position;
    PVector velocity = engine.velocity;
    float teta = atan2(velocity.y, velocity.x);
    noStroke();
    fill(0, 32);
    arc(position.x, position.y, VF_COEF * AGENT_SIZE, VF_COEF * AGENT_SIZE, teta-ANGLE, teta+ANGLE);
  }
}
