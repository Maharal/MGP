class Resource {
  
  private Good resources[];

  Resource(TypeGoods t) {
    resources = new Good[100];
    for (int i = 0; i < resources.length; i++) {
      resources[i] = new Good(t.getType());
    }
  }

  void drawResources() {
    for (Good f : resources) {
      f.drawFood();
    }
  }
}
