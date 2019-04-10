// Simulation
final float dt = 0.1;

// food parameters
final color FOOD_COLOR = #076DAA;
final float FOOD_SIZE = 3;

// Agent parameters
final float AGENT_SIZE  = 15;
final float DIST_AGENT = 80;
final float VF_COEF = 5;
final float ANGLE = PI/5;

// Scale
float rScale = 1, gbScale = 1;

// Petri
float px = 0, py = 0;
final float DIAMETER_PETRI = 600;

// Populations of agents
Population population;
boolean stopUpdatePopulation = true;
boolean stopNetwork = true;

//
boolean stopEvent = true;

// 
Resource resources;
