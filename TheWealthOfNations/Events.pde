void mouseWheel(MouseEvent event) {
  float val = gbScale + event.getCount();
  if (-20 <= val && val <= 20) {
    gbScale = val;
  }
  rScale = map(gbScale, -20, 20, 0.9, 20);
}

void mouseDragged() {
  float s = 300 * rScale;
  px = constrain(px -= (pmouseX - mouseX), -s, s);
  py = constrain(py -= (pmouseY - mouseY), -s, s);
}
