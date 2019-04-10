class Fantasma {

  PVector pos, ant;

  Fantasma(float x, float y) {
    pos = new PVector(x, y);
    ant = new PVector(x, y);
  }


  void atualizar(PVector E) {
    ant.set(pos.x, pos.y);
    pos.add(PVector.mult(E, dt));
    if (E.mag() < 1 || pos.x < 0 || pos.x > width || pos.y < 0 || pos.y > height) {
      this.novaPosicao();
    }
  }

  void desenhar() {
    stroke(0);
    if (dist(pos.x, pos.y, ant.x, ant.y) <= 70) {
      line(pos.x, pos.y, ant.x, ant.y);
    }
  }

  void novaPosicao() {
    pos.set(random(width), random(height));
    ant.set(pos.x, pos.y);
  }
}