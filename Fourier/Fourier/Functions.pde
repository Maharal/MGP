float f(float x, int n) {
  float aux, sum = 0.5;
  for (int i = 0; i < n; i++) {
    aux = TWO_PI * i + PI;
    sum +=  sin(aux * x)/aux;
  }
  return 2 * sum;
}

float g(float x, int n) {
  float sum = 0;
  for (int i = 1; i <= n; i++){
    sum +=  sin(i * PI * x) * (sin(PI*i) - PI * i * cos(PI*i)) / (PI*PI*i*i); 
  }
  return 2 * sum;
}

float h(float x, int n) {
  float sum = 0;
  for (int i = 1; i <= n; i++){
    sum +=  (2*sin(i*PI) - PI*i*(1+cos(i * PI)))/ (PI*PI*i*i) * cos(i * PI * x) + sin(i * PI * x)*(2 * sin(PI*i) - PI * i * (1 + cos(PI*i)))/(PI*PI*i*i); 
  }
  return 2 * sum;
}

float u(float x, int n) {
  float sum = 0;
  for (int i = 1; i <= n; i++){
    sum += (float) cos((float) i * PI * x) * (1 - cos(PI * i))/ (i*i);
  }
  return (float) 2.0 * sum / (PI * PI);
}

float r(float x, int n) {
  float aux, sum = (float) 2/3;
  for (int i = 1; i <= n; i++){
    aux = (float) PI * i;
    sum += cos(aux * x) * (sin(aux) - aux * cos(aux)) / pow(i, 3);
  }
  return (float) 4/3 * sum/pow(PI, 3);
}

float s(float x, int n) {
  float sum = 0;
  for (int i = 1; i <= n; i++){
    sum += sin(i * x * 2) * i * cos(i * PI) / (1 - 4*i*i);
  }
  return (float) 8/PI * sum;
}

float w(float x, int n) {
  float sum = 0;
  for (int i = 1; i <= n; i++){
    sum += sin(i * x) * sin(PI * i) / (i * i -1);
  }
  return (float) -2/PI * sum;
}