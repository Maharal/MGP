class Field {
  
  int map[][];
  int buffer[][];
  int m;
  int n;
  static final int NULL = 0;
  static final int FILL = 1;

  Field(int m, int n) {
    
    this.m      = m;
    this.n      = n;
    this.map    = new int[m][n];
    this.buffer = new int[m][n];
    
    chaos();
  }

  void iterates() {
    int state     = 0;
    int neighbors = 0;
    for (int i = 0; i < m; i++) {
      for (int j = 0; j < n; j++) {
        state     = map[i][j];
        neighbors = numNeighbors(i, j);
        if (state == NULL) {
          if (neighbors == 3) {
            buffer[i][j] = FILL;
          } 
        } else {
          if(neighbors != 2 && neighbors != 3) {
            buffer[i][j] = NULL;
          }
        }
      }
    }
  }
  
  void update() {
   for (int i = 0; i < m; i++) {
      for (int j = 0; j < n; j++) {
       map[i][j] = buffer[i][j];
      }
    }   
  }

  int getState(int i, int j) {
    return map[i][j];
  }
  
  void chaos() {
    for (int i = 0; i < m; i++) {
      for (int j = 0; j < n; j++) {
        if(random(0, 1000) > 500) {
          map[i][j] = 1; 
        } else {
          map[i][j] = 0;
        }
      }
    }
  }
  
  int[][] getMap() {
    return this.map;
  }
    
  int numNeighbors(int i, int j) {

    int N = lim(j - 1, 0, n-1);
    int S = lim(j + 1, 0, n-1);
    int E = lim(i + 1, 0, m-1);
    int W = lim(i - 1, 0, m-1);

    return map[W][N] + map[i][N] + map[E][N] + map[E][j]+ 
           map[E][S] + map[i][S] + map[W][S] + map[W][j];

  }

  int lim(int num, int min, int max) {
    if (num < min) {
      return max;
    } else if (num > max) {
      return min;
    } else {
      return num;
    } 
  }
}