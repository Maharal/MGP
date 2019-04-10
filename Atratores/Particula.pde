class Particula {

  PVector pos, vel, ace;
  int a, b;
  
  Particula(int x, int y) {
    pos = new PVector(x, y);
    vel = new PVector(0, 0);
    ace = new PVector(0, 0);
    a = x;
    b = y;
  }

  void atualizar() {
    if (b < imagem.height) {
      vel.x += ace.x * dt;  
      vel.y += ace.y * dt;  
      pos.x += vel.x * dt;  
      pos.y += vel.y * dt;
      ace.set(0, 0);
    }
  }

  void interagir() {
    if (b < imagem.height) {
      float modulo = 0;
      PVector F;
      for (int i = 0; i < atratores.length; i++) {
        F = new PVector(atratores[i].x, atratores[i].y);
        F.sub(pos);
        modulo = F.magSq();
        if (modulo <= DIM * DIM * 0.5) {
          imagem.stroke(cores[i]);
          imagem.point(a, b++);
          pos = new PVector(a, b);
          vel.mult(0);
          ace.mult(0);
        } else {
          F.setMag(G/modulo);
          ace.add(F);
        }
      }
    }
  }

  void desenhar() {
    stroke(255);
    point(pos.x, pos.y);
  }
}