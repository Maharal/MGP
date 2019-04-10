    import peasy.*;
PeasyCam cam;
Wire wire;
MagnetField B;

void setup() {
  size(800, 600, P3D);
  colorMode(RGB, SIZE_TRACE);
  frameRate(1000);
  noFill();
  
  // Inicializa a camêra
  cam = new PeasyCam(this, 100);
  cam.setMinimumDistance(100);
  cam.setMaximumDistance(4000);
  
  // Inicializa o fio
  wire = new Wire();
  for(float teta = 0; teta <= TWO_PI+omega * dt; teta += omega * dt) {
    float x = cos(5*teta);
    float y = sin(5*teta);
    float z = (teta-PI)*0.5;
    wire.add((new PVector(x, y, z)).mult(200));  
  }

  // Inicializa o campo magnético
  B = new MagnetField(wire.get());
  
}

void draw() {
  background(BLACK);
  wire.update();
  B.update(wire.get());
  wire.drawWire();
  B.drawMagnetField();
  if(box) {
    stroke(SIZE_TRACE);
    box(SIZE_BOX);
  }
}