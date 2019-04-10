class Population {
  
  Agent agents[];
  
  Population(TypeGoods type, int sizePop) {
    agents = new Agent[sizePop];
    for (int i = 0; i < sizePop; i++) {
      agents[i] = new Agent(type);
    }
  }

  void update() {
    for (Agent a : agents) {
      a.update();
    }
  }

  void network() {
    for (int i = 0; i < agents.length; i++) {
      for (int j = 0; j < i; j++) {
        Agent a = agents[i];
        Agent b = agents[j];
        if (i != j && a.distAgent(b) <= DIST_AGENT) {
          a.interact(b);
        }
      }
    }
  }

  void drawPopulation() {
    for (Agent a : agents) {
      a.drawFieldOfVision();
    }
    for (Agent a : agents) {
      a.drawAgent();
    }
  }

  void drawNetwork() {
    PVector a, b;
    for (int i = 0; i < agents.length; i++) {
      for (int j = 0; j < i; j++) {
        a = agents[i].engine.position;
        b = agents[j].engine.position;
        if (i != j && a.dist(b) <= DIST_AGENT) {
          stroke(50, 128);
          line(a.x, a.y, b.x, b.y);
        }
      }
    }
  }
}
