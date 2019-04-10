class Torus {

  PVector surface[][], node[][];
  float[][] matrix;
  int w, h;
  int state;

  Torus(float R, float r, int w, int h, float m[][]) {
    this.w = w;
    this.h = h;
    state = 0;
    surface = new PVector[w][h];
    node = new PVector[w][h];
    matrix = m;
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

  void drawTorus() {
    noStroke();
    for (int i = 0; i < surface.length; i++) {
      for (int j = 0; j < surface[0].length; j++) {
        int x = i+1<w?i+1:0;
        int y = j+1<h?j+1:0;
        fill(lerpColor(#F50C6D, #0CF55B, map(r[i][j], min, max, 0, 1)));
        beginShape(QUAD);
        vertex(surface[i][j].x-matrix[i][j]*node[i][j].x, surface[i][j].y-matrix[i][j]*node[i][j].y, surface[i][j].z-matrix[i][j]*node[i][j].z); 
        vertex(surface[i][y].x-matrix[i][y]*node[i][y].x, surface[i][y].y-matrix[i][y]*node[i][y].y, surface[i][y].z-matrix[i][y]*node[i][y].z);
        vertex(surface[x][y].x-matrix[x][y]*node[x][y].x, surface[x][y].y-matrix[x][y]*node[x][y].y, surface[x][y].z-matrix[x][y]*node[x][y].z);
        vertex(surface[x][j].x-matrix[x][j]*node[x][j].x, surface[x][j].y-matrix[x][j]*node[x][j].y, surface[x][j].z-matrix[x][j]*node[x][j].z);
        endShape(CLOSE);
      }
    }
  }
}
