void drawStars() {
  stroke(255);
  for (int i = 0; i < NUMBER_STARS; i++) {
    point(stars[i].x, stars[i].y, stars[i].z);
  }
}

void referential(float t) {
  stroke(255, 0, 0);
  line(0, 0, 0, -t, 0, 0);
  stroke(64, 0, 0);
  line(0, 0, 0, t, 0, 0);
  stroke(0, 255, 0);
  line(0, 0, 0, 0, -t, 0);
  stroke(0, 64, 0);
  line(0, 0, 0, 0, t, 0);
  stroke(0, 0, 255);
  line(0, 0, 0, 0, 0, t);
  stroke(0, 0, 64);
  line(0, 0, 0, 0, 0, -t);
}

void information() {
  cam.beginHUD();
  fill(128);
  text("Informations ( i ) ", width-110, height-20);
  if (inform) {
    fill(255);
    text("Informations: ", 30, 40);
    text("Time: " + time, 30, 60);
    text("i: Show informations", 30, 80);
    text("r: Show referential", 30, 100);
    text("s: Show distortion of spacetime", 30, 120);
    text("c: Change the state of camera", 30, 140);
    text("p: Enable and disable cursor", 30, 160);
    noFill();
  }
  cam.endHUD();
}

void options() {
  information();
  if (camer) {
    camera(400 * sin(time * Vc) * cos(time * Vc) - 300, 550 * sin(time * Vc), 550 * cos(time * Vc), 0, 0, 0, 1, 0, 0);
  }
  if (refer) {
    referential(100000);
  }
  if (spa) {
    space();
  }
}

void space() {
  strokeWeight(map((float) (2000.0 - cam.getDistance()), 200, 2000, 0.5, 1.5));
  float sum, d;
  for (int i = -700; i < 700; i+=15) {
    for (int j = -700; j < 700; j+=15) {
      sum = 1000/pow(map(sqrt(i*i + j*j), 0, 500, 10, 100), 1.38);
      for (int k = 0; k < 4; k++) {
        d = dist(planet[k].position.y, planet[k].position.z, j, i);
        d = map(d, 0, 300, 20, 300);
        sum += planet[k].mass*G/pow(d, 1.3);
      }
      if (sum < 256 && sum > 2) {
        stroke(255, pow(sum, 2));
        plus(sum*2, j, i);
      }
    }
  }
}

void plus(float x, float y, float z) {
  line(x, y, z+2, x, y, z-2);
  line(x, y+2, z, x, y-2, z);
}