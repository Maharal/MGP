void newMaze() {
  maze = new byte[I + 2][J + 2][K + 2];
  for (int i = 0; i < maze.length; i++) {
    for (int j = 0; j < maze[0].length; j++) {
      for (int k = 0; k < maze[0][0].length; k++) {
        maze[i][j][k] = WALL;
      }
    }
  }
}

void tree(int i, int j, int k, int c) {
  if (c < LIMIT) {
    c += 1;
    if (c > recorde) {
      recorde = c;
      flagx = i;
      flagy = j;
      flagz = k;
    }
    maze[i][j][k] = NIL;
    boolean possibility[] = new boolean[]{
      isWay(i+2, j, k), 
      isWay(i-2, j, k),
      isWay(i, j+2, k), 
      isWay(i, j-2, k),
      isWay(i, j, k+2), 
      isWay(i, j, k-2)
    };
    int choice = 0;
    while (possibility[0] 
        || possibility[1] 
        || possibility[2]
        || possibility[3] 
        || possibility[4] 
        || possibility[5]) {
      do {
        choice = int(random(0, 1000)) % 6;
      } while(!possibility[choice]);
      possibility[choice] = false;
      switch (choice) {
         case 0:
            maze[i+1][j][k] = NIL;
            tree(i+2, j, k, c);
         break;
         case 1:
            maze[i-1][j][k] = NIL;
            tree(i-2, j, k, c);
         break;
         case 2:
            maze[i][j+1][k] = NIL;
            tree(i, j+2, k, c);
         break;
         case 3:
            maze[i][j-1][k] = NIL;
            tree(i, j-2, k, c);
         break;
         case 4:
            maze[i][j][k+1] = NIL;
            tree(i, j, k+2, c);
         break;
         case 5:
            maze[i][j][k-1] = NIL;
            tree(i, j, k-2, c);
         break;
      }
      possibility = new boolean[]{
        isWay(i+2, j, k), 
        isWay(i-2, j, k),
        isWay(i, j+2, k), 
        isWay(i, j-2, k),
        isWay(i, j, k+2), 
        isWay(i, j, k-2)
      };
    } 
  }
}

boolean isWall(int i, int j, int k) {
  return maze[i][j][k] == WALL;
}

boolean isWay(int i, int j, int k) {
  if (i >= 1 && i <= I 
   && j >= 1 && j <= J 
   && k >= 1 && k <= K) {
    if (maze[i][j][k] == WALL 
     && maze[i+1][j][k] == WALL 
     && maze[i-1][j][k] == WALL 
     && maze[i][j+1][k] == WALL 
     && maze[i][j-1][k] == WALL 
     && maze[i][j][k+1] == WALL 
     && maze[i][j][k-1] == WALL) {
      return true;
    } else {
      return false;
    }
  } else {
    return false;
  }
} 