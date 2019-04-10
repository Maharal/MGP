final float dt = 0.2;
final float dx = 0.001;
final float distan = 50;
final float C = 0.5;
float time = 0;

Particula sistema[];

void setup() {
  size(800, 600);
  sistema = new Particula[100]; 
  noStroke();
  fill(0);
  for (int i = 0; i < sistema.length; i++) {
    sistema[i] = new Particula(width * 0.5 + 50 * randomGaussian(), height * 0.5 + 50 * randomGaussian());
  }  
}
void draw() {
//  background(255);
  time += dt;
  for (int i = 0; i < sistema.length; i++) {
    for (int j = 0; j < i; j++) {
      sistema[i].interagir(sistema[j]);
      sistema[j].interagir(sistema[i]);
    }
  }
  for (int i = 0; i < sistema.length; i++) {
    sistema[i].desenhar();
    sistema[i].atualizar();
  }  
}

float f(float x) {
  return x * (2 * distan - x);
}