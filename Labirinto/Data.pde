void loadData() {
  up = loadImage("up.png");
  up.resize(int(di), int(dj));
  down = loadImage("data/down.png");
  down.resize(int(di), int(dj));
  arrow = loadImage("data/arrow.png");
  arrow.resize(int(di), int(dj));
  flag = loadImage("data/flag.png");
  flag.resize(int(di), int(dj));
}