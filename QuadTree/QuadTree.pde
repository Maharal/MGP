void setup() {
  size(512, 512);
  
  PImage pic = loadImage("brain.jpeg");
  pic.resize(512, 512);
  
  PImage img = quadTree(pic, 30);
  img.resize(512, 512);
  background(img);
}

PImage quadTree(PImage img, float threshold) {
  if (std(img) < threshold || img.width < 10 || img.height < 10) {
    return createMonoImage(img.width, img.height, meanColor(img));
  } else {
    int a = img.width/2;
    int b = img.height/2;
    return mergeImages(
      quadTree(cut(img, 0, 0, a, b), threshold),
      quadTree(cut(img, a, 0, a, b), threshold),
      quadTree(cut(img, 0, b, a, b), threshold),
      quadTree(cut(img, a, b, a, b), threshold)
    );
  }
}
