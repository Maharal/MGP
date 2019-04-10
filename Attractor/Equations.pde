PVector coulet(PVector v) {
  float a = 0.8;
  float b = -1.1;
  float g = -0.45;
  float d = -1;
  return new PVector(
      v.y
    , v.z
    , a * v.x + b * v.y + g * v.z + d * pow(v.x, 3)
  );
}

PVector hoover(PVector v) {
  float a = 1.5;
  return new PVector(
      v.y
    , -v.x + v.y*v.z
    , a - v.y*v.y);
}

PVector halvorsen(PVector v) {
  float a = 1.4;
  return new PVector(
      -a * v.x - 4 * v.y - 4 * v.z - pow(v.y, 2)
    , -a * v.y - 4 * v.z - 4 * v.x - pow(v.z, 2)
    , -a * v.z - 4 * v.x - 4 * v.y - pow(v.x, 2)
  );
}

PVector yu_wang(PVector v) {
  float a = 10;
  float b = 40;
  float c = 2;
  float d = 2.5;
  return new PVector(
      a * (v.y - v.x)
    , b * v.x - c * v.x * v.z
    , exp(v.x*v.y) - d * v.z
  );
}

PVector wang(PVector v) {
  float a = 0.2;
  float b = -0.01;
  float c = 1;
  float d = -0.4;
  float e = -1;
  float f = -1;
  return new PVector(
      a * v.x + c * v.y * v.z
    , b * v.x + d * v.y - v.x * v.z
    , e * v.z + f * v.x * v.y
  );
}

PVector lorenz(PVector v) {
  float p = 28;
  float a = 10;
  float b = 2.6666;
  return new PVector(
      a * (v.y - v.x)
    , v.x * (p - v.z) - v.y
    , v.x * v.y - b * v.z
  );
}