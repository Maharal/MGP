void grid() {
  strokeWeight(1);
  stroke(#2EE39F, 32);
  noFill();
  int n = 10;
  for (int i = 1; i < n; i++) {
    line(0, (float)height/(n-1) * i, width, (float)height/(n-1) * i);
    line((float)width/(n-1) * i, 0, (float)width/(n-1) * i, height);
  }
}

void back() {
  fill(0, 100);
  noStroke();
  rect(-20, -20, width + 20, height + 20);
}

float foo(float x, int N) {
  return height - (height/2 + 250 * s(map(x, 0, width, -5, 5), N));
}

void function() {
  strokeWeight(2);
  stroke(#18cf65);
  noFill();
  for (float x = 0; x < width; x += dx) {
    line(x, foo(x, N), x + dx, foo(x + dx, N));
  }
}