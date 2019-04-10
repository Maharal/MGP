    import peasy.*;
PeasyCam cam;
float m[][];
Ponto p[];
float vida = 100;
color gradiente[] = {
  #ffebaa, 
  #fa6403, 
  #e70004, 
  #742857, // rosa
  #a0a5dc, 
  #073783, 
  #000028, 
  #26659b, 
  #05054b, 
  #23AF4C, 
  #27F061
};

void setup() {
  size(displayWidth, displayHeight, P3D);
  strokeWeight(5);
  frameRate(1000);
  cam = new PeasyCam(this, 100);
  cam.setMinimumDistance(200);
  cam.setMaximumDistance(2000);   
  cam.setFreeRotationMode();
  p = new Ponto[4000];
  m = new float[10][4];
  init();
}

void draw() {
  background(0);
  for (int i = 0; i < p.length; i++) {

    p[i].atualizar();
    if (p[i].t > vida) {
      p[i].set(randomGaussian()* 50, randomGaussian()* 50, random(-50, 50));
    }
  }  
  for (int i = 0; i < p.length; i++) {
    p[i].desenhar();
  }
}

int lerpColor(int c[], float amt) {
  amt *= c.length-1;
  return lerpColor(c[floor(amt)], c[ceil(amt)], amt - floor(amt));
}

void keyPressed() {
  init();
}

void init() {
  for (int i = 0; i < m.length; i++) {
    m[i][0] = random(-50, 50);
    m[i][1] = random(0.0001, 0.01);
    m[i][2] = randomGaussian()* 50;
    m[i][3] = randomGaussian()* 50;
  }  
  noCursor();
  for (int i = 0; i < p.length; i++) {
    p[i] = new Ponto(randomGaussian()* 50, randomGaussian()* 50, random(-50, 50), m);
  }
}
