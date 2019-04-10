void swap() {
  // Swap A
  aux = Ap; 
  Ap = An;
  An = aux;
  // Swap B
  aux = Bp; 
  Bp = Bn;
  Bn = aux;
}

float laplacian(int i, int j, float matrix[][]) {
  w = matrix.length;
  h = matrix[0].length;
  ip = i+1<w?i+1:0;
  is = i-1<0?w-1:i-1;
  jp = j+1<h?j+1:0;
  js = j-1<0?h-1:j-1;
  result = -1.0 * matrix[i][j];
  result += 0.2 * matrix[ip][j];  
  result += 0.2 * matrix[is][j];  
  result += 0.2 * matrix[i][jp];  
  result += 0.2 * matrix[i][js];  
  result += 0.05 * matrix[ip][jp];  
  result += 0.05 * matrix[is][js];  
  result += 0.05 * matrix[is][jp];  
  result += 0.05 * matrix[ip][js];  
  return result;
}