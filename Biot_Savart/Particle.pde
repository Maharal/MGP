class Particle {
  ArrayList<PVector> trace;
  int t;

  Particle(PVector pos) {
    t = int(random(0, SIZE_TRACE));
    trace = new ArrayList<PVector>();    
    trace.add(rand(pos));
  }

  PVector B(PVector p, ArrayList<PVector> W) {
    PVector b = new PVector(0, 0, 0);
    PVector aux1 = W.get(0);
    PVector aux0, r, dl;
    for (int i = 1; i < W.size(); i++) {
      aux0 = aux1;
      aux1 = W.get(i);
      dl = PVector.sub(aux0, aux1);
      r = PVector.sub(p, aux1);
      float R = r.mag();
      b.add(dl.cross(r).div(R*R*R));
    }
    return b.mult(K*I);
  }

  void reset(ArrayList<PVector> W) {
    t = int(random(0, SIZE_TRACE));
    trace.clear();
    trace.add(rand(W.get(int(random(0, W.size())))));
  }

  void update(ArrayList<PVector> W) {
    t+=1;
    if (trace.size() > 0) {
      PVector pos = trace.get(trace.size() - 1);
      PVector b = B(pos, W);
      trace.add(PVector.add(pos, b.mult(5)));
      if (outOfBox(trace.get(0))) {
        reset(W);
      }
    } 
    if (t > SIZE_TRACE && trace.size() > 1) {
      trace.remove(0);
      trace.remove(0);
    }
  }

  void drawTrace() {
    if (trace.size() > 1) {
      PVector pos = trace.get(0);
      PVector aux;
      strokeWeight(1);
      for (int i = 1; i < trace.size(); i++) {
        stroke(TRACE_COLOR, i+10);
        aux = pos;
        pos = trace.get(i);
        if (!outOfBox(pos)) {
          line(pos.x, pos.y, pos.z, aux.x, aux.y, aux.z);
        }
      }
    }
  }
}