class TypeGoods {
  
  private color types[];
  
  TypeGoods(int n) {
    types = new color[n];
    for (int i = 0; i < n; i++) {      
      types[i] = color(random(200), random(200), random(200));
    }
  }
  
  color getType() {
    return types[(int) random(types.length)];      
  }
  
  color getType(int index) {
    return types[index];
  }
  
  int getSize() {
    return types.length;
  }
}
