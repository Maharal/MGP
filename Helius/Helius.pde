import peasy.*;

final float dt = 0.1;
final float G = 100.0;
final int NUMBER_STARS = 500;

PeasyCam cam;
color BACKGROUND_COLOR = #010C15;
float Vc = 0.01;
float time = 0;
boolean inform = false;
boolean refer = false;
boolean camer = true;
boolean spa = false;
boolean mouse = false;

PVector stars[];
Particle star;
Particle planet[];

void setup() {
  size(displayWidth, displayHeight, P3D);
  sphereDetail(10);
  cam = new PeasyCam(this, 100);
  cam.setMinimumDistance(200);
  cam.setMaximumDistance(2000);   
  cam.setFreeRotationMode();
  stars = new PVector[NUMBER_STARS];
  for (int i = 0; i < NUMBER_STARS; i++) {
    stars[i] = new PVector(randomGaussian(), randomGaussian()*2, randomGaussian()*1.6);
    stars[i].normalize();
    stars[i].mult(3000);
  }
  planet = new Particle[4];
  star = new Particle(new PVector(0, 0, 0), new PVector(0, 0, 0), 10, 1000, #FEFF0F, 0 );
  planet[0] = new Particle(new PVector(0, 50, 0), new PVector(0, 0, 50), 3, 7, #30D68F, 100);
  planet[1] = new Particle(new PVector(0, -170, 0), new PVector(0, 0, -25), 1, 1, #0E93E3, 300);
  planet[2] = new Particle(new PVector(0, -120, 0), new PVector(0, 0, -26), 4, 15, #FCBB14, 200);
  planet[3] = new Particle(new PVector(0, 300, 0), new PVector(0, 0, 20), 5, 20, #EA0023, 400);
}

void draw() {
  background(BACKGROUND_COLOR);
  time += dt;
  star.drawParticle();
  for (int i = 0; i < 4; i++) {
    planet[i].drawParticle();
    planet[i].gravityInteraction(star);
  }
  for (int i = 0; i < 4; i++) {
    planet[i].update();
  }
    
  drawStars();
  options();
}

void keyPressed() {
  if (key == 'i') {
    inform = !inform;
  } else if (key == 'r') {
    refer = !refer;
  } else if (key == 'c') {
    camer = !camer;
  } else if (key == 's') {
    spa = !spa;
  }else if (key == 'p') {
    mouse = !mouse;
    if (mouse) 
      noCursor();
    else
      cursor();
  }
}