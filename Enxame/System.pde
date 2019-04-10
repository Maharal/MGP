class System {
  
  Agent system[];
  
  System(int num) {
    system = new Agent[num];
    for (int i = 0; i < num; i++) {
      system[i] = new Agent();
    }
  }

  void distribute(float d) {
    float dE;
    for (int i = 0; i < system.length; i++) {
      for (int j = 0; j < i; j++) {
        if (system[i].pos.dist(system[j].pos) <= d && system[i].energy > 0 && system[j].energy > 0) {
          dE = abs(N * (system[i].energy - system[j].energy) * dt);
          stroke(#F0F0F1, dE * 10000);
          line(system[i].pos.x, system[i].pos.y, system[j].pos.x, system[j].pos.y);
          if (system[i].energy > system[j].energy) {
            system[i].energy -= dE;
            system[j].energy += dE;
          } else {
            system[i].energy += dE;
            system[j].energy -= dE;
          }
        }
      }
    }
  }
  
  void update() {
    for (int i = 0; i < system.length; i++) {
      system[i].update();
    }
  }

  void drawAgents() {
    noStroke();
    for (int i = 0; i < system.length; i++) {
      system[i].drawAgent();
    }
  }
}