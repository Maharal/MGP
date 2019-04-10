final int NUM_LINHAS = 5;
float DIST_LINHAS;

final color COR_FUNDO = #FFFFFF;
final color COR_LINHAS = #31A9D3;
final color COR_AGULHA = #777777;

PVector pos, dir;
int a, b, v;

void setup(){
  size(800, 600);
  strokeWeight(2);
  fill(255);
  frameRate(1000);
  
  DIST_LINHAS = (float) height/NUM_LINHAS;
  pos = new PVector(0, 0);
  a = 0;
  b = 0;
  v = 10;
}

void draw() {
  
  background(COR_FUNDO);    
  desenharLinhas();
  pos.x = random(DIST_LINHAS, width-DIST_LINHAS);
  pos.y = random(DIST_LINHAS, height-DIST_LINHAS);
  dir = PVector.random2D().setMag(DIST_LINHAS).add(pos);
  desenharAgulha();
  
  b += 1;
  if (intersecao(pos, dir)){
    a += 1;
  }

  fill(0);
  textSize(20);
  text("π ≈ " + 2.0/((float) a/b), 10, 20);
  delay(v);

}

void keyPressed() {
  if (key == 'q') v++;
  if (key == 'a') v--;
  v = constrain(v, 0, 1000);
}

void desenharLinhas() {
  stroke(COR_LINHAS);
  for (int i = 0; i < NUM_LINHAS; i++) {
    line(0, (i + 1) * DIST_LINHAS, width, (i + 1) * DIST_LINHAS);
  }  
}

boolean intersecao(PVector m, PVector n) {
  for (int i = 0; i < NUM_LINHAS; i++) {
    if (pos.y < (i + 1) * DIST_LINHAS && pos.y > i * DIST_LINHAS && dir.y < (i + 1) * DIST_LINHAS && dir.y > i * DIST_LINHAS) {
      return false;
    }
  }  
  return true;
}

void desenharAgulha() {
  stroke(COR_AGULHA);
  fill(COR_FUNDO);
  line(pos.x, pos.y, dir.x, dir.y);
  ellipse(pos.x, pos.y, 5, 5);
}