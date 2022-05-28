class Neuron {
  float x, y, z;
  float zOrientation;
  float r;
  float h;
  color c;
  boolean drawAxon;
  ArrayList<Neuron> neighbors;
  boolean isToDraw;
  float spike;

  Neuron(float x, float y, float z, float radius, float h, float zOrientation, boolean drawAxon) {
    isToDraw = true;
    float teta = random(0, TWO_PI);
    neighbors = new ArrayList<Neuron>();
    float auxRadius = random(0, radius * 0.8);
    this.x = x + cos(teta) * auxRadius;
    this.y = y + sin(teta) * auxRadius;
    float auxZ = constrain(h*0.5 + randomGaussian()*0.2 * h, 0, h);
    this.z = z + auxZ;
    r = 15 + random(-2, 2);
    if (zOrientation < 0) {
      this.h = auxZ + constrain(h*0.5 + randomGaussian()*0.2 * h, 0, h);
    } else {
      this.h = h - auxZ + constrain(h*0.5 + randomGaussian()*0.2 * h, 0, h);
    }
    this.zOrientation = zOrientation;
    c = zOrientation < 0 ? color(0, random(200, 255), random(200, 255)) : color(random(200, 255), 0, random(200, 255));
    this.drawAxon = drawAxon;
  }

  void draw() {
    if (!isToDraw) return;
    stroke(c, 30+spike);
    strokeWeight(r);
    point(x, y, z);
    if (drawAxon) {
      stroke(c, 30+spike);
      strokeWeight(3);
      line(x, y, z, x, y, z + zOrientation * h);
      strokeWeight(2);
      for (var n : neighbors) {
        line(x, y, z + zOrientation * h, n.x, n.y, n.z);
      }
    }
  }

  public void connect(Neuron n) {
    isToDraw = true;
    n.isToDraw = true;
    if (neighbors.size() < 10) {
    neighbors.add(n);
    }
  }

  public void stimulate() {
    if (random(0, 1) <= exp(-1000*(255-spike))) {
      spike = random(0, 255);
    }
    if (random(0, 1) <= 5) {
      spike = random(0, 200);
    }
  }

  public void update() {
    if (spike > 190) {
      for (var n : neighbors) {
        n.stimulate();
      }
    }
    spike = spike * 0.9;
  }
}

Camera cam;
CorticalColumn column;
float t;

void setup() {
  fullScreen(P3D);
  cam = new Camera(0, 0, 300, 0, 0, 0);
  column = new CorticalColumn(0, 0, 0, 400, 100, 6, 50);
  noCursor();
}

class CorticalColumn {
  Layer[] layers;
  
  CorticalColumn(int x, int y, int z, float radius, float layerH, int numLayers, int numNeuronLayer) {
    layers = new Layer[numLayers];
    for(int i = 0; i < numLayers; i++) {
      layers[i] = new Layer(x, y, z + i * layerH, radius, layerH, numNeuronLayer, i != numLayers-1, i != 0);
    }
    
    numLayers = 2 <= numLayers ? numLayers : 2;
    layers[0].connect(null, layers[1]);
    layers[numLayers-1].connect(layers[numLayers-2], null);
    for(int i = 1; i < numLayers-1; i++) {
      layers[i].connect(layers[i-1], layers[i+1]);
    }    
  }
  
  void draw() {
    for (var l : layers) 
      l.draw();
  }
  
  public void stimulate() {
    layers[0].stimulateUpper();
    layers[layers.length-1].stimulateDown();
  }
  
  public void update() {
    for (var l : layers) 
      l.update();
  }
}

void draw() {
  background(0);
  cam.positionAt(cos(t) * 700, sin(t) * 700, 500 + sin(t) * 300);
  column.stimulate();
  column.update();
  column.draw();
  t+= 0.01;
}

class HexBin {
  
  private float x, y, z, r, h;
  private boolean drawBottom, drawTop;
  private final int NUM_FACES = 6;
  
  HexBin(float x, float y, float z, float r, float h, boolean drawBottom, boolean drawTop) {
    this.x = x;
    this.y = y;
    this.z = z;
    this.r = r;
    this.h = h;
    this.drawBottom = drawBottom;
    this.drawTop = drawTop;
  }

  HexBin(float x, float y, float z, float r,float h,  boolean drawBottom) {
    this(x, y, z, r, h, drawBottom, true);
  }

  HexBin(float x, float y, float z, float r, float h) {
    this(x, y, z, r, h, true);
  }
  
  public void draw() {
    for (int i = 1; i <= NUM_FACES; i++) {
      var percentage = (float) i / NUM_FACES;
      var px = x + r * cos(percentage * TWO_PI);
      var py = y + r * sin(percentage * TWO_PI);
      var pzBottom = z; 
      var pzTop = pzBottom + h; 
      var nextPercentage = (float) (i + 1) / NUM_FACES;
      var nextPx = x + r * cos(nextPercentage * TWO_PI);
      var nextPy = y + r * sin(nextPercentage * TWO_PI);

      stroke(GRAY);
      strokeWeight(2);
      line(px, py, pzBottom, px, py, pzTop);  
      
      if (drawBottom) {
        line(px, py, pzBottom, nextPx, nextPy, pzBottom);  
      }
      
      if (drawTop) {
        line(px, py, pzTop, nextPx, nextPy, pzTop);  
      }
    }
  }
}

class Camera {

  private float centerX, centerY, centerZ;
  private float eyeX, eyeY, eyeZ;
  private float upX, upY, upZ;
  private float AXIS_SIZE = 50;

  Camera(float centerX, float centerY, float centerZ, float eyeX, float eyeY, float eyeZ) {
    up(0, 0, -1);
    positionAt(eyeX, eyeY, eyeZ);
    lookAt(centerX, centerY, centerZ);
  }

  public void lookAt(float x, float y, float z) {
    center(x, y, z);
    setCamera();
  }
  
  public void positionAt(float x, float y, float z) {
    eye(x, y, z);
    setCamera();
  }
  
  public void drawAxis() {
    strokeWeight(1);
    stroke(GREEN);
    line(-AXIS_SIZE, 0, 0, AXIS_SIZE, 0, 0);
    stroke(RED);
    line(0, -AXIS_SIZE, 0, 0, AXIS_SIZE, 0);
    stroke(BLUE);
    line(0, 0, -AXIS_SIZE, 0, 0, AXIS_SIZE);
  }

  private void setCamera() {
    camera(eyeX, eyeY, eyeZ, centerX, centerY, centerZ, upX, upY, upZ);
  }

  private void center(float x, float y, float z) {
    this.centerX = x;
    this.centerY = y;
    this.centerZ = z;
  }

  private void eye(float x, float y, float z) {
    this.eyeX = x;
    this.eyeY = y;
    this.eyeZ = z;
  }

  private void up(float x, float y, float z) {
    this.upX = x;
    this.upY = y;
    this.upZ = z;
  }
}

color BLACK     = #000000;
color WHITE     = #ffffff;
color RED       = #ff0000;
color GREEN     = #00ff00;
color BLUE      = #0000ff;
color CYAN      = #00ffff;
color MANGENTA  = #ff00ff;
color GRAY  = #888888;

class Layer {
  private HexBin hexBin;
  private Neuron[] upperNeurons, downNeurons;
  private float r;

  Layer(float x, float y, float z, float r, float h, int numNeurons, boolean drawBottom, boolean drawTop) {
    hexBin = new HexBin(x, y, z, r, h, drawBottom, drawTop);
    upperNeurons = new Neuron[numNeurons];
    downNeurons = new Neuron[numNeurons];
    for (int i = 0; i < numNeurons; i++) {
      upperNeurons[i] = new Neuron(x, y, z, r, h, 1, drawBottom);
      downNeurons[i] = new Neuron(x, y, z, r, h, -1, drawTop);
    }
    this.r = r;
  }

  Layer(float x, float y, float z, float r, float h, int numNeurons, boolean drawBottom) {
    this(x, y, z, r, h, numNeurons, drawBottom, true);
  }

  Layer(float x, float y, float z, float r, float h, int numNeurons) {
    this(x, y, z, r, h, numNeurons, true);
  }

  void draw() {
    //hexBin.draw();

    for (var n : upperNeurons)
      n.draw();

    for (var n : downNeurons)
      n.draw();
  }

  public void connect(Layer neighborBottom, Layer neighborTop) {
    if (neighborBottom != null) {
      for (var n : downNeurons) {
        for (var m : neighborBottom.downNeurons) {
          if (4 * dist(n.x, n.y, n.z - n.h, m.x, m.y, m.z) < r) {
            n.connect(m);
          }
        }

        for (var m : neighborBottom.upperNeurons) {
          if (4 * dist(n.x, n.y, n.z - n.h, m.x, m.y, m.z) < r) {
            n.connect(m);
          }
        }
      }
    }

    if (neighborTop != null) {
      for (var n : upperNeurons) {
        for (var m : neighborTop.upperNeurons) {
          if (4 * dist(n.x, n.y, n.z + n.h, m.x, m.y, m.z) < r) {
            n.connect(m);
          }
        }

        for (var m : neighborTop.downNeurons) {
          if (4 * dist(n.x, n.y, n.z + n.h, m.x, m.y, m.z) < r) {
            n.connect(m);
          }
        }
      }
    }
  }
  
  public void stimulateUpper() {
      for (var n : upperNeurons)
        n.stimulate();
  }
  public void stimulateDown() {
      for (var n : downNeurons)
        n.stimulate();
  }

  public void update() {
      for (var n : upperNeurons)
        n.update();
      for (var n : downNeurons)
        n.update();
  }
}
