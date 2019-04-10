final float dt = 1;
final float rate = 0.5;
final float ENERGY = 3.3;
final int NUM_FOOD = 500;
final float N = 0.1;

float time;
float px, py, disp;

System a;
PVector food[];

void setup() {
  size(400, 300);
  noCursor();
  a = new System(50);
  food = new PVector[NUM_FOOD];
  time = 0;
  for (int i = 0; i < NUM_FOOD; i++) {
    food[i] = new PVector(random(width), random(height));
  }
  px = random(width);
  py = random(height);
  disp = random(10, 40);
}

void draw() {
  background(#292C44);
  fill(#F0F0F1);
  for (int i = 0; i < NUM_FOOD; i++) {
    ellipse(food[i].x, food[i].y, 2, 2);
  }
  a.update();
  a.distribute(50);
  a.drawAgents();
  time += dt;
}

float limite(float num, float min, float max) {
  if (num < min) {
    return max - (min - num);
  } else if (num > max) {
    return min + (num - max);
  } else {
    return num;
  }
}