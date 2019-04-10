class Particula {
  
  PVector pos;
  int q;
  
  Particula(float x, float y, int Q) {
    q = Q;
    pos = new PVector(x, y);
  }
  
  void incrementar(int dq) {
    q += 10 * dq;    
  }
  
  float distancia(float x, float y) {
    return dist(pos.x, pos.y, x, y);
  }
  
  void desenhar() {
    if (q == 0) {
      fill(128);      
    } else if (q > 0){
      fill(#EA2D2D);      
    } else {
      fill(#2D80EA);
    }
    ellipse(pos.x, pos.y, 16, 16);
    fill(255);
    if (q > 0){
      rect(pos.x, pos.y, 10, 2);      
      rect(pos.x, pos.y, 2, 10);      
    } else if (q < 0){
      rect(pos.x, pos.y, 10, 2);      
    }  
  }
}