import peasy.*;
final int LEN_X = 101;
final int LEN_Y = 101;
final int n = 2;
final int m = 2;
final float h = 30;
final float C = -1;
final float dt = 0.5;
float min, max;
float[][] r, v, a;
PeasyCam cam;

void setup() {
  size(800, 600, P3D);
  stroke(255);
  frameRate(1000);
  colorMode(HSB, 1);
  r = new float[LEN_X][LEN_Y];
  v = new float[LEN_X][LEN_Y];
  a = new float[LEN_X][LEN_Y];
  cam = new PeasyCam(this, 100);
  cam.setMinimumDistance(400);
  cam.setMaximumDistance(1000);
  for (int i = 0; i < LEN_X; i++) {
    for (int j = 0; j < LEN_Y; j++) {
      v[i][j] = a[i][j] = 0;
      float x = map(i, 0, LEN_X-1, -HALF_PI * n, HALF_PI * n);
      float y = map(j, 0, LEN_Y-1, -HALF_PI * m, HALF_PI * m);
      float a = map(i, 0, LEN_X-1, -1, 1);
      float b = map(j, 0, LEN_Y-1, -1, 1);
      r[i][j] = h * (cos(x * n) + cos(y * m)) * (1 - a*a) * (1 - b*b);
    }
  }
}

void draw() {
  background(0);
  forca();
  desenhar();
  atualizar();
}

void atualizar() {
  for (int i = 1; i < LEN_X-1; i += 1) {
    for (int j = 1; j < LEN_Y-1; j += 1) {
      v[i][j] = v[i][j] + a[i][j] * dt;
      r[i][j] = r[i][j] + v[i][j] * dt;
    }
  }
}

void forca() {
  min = 1e10;
  max = -1e10;  
  for (int i = 1; i < LEN_X-1; i += 1) {
    for (int j = 1; j < LEN_Y-1; j += 1) {
      a[i][j] = C * (4 * r[i][j] - (r[i+1][j] + r[i-1][j] + r[i][j+1] + r[i][j-1]));
      min = min < a[i][j] ? min : a[i][j]; 
      max = max > a[i][j] ? max : a[i][j]; 
    }
  }
}

void desenhar() {
  stroke(0.5, 1, 1);
  line(-200, -200, 0, 200, -200, 0);
  line(-200, -200, 0, -200, 200, 0);
  line(200, 200, 0, 200, -200, 0);
  line(200, 200, 0, -200, 200, 0);
  for (int i = 1; i < LEN_X; i += 2) {
    for (int j = 1; j < LEN_Y; j += 2) {
      stroke(map(a[i][j], min, max, 0, 1), 1, 1);
      float x = map(i, 0, LEN_X-1, -200, 200);
      float y = map(j, 0, LEN_Y-1, -200, 200);
      line(x, y, r[i][j], map(i+1, 0, LEN_X-1, -200, 200), map(j, 0, LEN_Y-1, -200, 200), r[i+1][j]);
      line(x, y, r[i][j], map(i, 0, LEN_X-1, -200, 200), map(j+1, 0, LEN_Y-1, -200, 200), r[i][j+1]);
      line(x, y, r[i][j], map(i-1, 0, LEN_X-1, -200, 200), map(j, 0, LEN_Y-1, -200, 200), r[i-1][j]);
      line(x, y, r[i][j], map(i, 0, LEN_X-1, -200, 200), map(j-1, 0, LEN_Y-1, -200, 200), r[i][j-1]);
    }
  }
}