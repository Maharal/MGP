interface INode {
  void draw();
  void update();
}

class Node implements INode {
  
  INode nodes[];  

  Node() {
    nodes = new Node[8];
  }
  
  void update() {
    for (INode n : nodes) {
      n.update();
    }
  }
  
  void draw() {
    for (INode n : nodes) {
      n.draw();
    }
  }
}

class Leaf implements INode {
  
  ArrayList<Boid> boids;
  
  Leaf() {
    boids = new ArrayList<Boid>();
  }
  
  void update() {
    for (Boid b : boids) {
      b.update(boids);
    }
  }
  
  void draw() {
    for (Boid b : boids) {
      b.draw();
    }
  }
}
