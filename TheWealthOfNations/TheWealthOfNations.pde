void setup() {

  size(800, 600);
  surface.setResizable(true);
  
  TypeGoods type = new TypeGoods(10);
  population = new Population(type, 50);
  resources = new Resource(type);

}

void draw() {

  translate(width/2 + px, height/2 + py);
  scale(rScale);

  background(10);
  noStroke();
  fill(255);
  ellipse(0, 0, DIAMETER_PETRI, DIAMETER_PETRI);

  resources.drawResources();

  //population.drawNetwork();
  //if (stopNetwork) {
  //  thread("network");
  //}

  population.drawPopulation();
  if (stopUpdatePopulation) {
    thread("updatePopulation");
  }
  
  //if (stopEvent) {
  //  thread("event");
  //}
}
