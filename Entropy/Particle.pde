class Particle {
  int i, j;

  Particle(int x, int y) {
    i = x;
    j = y;
    set(i, j, #ffffff);
  }

  void update() {
    if (countNeighbors(i, j) != 8 && (i > 1 && i < width-2 && j > 1 && j < height-2)) {
      set(i, j, #000000);
      int di, dj;
      do {
        di = int(random(-2, 2));
        dj = int(random(-2, 2));
      } while (get(i + di, j + dj) == #FFFFFF);
      i = constrain(i + di, 1, width-2);
      j = constrain(j + dj, 1, height-2);
      set(i, j, #FFFFFF);
    }
  }

  int countNeighbors(int x, int y) {
    return neighbor(x+1, y)
      + neighbor(x-1, y)
      + neighbor(x, y+1)
      + neighbor(x-1, y)  
      + neighbor(x+1, y+1)
      + neighbor(x-1, y+1)
      + neighbor(x+1, y-1)
      + neighbor(x-1, y-1);
  }

  int neighbor(int x, int y) {
    if (get(x, y) == #FFFFFF) {
      return 1;
    } else {
      return 0;
    }
  }
}