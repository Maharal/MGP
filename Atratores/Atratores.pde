final float dt = 0.5;
final int NUM_ATRATORES = 5;
final int DIM = 30;
final float G = 500;

PVector atratores[];
color cores[];
PGraphics imagem;
Particula sistema[];

void setup() {
  size(700, 700);
  atratores = new PVector[NUM_ATRATORES];
  cores = new color[NUM_ATRATORES];
  imagem = createGraphics(width, height);
  sistema = new Particula[width];
  for (int i = 0; i < sistema.length; i++) {
    sistema[i] = new Particula(i, 0);
  }
  imagem.beginDraw();
  imagem.noStroke();
  imagem.background(0);
  for (int i = 0; i < NUM_ATRATORES; i++) {
    atratores[i] = PVector.random3D().mult(random(0, min(imagem.width, imagem.height) * 0.5));
    atratores[i].x += imagem.width * 0.5;
    atratores[i].y += imagem.height * 0.5;
    cores[i] = color(random(255), random(255), random(255));
    imagem.fill(cores[i]);
    imagem.ellipse(atratores[i].x, atratores[i].y, DIM, DIM);
  }
  imagem.endDraw();
}

void draw() {
  image(imagem, 0, 0, width, height);
  imagem.beginDraw();
  for (int i = 0; i < sistema.length; i++) {
    sistema[i].interagir();
  }
  for (int i = 0; i < sistema.length; i++) {
    sistema[i].atualizar();
    sistema[i].desenhar();
  }
  imagem.endDraw();
}

void keyPressed() {
  imagem.beginDraw();
  imagem.save("imagem.png");
  imagem.endDraw();
  exit();
}