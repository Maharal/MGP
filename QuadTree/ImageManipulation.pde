PImage cut(PImage img, int x, int y, int a, int b) {
  PImage newImg = createImage(a, b, RGB);
  for (int i = 0; i < a; i++) {
    for (int j = 0; j < b; j++) {
      newImg.set(i, j, img.get(i + x, j + y));
    }
  }
  return newImg;
}

PImage mergeImages(PImage a, PImage b, PImage c, PImage d) {
  PImage aux = createImage(a.width + b.width, a.height + c.height, RGB);
  
  // A
  for (int i = 0; i < a.width; i++) {
    for (int j = 0; j < a.height; j++) {
      aux.set(i, j, a.get(i, j));
    }
  }
  
  // B
  for (int i = 0; i < b.width; i++) {
    for (int j = 0; j < b.height; j++) {
      aux.set(i + a.width, j, b.get(i, j));
    }
  }
  
  // C
  for (int i = 0; i < c.width; i++) {
    for (int j = 0; j < c.height; j++) {
      aux.set(i, j + b.height, c.get(i, j));
    }
  }
  
  // D
  for (int i = 0; i < d.width; i++) {
    for (int j = 0; j < d.height; j++) {
      aux.set(i + a.width, j + b.height, d.get(i, j));
    }
  }
  
  return aux;
}

PImage createMonoImage(int a, int b, color c) {
  PImage aux = createImage(a, b, RGB);
  for (int i = 0; i < a; i++) {
    for (int j = 0; j < b; j++) {
      if (dist(i, j, 0.5 * a, 0.5 * b) < 0.2 * (a + b))
        aux.set(i, j, c);
    }
  }
  return aux;
}
