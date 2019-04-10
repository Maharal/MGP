final int iteration_num = 1000;
final float initial_value = 0.5;
final float Q = 3.54; // 3.54
final float R = 4.00; // 4
float step_size;
float a, x;
 
void setup(){
  size(displayWidth, displayHeight);
  step_size = (float) 0.5 * (R - Q) / width;
  colorMode(HSB, 1);
  background(0);
  stroke(1, 0.05);
  noCursor();
  a = Q;
}

void draw() {
  x = initial_value;
  a += step_size;
  for(int i = 0; i < iteration_num; i++){
    x = x * (1 - x) * a;
    point(map(a, Q, R, 0, width), height * (1 - x));
  } 
  if (a >= R) {
    stop();
  }
}