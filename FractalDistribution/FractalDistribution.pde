float distrib[];
float max;

void setup() {
  size(600, 600);
  distrib = new float[width];
  max = 1;
  background(255);
}


void draw() {
  background(255);
  for (int i = 0; i < width; i++) {
    max = distrib[i] > max ? distrib[i] : max;
    line(i,height, i, (float) height * (1 - distrib[i]/max));
  }
  for (int i = 0; i < 100; i++) {
  distrib[fractal(300, 300)] +=1;
  }
}

int fractal(int pos, int dis) {
  if (random(0, 100) <= 90) {
    if (random(0, 100) <= 50) {
      return fractal(pos-dis/2, dis/2);
    } else {
      return fractal(pos+dis/2, dis/2);
    }
  }
  return pos;
}
