class Good {
  
  private PVector position;
  private color type;

  Good(color t) {
    position = PVector.random2D();
    position.mult(random(0, DIAMETER_PETRI/2));
    type = t; 
  }
  
  void drawFood() {
    noStroke();
    fill(type);
    ellipse(position.x, position.y, FOOD_SIZE, FOOD_SIZE);
  }
}
