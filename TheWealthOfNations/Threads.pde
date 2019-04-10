void updatePopulation() {
  stopUpdatePopulation = false;
  population.update();
  stopUpdatePopulation = true;
}

void network() {
  stopNetwork = false;
  population.network();
  stopNetwork = true;
}

void event() {
  stopEvent = false;
  
  stopEvent = true;  
}
