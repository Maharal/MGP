class Torus {

  PVector surface[][], node[][];
  float[][][] A, B;
  int w, h;
  int state;

  Torus(float R, float r, int w, int h) {
    state = 0;
    surface = new PVector[w][h];
    node = new PVector[w][h];
    A = new float[2][W][H];
    B = new float[2][W][H];
    PVector pontos[] = new PVector[50];
    for (int i = 0; i < 50; i++) {
      pontos[i] = new PVector(random(W), random(H));
    }

    for (int i = 0; i < W; i++) {
      for (int j = 0; j < H; j++) {
        A[state][i][j] = 1;
        for (int k = 0; k < 50; k++)
          if (dist(i, j, pontos[k].x, pontos[k].y) < 10) {
            B[state][i][j] = 0.9 * exp(-0.1 * pow(dist(i, j, pontos[k].x, pontos[k].y), 2));
            break;
          } else {
            B[state][i][j] = 0;
          }
      }
    }

    this.w = w;
    this.h = h;
    for (int i = 0; i < w; i++) {
      for (int j = 0; j < h; j++) {
        float u = map(i, 0, w-1, 0, TWO_PI);
        float v = map(j, 0, h-1, 0, TWO_PI);
        surface[i][j] = new PVector((R + r * cos(v)) * cos(u),
          (R + r * cos(v)) * sin(u),
          r * sin(v));
      }
    }

    for (int i = 0; i < w; i++) {
      for (int j = 0; j < h; j++) {
        PVector p = PVector.sub(surface[i][j], surface[i+1<w?i+1:1][j]);
        PVector q = PVector.sub(surface[i][j], surface[i][j+1<h?j+1:1]);
        node[i][j] = p.cross(q).normalize();
      }
    }
  }

  void update() {
    for (int i = 0; i < w; i++) {
      for (int j = 0; j < h; j++) {
        float a = A[state][i][j];
        float b = B[state][i][j];
        A[state==1?0:1][i][j] = a + (Da * laplacianA(i, j) - a * b * b + f * (1- a)) * dt;
        B[state==1?0:1][i][j] = b + (Db * laplacianB(i, j) + a * b * b - (K + f) * b) * dt;
      }
    }
    state=state==1?0:1;
  }

  float laplacianA(int i, int j) {
    float resultA = -A[state][i][j];
    resultA += 0.2 * A[state][i+1<w?i+1:0][j];
    resultA += 0.2 * A[state][i-1<0?w-1:i-1][j];
    resultA += 0.2 * A[state][i][j+1<h?j+1:0];
    resultA += 0.2 * A[state][i][j-1<0?h-1:j-1];
    resultA += 0.05 * A[state][i-1<0?w-1:i-1][j-1<0?h-1:j-1];
    resultA += 0.05 * A[state][i+1<w?i+1:0][j-1<0?h-1:j-1];
    resultA += 0.05 * A[state][i-1<0?w-1:i-1][j+1<h?j+1:0];
    resultA += 0.05 * A[state][i+1<w?i+1:0][j+1<h?j+1:0];
    return resultA; //<>//
  }

  float laplacianB(int i, int j) {
    float resultB = -B[state][i][j];
    resultB += 0.2 * B[state][i+1<w?i+1:0][j];
    resultB += 0.2 * B[state][i-1<0?w-1:i-1][j];
    resultB += 0.2 * B[state][i][j+1<h?j+1:0];
    resultB += 0.2 * B[state][i][j-1<0?h-1:j-1];
    resultB += 0.05 * B[state][i-1<0?w-1:i-1][j-1<0?h-1:j-1];
    resultB += 0.05 * B[state][i+1<w?i+1:0][j-1<0?h-1:j-1];
    resultB += 0.05 * B[state][i-1<0?w-1:i-1][j+1<h?j+1:0];
    resultB += 0.05 * B[state][i+1<w?i+1:0][j+1<h?j+1:0];
    return resultB;
  }

  void drawTorus() {
    noFill();
    for (int i = 0; i < surface.length; i++) {
      for (int j = 0; j < surface[0].length; j++) {
        stroke(lerpColor(#FA0060, #1AFF36, A[0][i][j]));
        strokeWeight(1 + (1-A[0][i][j]) * 10);
        point(surface[i][j].x-node[i][j].x*A[0][i][j]*wrinkle, surface[i][j].y-node[i][j].y*A[0][i][j]*wrinkle, surface[i][j].z-node[i][j].z*A[0][i][j]*wrinkle);
      }
    }
  }
}
