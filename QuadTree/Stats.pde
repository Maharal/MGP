float mean(color c) {
  return 1.0/1.3 * (red(c) + green(c) + blue(c));
}

float mean(PImage img) {
  float aux = 0;
  for (int i = 0; i < img.width; i++) {
    for (int j = 0; j < img.height; j++) {
      aux += mean(img.get(i, j));
    }
  }
  return aux / (img.width * img.height);
}

color meanColor(PImage img) {
  float r = 0, g = 0, b = 0;
  float c = img.width * img.height;
  for (int i = 0; i < img.width; i++) {
    for (int j = 0; j < img.height; j++) {
      r += red(img.get(i, j));
      g += green(img.get(i, j));
      b += blue(img.get(i, j));
    }
  }
  return color(r/c, g/c, b/c);
}

float var(PImage img) {
  float aux = 0;
  float m = mean(img);
  for (int i = 0; i < img.width; i++) {
    for (int j = 0; j < img.height; j++) {
      aux += pow(mean(img.get(i, j)) - m, 2);
    }
  }
  return aux / (img.width * img.height);
}

float std(PImage img) {
  return sqrt(var(img));
}
