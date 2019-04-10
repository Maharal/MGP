import peasy.*;

PeasyCam cam;

final int NUM_ESTRELAS = 50000;
final float H_MAX = 200;
color gradiente[] = {
  #ffebaa,
  #fa6403,
  #e70004,
  #742857, // rosa
  #a0a5dc,
  #073783,
  #000028,
  #26659b,
  #05054b
};
float xImagem, yImagem;
PImage dado;

Estrela galaxia[];

void setup() {
  size(800, 600, P3D);
  cam = new PeasyCam(this, 1000);
  cam.setMinimumDistance(10);
  cam.setMaximumDistance(5000);
  dado = loadImage("dados/Galaxy1.png");
  xImagem = dado.width;
  yImagem = dado.height;
  galaxia = new Estrela[NUM_ESTRELAS];
  float x, y, z, brilho;
  for (int i = 0; i < NUM_ESTRELAS; i++) {
    do {
      x = int(random(xImagem));
      y = int(random(yImagem));
      brilho = (float) brightness(dado.get(int(x), int(y)))/256.0;
    } while(brilho < random(0, 1));
    brilho = pow(brilho, 2);
    z = randomGaussian() * H_MAX * brilho * 1/(1 + exp(dist(0,0,x,y)/500.0))*1.1;
    x -= (float) xImagem * 0.5 + randomGaussian() * brilho * 2;
    y -= (float) yImagem * 0.5 + randomGaussian() * brilho * 2;
    galaxia[i] = new Estrela(
      new PVector(x, y, z),
      color(LerpM(gradiente, brilho), 200),
      brilho + 1
    );
  }
}

void draw() {
  background(0);
  for (int i = 0; i < NUM_ESTRELAS; i++) {
    galaxia[i].desenharEstrela();
  }
}

color LerpM(color cor[], float amt) {
  amt = 1 - amt;
  int posicao = int(cor.length * amt);
  int i = posicao;
  int j = constrain(posicao+1, 0, cor.length-1);
  float x = (amt - (float) posicao * ((float) 1.0/cor.length))*cor.length;
  return lerpColor(cor[i], cor[j], x);
}
