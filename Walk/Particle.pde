class Particle {

  PVector position;
  private ArrayList<PVector> path;
  private boolean up;
  private color c;
  
  Particle(PVector p) {
    position = p;
    path = new ArrayList<PVector>();
    up = false;
    if (up) {
      c = color(random(200, 255), 20, random(50, 80));
    } else {
      c = color(random(10, 30), random(90, 130), random(240, 255));
    }
  }
  
  void updateParticle(PVector g) {
    position.add((g.copy()).mult(dt * (up ? 1 : -1)));
    position.z = f(position.x, position.y);
    path.add(position.copy());
    if (path.size() > PATH_SIZE) {
      path.remove(0);
    }
  }
  
  private void drawPath() {
    for (int i = 1; i < path.size(); i++) {
      stroke(c, (float) i/PATH_SIZE * 256.0);
      line(
          path.get(i).x
        , path.get(i).y
        , path.get(i).z
        , path.get(i-1).x
        , path.get(i-1).y
        , path.get(i-1).z
      );
    }
  }
    
  void drawParticle() {
    strokeWeight(2);
    drawPath();
    stroke(c);
    strokeWeight(3);
    point(position.x, position.y, position.z);
  }
  
  boolean border() {
    return (position.x > a) && (position.x < b) && (position.y > a) && (position.y < b);
  }
  
}
