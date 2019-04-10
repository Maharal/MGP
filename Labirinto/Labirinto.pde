void setup() {
  size(displayWidth, displayHeight);
  di = (float) width/(I+2);
  dj = (float) height/(J+2);
  newMaze();
  loadData();
  tree(x, y, z, 0);
}

void draw() {
  endGame();
  background(BACKGROUND);
  strokeWeight(1);
  for (int i = 1; i < maze.length-1; i++) {
    for (int j = 1; j < maze[0].length-1; j++) {
      if (!isWall(i, j, z)) {
          if (i == flagx && j == flagy && z == flagz) {
            fill(ORANGE);
          } else if ((i == 1) && (j == 1) && (1 == z)) {
            fill(GREEN, 128);
          } else if (maze[i][j][z] == VISITED) { 
            fill(LIGHT_GREEN, 128);
          } else {
            fill(255);
          }
          
        rect(i * di, j * dj, di, dj);
        
        if (i == flagx && j == flagy && z == flagz) {
          image(flag, i * di, j * dj);
        } else if (!isWall(i, j, z-1) && !isWall(i, j, z+1)) {
          image(arrow, i * di, j * dj);
        } else {
          
          if (!isWall(i, j, z+1)) {
            image(up, i * di, j * dj);
          } 
          
          if (!isWall(i, j, z-1)) {
            image(down, i * di, j * dj);
          }
        }
      }
    }
  }  
  
  stroke(GREEN);
  strokeWeight(2);
  fill(BACKGROUND, 128);
  rect(x * di, y * dj, di, dj);
  
}