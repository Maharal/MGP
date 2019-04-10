class Ponto {

  final float h = 0.01;
  float x, y, z;
  color cor;
  float m[][];
  ArrayList<PVector> rastro;
  int t;

  Ponto(float x, float y, float z, float m[][]) {
    t = int(random(0, vida));
    this.x = x;
    this.y = y;
    this.z = z;
    this.m = m;
    cor = lerpColor(gradiente, random(0, 1)); 
    rastro = new ArrayList<PVector>();
  }

  void set(float x, float y, float z) {
    this.x = x;
    this.y = y;
    this.z = z;
    rastro.clear();
    t = int(random(0, vida));
  }

  float f(float x, float y) {
    float sum = 0;
    for (int i = 0; i < m.length; i++) {
      sum += g(x, y, m[i][0], m[i][1], m[i][2], m[i][3]);
    }
    return sum;
  }

  private float g(float x, float y, float h, float a, float b, float c) {
    return h * exp(-a * (pow(x + b, 2) + pow(y + c, 2)));
  }

  private float fx(float x, float y) {
    return (f(x + h, y) - f(x, y)) / h;
  }

  private float fy(float x, float y) {
    return (f(x, y + h) - f(x, y)) / h;
  }

  void atualizar() {
    t+=1;
    float gx = fx(x, y);
    float gy = fy(x, y);
    float mag = sqrt(gx*gx + gy*gy);
    gx /= mag;
    gy /= mag;
    float aux = gx;
    gx = -gy;
    gy = aux;

    x += gx;
    y += gy;
    z = f(x, y);

    rastro.add(new PVector(x, y, z));  
    if (t > 0.5 * vida && rastro.size() >= 2) {
      rastro.remove(0);
      rastro.remove(0);
    }
  }

  void desenhar() {
    float teta = 0;
    for (int i = 1; i < rastro.size(); i++) {
      teta = (float) i/rastro.size();
      strokeWeight(4 * teta * (1 - teta) + 1);
      stroke(cor, 32+256*i/rastro.size());
      PVector inicio = rastro.get(i-1);
      PVector fim  = rastro.get(i);
      line(inicio.x, inicio.y, inicio.z, fim.x, fim.y, fim.z);
    }
  }
}