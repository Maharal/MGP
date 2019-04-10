final float dt = 0.05;
final float K = 1e4;
int id = 0;
boolean segurando = false;

ArrayList<Particula> particulas;
PVector E;
Fantasma fantasmas[];

void setup() {
  size(800, 600);
  rectMode(CENTER);
  particulas = new ArrayList<Particula>();
  fantasmas = new Fantasma[1000];
  E = new PVector(0, 0);
  for (int i = 0; i < fantasmas.length; i++) {
    fantasmas[i] = new Fantasma(random(width), random(height));
  }
}

void draw() {

  fill(255, 10);
  rect(width/2, height/2, width, height);
  for (int i = 0; i < fantasmas.length; i++) {
    E.x = 0;
    E.y = 0;
    for (Particula p : particulas) {
      PVector F = PVector.sub(fantasmas[i].pos, p.pos);
      if (F.mag() <= 8) {
        fantasmas[i].novaPosicao();
      }
      F.setMag(K * p.q / (8 + F.magSq()));
      E.add(F);
    }
    fantasmas[i].desenhar();
    fantasmas[i].atualizar(E);
  }
  noStroke();
  for (Particula p : particulas) {
    p.desenhar();
  }
  if (segurando) {
    particulas.get(id).pos.set(mouseX, mouseY);
  }
}

void mouseWheel(MouseEvent event) {
  for (Particula p : particulas) {
    if (p.distancia(mouseX, mouseY) < 8) {
      p.incrementar(-event.getCount());
    }
  }
}

void mouseReleased() {

  boolean livre = true;
  for (int i = 0; i < particulas.size() && livre; i++) {
    if (particulas.get(i).distancia(mouseX, mouseY) < 8) {
      livre = false;
      id = i;
      segurando =! segurando;
    }
  }

  if (livre) {
    switch (mouseButton) {
    case RIGHT : 
      particulas.add(new Particula(mouseX, mouseY, -10));
      break;

    case LEFT :
      particulas.add(new Particula(mouseX, mouseY, 10));
      break;
      
    case CENTER : 
      particulas.remove(id);
      break;
      
    default :
      particulas.add(new Particula(mouseX, mouseY, 0));
      break;
    }
  }
}