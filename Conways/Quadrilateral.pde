class Quadrilateral {

  PVector a;
  PVector b;
  PVector c;
  PVector d;
  
  Quadrilateral(PVector a, PVector b, PVector c, PVector d) {
    this.a = a;
    this.b = b;
    this.c = c;
    this.d = d;
  }

  void drawQuadrilateral(color f) {
    fill(f);
    beginShape(QUAD_STRIP);
    vertex(a.x, a.y, a.z);
    vertex(b.x, b.y, b.z);
    vertex(c.x, c.y, c.z);
    vertex(d.x, d.y, d.z);
    endShape();
  }
}