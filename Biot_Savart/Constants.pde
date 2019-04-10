final int SIZE_BOX = 1500;
final int SIZE_TRACE = 100;
final int NUM_PARTICLES = 2000;

final color TRACE_COLOR = #F73E3E;//#855AFF;
final color WHITE = #ffffff;
final color BLACK = #000000;
final color DGRAY = #222222;

final float dt = 0.1;
final float omega = TWO_PI/(dt*500);
final float I = 0.5;
final float K = 3e2;
boolean box = false;