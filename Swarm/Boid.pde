class Boid {

  PVector pos, vel, acc;
  color c;
  float neighbordist;
  Boid() {
    pos = new PVector(random(-SIZE_BOX/2, SIZE_BOX/2), random(-SIZE_BOX/2, SIZE_BOX/2), random(-SIZE_BOX/2, SIZE_BOX/2));
    acc = new PVector(randomGaussian(), randomGaussian(), randomGaussian());
    vel = new PVector(randomGaussian(), randomGaussian(), randomGaussian());
    vel.setMag(1);
    c = color(random(0, 1), 1, 1);
    neighbordist = random(200, 400);
  }

  void update(ArrayList<Boid> boids) {
    acc.add(align(boids));
    acc.add(cohesion(boids));
    acc.add(separate(boids));
    acc.limit(5);
    acc.add(wallForce(false));

    vel.add(PVector.mult(acc, dt));
    vel.setMag(25);
    pos.add(PVector.mult(vel, dt));
  }

  PVector wallForce(boolean qua) {
    PVector aux = new PVector();

    if (qua) {
      if (SIZE_BOX * DIST_WALL < pos.x) {
        aux.x += -WALL_FORCE/(SIZE_BOX/2 - pos.x);
      } else if (pos.x < -SIZE_BOX * DIST_WALL) {
        aux.x += -WALL_FORCE/(pos.x - SIZE_BOX/2);
      }   

      if (SIZE_BOX * DIST_WALL < pos.y) {
        aux.y += -WALL_FORCE/(SIZE_BOX/2 - pos.y);
      } else if (pos.y < -SIZE_BOX * DIST_WALL) {
        aux.y += -WALL_FORCE/(pos.y - SIZE_BOX/2);
      }   

      if (SIZE_BOX * DIST_WALL < pos.z) {
        aux.z += -WALL_FORCE/(SIZE_BOX/2 - pos.z);
      } else if (pos.z < -SIZE_BOX * DIST_WALL) {
        aux.z += -WALL_FORCE/(pos.z - SIZE_BOX/2);
      }
    } else {
      if (pos.mag() > 0.6*SIZE_BOX) {
       aux.add(PVector.mult(pos, -0.0001)); 
      }
    }
    
    return aux;
  }

  void draw() {

    PVector k = vel.copy().limit(1);
    colorMode(HSB, 1);
    stroke(0.6-k.x*0.6, 1-k.y, 2-k.z);
    fill(0.05);

    pushMatrix();

    translate(pos.x, pos.y, pos.z);
    float rho = sqrt(pow(vel.x, 2)+pow(vel.y, 2)+pow(vel.z, 2));
    rotateZ(atan2(vel.y, vel.x));
    rotateY(acos(vel.z/rho));
    rotateX(HALF_PI);

    // asa esquerda
    beginShape();
    vertex(-LARG * SCALE, 0, 0);
    vertex(-_LARG * SCALE, 0, 0);
    vertex(0, COMP * SCALE, 0);
    endShape(CLOSE);

    // asa direita
    beginShape();
    vertex(LARG * SCALE, 0, 0);
    vertex(_LARG * SCALE, 0, 0);
    vertex(0, COMP * SCALE, 0);
    endShape(CLOSE);

    // lig. asa esquerda
    beginShape();
    vertex(0, 0, -CHAN * SCALE);
    vertex(-_LARG * SCALE, 0, 0);
    vertex(0, COMP * SCALE, 0);
    endShape(CLOSE);

    // lig. asa direita
    beginShape();
    vertex(0, 0, -CHAN * SCALE);
    vertex(_LARG * SCALE, 0, 0);
    vertex(0, COMP * SCALE, 0);
    endShape(CLOSE);

    popMatrix();
  }


  PVector separate (ArrayList<Boid> boids) {
    PVector steer = new PVector(0, 0, 0);
    int count = 0;
    for (Boid other : boids) {
      float d = PVector.dist(pos, other.pos);
      if (d > 10 && d < desiredseparation) {
        PVector diff = PVector.sub(pos, other.pos);
        diff.normalize();
        diff.div(d);        
        steer.add(diff);
        count++;
      }
    }

    if (count > 0) {
      steer.div((float)count);
    }

    if (steer.mag() > 0) {
      steer.normalize();
      steer.mult(MAX_SPEED);
      steer.sub(vel);
      steer.limit(MAX_FORCE);
    }
    return steer;
  }

  PVector align (ArrayList<Boid> boids) {
    PVector sum = new PVector(0, 0);
    int count = 0;
    for (Boid other : boids) {
      float d = PVector.dist(pos, other.pos);
      if (d > 10 && d < neighbordist) {
        sum.add(other.vel);
        count++;
      }
    }
    if (count > 0) {
      sum.div((float)count);
      sum.normalize();
      sum.mult(MAX_SPEED);
      PVector steer = PVector.sub(sum, vel);
      steer.limit(MAX_FORCE);
      return steer;
    } else {
      return new PVector(0, 0);
    }
  }

  PVector seek(PVector target) {
    PVector desired = PVector.sub(target, pos);  // A vector pointing from the position to the target
    desired.normalize();
    desired.mult(MAX_SPEED);

    PVector steer = PVector.sub(desired, vel);
    steer.limit(MAX_FORCE); 
    return steer;
  }

  PVector cohesion (ArrayList<Boid> boids) {
    PVector sum = new PVector(0, 0); 
    int count = 0;
    for (Boid other : boids) {
      float d = PVector.dist(pos, other.pos);   
      if (d > 10 && d < 50) {
        sum.add(other.pos); 
        count++;
      }
    }
    if (count > 0) {
      sum.div(count);
      return seek(sum);
    } else {
      return new PVector(0, 0);
    }
  }
}
