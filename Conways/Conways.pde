// Colors of program
final int BACKGROUND_COLOR = #000000;
final int STROKE_COLOR     = #2456EA;
final int FILL_COLOR       = #24EA96;
final int NULL_COLOR       = #000000;

// Data of solid
final float radius = 40;

// Size of world conway's game of life
final int SIZE_X = 416;
final int SIZE_Y = 49;

// Field
Field map;

// Test
Solid solid3d;

float s, t;
int count = 0;
void setup() {
  fullScreen(P3D);
  background(BACKGROUND_COLOR);
  colorMode(RGB, 1);
  strokeWeight(1);
  stroke(STROKE_COLOR);
  noCursor();
  s = 0;
  t = 0;
  map  = new Field(SIZE_X, SIZE_Y);
  solid3d = new Solid(SIZE_X, SIZE_Y, radius, 75, Solid.TREFOIL_KNOT);
}

void draw() {
  
  background(BACKGROUND_COLOR);
  s += 0.0025;
  t += 0.0075; 
  camera(550 * sin(t), 550 * cos(t), sin(s) * 320 , 0.0, 0.0, 0.0, 0.0, 0, 1.0);
  
  map.iterates();
  map.update();
  solid3d.drawTrefoil(map.getMap());

  if(count++ > 600) {
    map.chaos();
    count = 0;
  }   
}

void keyPressed() {
  map.chaos();
}