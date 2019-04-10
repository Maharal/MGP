void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP && !isWall(x, y, z+1)) {
      z = constrain(z + STEP, 1, K);
    } else if (keyCode == DOWN && !isWall(x, y, z-1)) {
      z = constrain(z - STEP, 1, K);
    } 
  } else if ((key == 'd' || key == 'D') && !isWall(x+1, y, z)){
      x = constrain(x + 1, 1, I);
  } else if ((key == 'a' || key == 'A') && !isWall(x-1, y, z)){
      x = constrain(x - 1, 1, I);
  } else if ((key == 's' || key == 'S') && !isWall(x, y+1, z)){
      y = constrain(y + 1, 1, J);
  } else if ((key == 'w' || key == 'W') && !isWall(x, y-1, z)){
      y = constrain(y - 1, 1, J);
  }
  maze[x][y][z] = VISITED;
}

void endGame() {
  if (x == flagx && y == flagy && z == flagz) {
    exit();
  }
}