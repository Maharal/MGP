class Backpack {
  
  private float itens[];
  
  Backpack(TypeGoods t, color type) {
    itens = new float[t.getSize()];
    for (int i = 0; i < itens.length; i++) {
      if (t.getType(i) != type) {
        itens[i] = 0;
      } else {
        itens[i] = 100;
      }
    }
  }
}
