import java.util.Collections;

ArrayList<Particle> particles;
void setup() {
  size(700, 700);
  background(#000000);
  particles = new ArrayList();
  for (float teta = 0; teta <= TWO_PI; teta += TWO_PI/600) {
    for (float R = 0; R < 100; R += 0.3) {
      int i = width/2 + int(sin(teta) * R);
      int j = height/2 + int(cos(teta) * R);
      if (get(i, j) != #ffffff) {
        particles.add(new Particle(i, j));
      }
    }
  }
  Collections.shuffle(particles);
}

void draw() {
  for (Particle p : particles) {
    p.update();
  }
}

void keyPressed() {
  filter(BLUR, 10);
  stop();
}