int N = 0;
float dx = 0.5;

void setup() {
  size(800, 600);
  frameRate(15);
  background(0);
}

void draw() {
  back();
  grid();
  function();
  N = (N + 1) % 50;
}
