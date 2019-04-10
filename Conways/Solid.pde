class Solid {

  static final int TREFOIL_KNOT = 1;
  static final int EIGHT_CURVE  = 2;
  static final int TORUS_WAVE   = 3;
  static final int LOVE_CURVE   = 4;
  static final int TORUS        = 5;
  
  Quadrilateral surface[][];
  int type;
  int m;
  int n;
  float dm;
  float dn;
  float scale;
  float radius;
  
  Solid(int m, int n, float radius, float scale, int type) {
    
    this.m      = m;
    this.n      = n;
    this.dm     = TWO_PI/m;
    this.dn     = TWO_PI/n;
    this.scale  = scale;
    this.radius = radius/scale;
    this.type   = type;
    
    
    surface = new Quadrilateral[m][n];
    for (int i = 0; i < m; i++) {
      for (int j = 0; j < n; j++) {
        surface[i][j] = new Quadrilateral(
            p(i, j)
          , p(i + 1, j)
          , p(i, j + 1)
          , p(i + 1, j + 1)
        );
      }
    }
  }
  
  PVector parametric(float t) {
    if(this.type == TREFOIL_KNOT) {
      return new PVector(sin(t) + 2 * sin(2 * t), cos(t) - 2 * cos(2 * t), -sin(3 * t)); 
    } else if(this.type == TORUS) {
      return new PVector(sin(t), cos(t), 0); 
    } else if(this.type == EIGHT_CURVE) {
      return new PVector(sin(t), sin(t) * cos(t), cos(t)*0.5); 
    } else if(this.type == LOVE_CURVE) {
      return new PVector(3.9 * pow(sin(t), 3), 3 * cos(t) - 1.2 * cos(2 * t) -0.6*cos(3*t)-0.2*cos(4*t), sin(t)); 
    } else if(this.type == TORUS_WAVE) {
      return new PVector(sin(t), cos(t), sin(t * 5)*0.1); 
    } else {
      return new PVector(0, 0, 0);
    }
  }
  
  PVector p(int s, int t) {
    
    PVector A = parametric(dm * s);
    PVector B = parametric(dm * (s + 1));
    
    PVector n = new PVector(B.x, B.y, B.z);
    n.sub(A);
    n.normalize();
    
    PVector u = new PVector(A.x, A.y, A.z);
    u.mult(-1);
    PVector w = new PVector(n.x, n.y, n.z);
    w.mult((u.x * n.x + u.y * n.y + u.z * n.z)/pow(n.mag(), 2));  
    u.sub(w);
    u.normalize();

    PVector y = new PVector(u.x, u.y, u.z);
    y.mult(radius * sin(t * dn));
    
    PVector x = (n).cross(u);
    x.mult(radius * cos(t * dn));
    
    PVector pos = new PVector(A.x, A.y, A.z);
    pos.add(x);
    pos.add(y);
    pos.mult(scale);
    
    return pos;
  }
  
  void drawTrefoil(int map[][]) {
    for (int i = 0; i < m; i++) {
      for (int j = 0; j < n; j++) {
        if(map[i][j] == Field.FILL) {
          surface[i][j].drawQuadrilateral(FILL_COLOR);
        } else {
          surface[i][j].drawQuadrilateral(NULL_COLOR);
        }
      }
    }
  }
}