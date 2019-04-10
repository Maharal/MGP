import peasy.*;
final int LEN_X = 401;
final int LEN_Y = 201;
final int n = 8;
final int m = 4;
final float h = 60;
final float C = -1;
final float dt = 0.5;
float min, max;
float[][] r, v, a;
PeasyCam cam;
Torus rosquinha;

void setup() {
  size(800, 600, P3D);
  frameRate(1000);
  colorMode(HSB, 1);
  r = new float[LEN_X][LEN_Y];
  v = new float[LEN_X][LEN_Y];
  a = new float[LEN_X][LEN_Y];
  cam = new PeasyCam(this, 100);
  cam.setMinimumDistance(400);
  cam.setMaximumDistance(3000);
  for (int i = 0; i < LEN_X; i++) {
    for (int j = 0; j < LEN_Y; j++) {
      v[i][j] = a[i][j] = 0;
      float x = map(i, 0, LEN_X-1, -PI, PI);
      float y = map(j, 0, LEN_Y-1, -PI, PI);
      r[i][j] = h * (1 + cos(x * n) + cos(y * m));
    }
  }
  rosquinha = new Torus(600, 300, LEN_X, LEN_Y, r);
}

void draw() {
  background(0);
  forca();
  atualizar();
  rosquinha.drawTorus();
}

void atualizar() {
  for (int i = 0; i < LEN_X; i += 1) {
    for (int j = 0; j < LEN_Y; j += 1) {
      v[i][j] = v[i][j] + a[i][j] * dt;
      r[i][j] = r[i][j] + v[i][j] * dt;
    }
  }
}

void forca() {
  min = 1e10;
  max = -1e10;  
  for (int i = 0; i < LEN_X; i += 1) {
    for (int j = 0; j < LEN_Y; j += 1) {
      a[i][j] = C * (4 * r[i][j] - (r[i+1 < LEN_X-1 ? i+1 : 0][j] + r[i-1<0 ? LEN_X-1 : i-1][j] + r[i][j+1 < LEN_Y-1 ? j+1 : 0] + r[i][j-1 < 0 ? LEN_Y-1 : j-1]));
      min = min < r[i][j] ? min : r[i][j]; 
      max = max > r[i][j] ? max : r[i][j]; 
    }
  }
}