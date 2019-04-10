class Particle {
  PVector position;
  PVector path[];
  color c;
  Particle(float x, float y, float z) {
    position = new PVector(x, y, z);
    path = new PVector[LENGTH_PATH];
    for (int i = 0; i < path.length; i++) {
      path[i] = new PVector(x, y, z);
    }
    c = color(x * 1280 + 128, y * 1280 + 128, z * 1280 + 128);
  }
  void varies(PVector g) {
    for (int i = path.length-1; i > 0; i--) {
      path[i] = path[i-1];
    }
    path[0] = position.copy();
    position.add((g.copy()).mult(DELTA_T));
  }
  void drawParticle(float s) {

    strokeWeight(2);
    for (int i = 1; i < path.length; i++) {
      stroke(c, (1 - (float) i / path.length) * 256);
      strokeWeight((0.333 + (float) i / path.length) * 3);
      line(path[i-1].x*s, path[i-1].y*s, path[i-1].z*s, path[i].x*s, path[i].y*s, path[i].z*s);
    }
  }
}
