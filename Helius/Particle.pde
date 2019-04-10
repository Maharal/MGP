class Particle {
  
  private ArrayList<PVector> path;
  private PVector position;
  private PVector acceleration;
  private PVector velocity;
  private color hue;
  private float radius;
  private float mass;
  private int SIZE_PATH;
  
  Particle(PVector p, PVector v, float r, float m, color h, int size) {
    path = new ArrayList<PVector>();
    acceleration = new PVector(0,0,0);
    position = p;
    velocity = v;
    hue = h;
    radius = r;
    mass = m;
    SIZE_PATH = size;
  }

  void applyForces(PVector f) {
    acceleration.add((f.copy()).div(mass));
  }
  
  void gravityInteraction(Particle x) {
    PVector r = (x.position.copy()).sub(position);
    float R = r.mag();
    acceleration.add(r.mult(G * x.mass / (R * R * R)));
  }

  void update() {
    velocity.add((acceleration.copy()).mult(dt));
    position.add((velocity.copy()).mult(dt));
    acceleration.mult(0);
    path.add(position.copy());
    if (path.size() > SIZE_PATH) {
      path.remove(0);
    }
  }

  void drawPath()  {
    strokeWeight(2);
    for (int i = 1; i < path.size(); i++) {
      stroke(hue, (float) i/path.size() * 256.0);
      line(
        path.get(i).x, 
        path.get(i).y, 
        path.get(i).z, 
        path.get(i-1).x, 
        path.get(i-1).y, 
        path.get(i-1).z 
      );
    }
  }
  
  void drawParticle() {
    drawPath();
    pushMatrix();
    fill(hue);
    noStroke();
    translate(position.x, position.y, position.z);
    sphere(radius);
    noFill();
    popMatrix();
  }
}