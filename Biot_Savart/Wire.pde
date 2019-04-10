class Wire {
  ArrayList<PVector> wire;
  float t;
  Wire() {
    wire = new ArrayList();
    t = 0;
  }

  void add(PVector point) {
    wire.add(point);
  }

  ArrayList<PVector> get() {
    return wire;
  }

  void update() {
    t -= I;
  }

  void drawWire() {
    PVector pos = wire.get(0);
    PVector aux;
    strokeWeight(3);
    for (int i = 1; i < wire.size(); i++) {
      if ((i + int(t)) % 5 == 0) {
        stroke(DGRAY);
      } else {
        stroke(WHITE);
      }
      aux = pos;
      pos = wire.get(i);
      if (!outOfBox(pos)) {
        line(pos.x, pos.y, pos.z, aux.x, aux.y, aux.z);
      }
    }
  }
}