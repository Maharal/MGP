class Particula {

  float px, py;
  float vx, vy;
  float ax, ay;
  float gx, gy;

  Particula(float x, float y) {
    vx = ax = gx = 0;
    vy = ay = gy = 0;
    px = x;
    py = y;
  }

  void interagir(Particula p) {
    float d = dist(px, py, p.px, p.py);
    if (d < distan) {
      d = f(d);
      gx += C * (d - f(dist(px, py, p.px + dx, p.py)))/dx;
      gy += C * (d - f(dist(px, py, p.px, p.py + dx)))/dx;
    }
  }

  void atualizar() {
    vx += ax * dt;
    vy += ay * dt;
    px += (vx + gx) * dt;
    py += (vy + gy) * dt;
    gx = ax = 0;
    gy = ay = 0;
  }

  void desenhar() {
    fill(255 - (gx*gx + gy*gy)*0.1, 128);
    ellipse(px, py, (gx*gx + gy*gy)*0.1, (gx*gx + gy*gy)*0.1);
  }
}