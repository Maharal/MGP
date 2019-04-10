float[][] Ap, An, Bp, Bn, aux;
float[][][] A, B;
final float dt = 1.0;
final float Da = 1.0;
final float Db = 0.5;
final float f = 0.0545;
final float k = 0.062;

float reaction, result;
int x, y, h, w, ip, is, jp, js;

void setup() {

  size(500, 500);
  colorMode(HSB, 1);

  A = new float[2][width][height];
  B = new float[2][width][height];

  Ap = A[0];
  Bp = B[0];
  An = A[1];
  Bn = B[1];

  for (int i = 0; i < width; i++) {
    for (int j = 0; j < height; j++) {
      Ap[i][j] = 1;
      Bp[i][j] = 0;
    }
  }
}

void draw() {

  if (mousePressed) {
    for (float r = 0; r < 3; r += 0.1) {
      for (float teta = 0; teta < TWO_PI; teta += 0.1) {
        x = mouseX + floor(r * sin(teta));
        y = mouseY + floor(r * cos(teta));
        if (x >= 0 && x < width && y >= 0 && y < height) {
          Bp[x][y] = 0.5;
        }
      }
    }
  }

  for (int i = 0; i < width; i++) {
    for (int j = 0; j < height; j++) {
      reaction = Ap[i][j] * Bp[i][j] * Bp[i][j];
      An[i][j] = Ap[i][j] + (Da * laplacian(i, j, Ap) - reaction + f * (1 - Ap[i][j])) * dt;
      Bn[i][j] = Bp[i][j] + (Db * laplacian(i, j, Bp) + reaction - (k + f) * Bp[i][j]) * dt;
      set(i, j, lerpColor(#00FF5B, #E0193E, An[i][j]));
    }
  }
  swap();
}