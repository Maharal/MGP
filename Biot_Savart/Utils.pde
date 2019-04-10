PVector rand() {
  return new PVector(randomGaussian() * SIZE_BOX, randomGaussian() * SIZE_BOX, randomGaussian() * SIZE_BOX);
}

PVector rand(PVector pos) {
  return (new PVector(randomGaussian() * SIZE_BOX/2, randomGaussian() * SIZE_BOX/2, randomGaussian() * SIZE_BOX/2)).add(pos);
}

boolean outOfBox(PVector pos) {
  return box && (pos.x <= -SIZE_BOX/2 || pos.x >= SIZE_BOX/2 ||
                 pos.y <= -SIZE_BOX/2 || pos.y >= SIZE_BOX/2 ||
                 pos.z <= -SIZE_BOX/2 || pos.z >= SIZE_BOX/2);
}