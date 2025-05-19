int numPoints = 300;
float noiseScale = 0.01;
float t = 0;
boolean alignToCenter = false; 
boolean disperse = false; 
boolean freeze = false; 

void setup() {
  size(1000, 1000);
  noStroke();
  smooth();
}

void draw() {
  if (freeze) {
    
    return;
  }

  if (alignToCenter) {
    background(20); 
    translate(width / 2, height / 2); 
  } else {
    background(20, 30); 
    translate(width / 2, height / 2);
  }

  float mouseInfluenceX = map(mouseX, 0, width, -1, 1);
  float mouseInfluenceY = map(mouseY, 0, height, -1, 1);
  float mouseSpeed = dist(mouseX, mouseY, pmouseX, pmouseY);

  for (int i = 0; i < numPoints; i++) {
    float angle = map(i, 0, numPoints, 0, TWO_PI);

    float baseRadius = disperse ? 300 + random(50, 150) : 200 + 80 * sin(t + i * 0.1 + mouseInfluenceX * 2);

    for (int layer = 0; layer < 5; layer++) {
      float radius = baseRadius - layer * 20;
      float x = radius * cos(angle + mouseInfluenceY);
      float y = radius * sin(angle + mouseInfluenceX);

      float noiseVal = noise(x * noiseScale, y * noiseScale, t * 0.5);
      float size = map(noiseVal, 0, 1, 4, 12 + mouseSpeed * 0.2);

      float r = 127 + 127 * sin(t + i * 0.1 + mouseSpeed * 0.05 + layer * 0.2);
      float g = 127 + 127 * sin(t + i * 0.2 + PI / 3 + layer * 0.2);
      float b = 127 + 127 * sin(t + i * 0.3 + PI / 2 + layer * 0.2);

      fill(r, g, b, 180 - layer * 30);
      ellipse(x, y, size, size);
    }
  }

  t += 0.01;
}


void mousePressed() {
  if (mouseButton == RIGHT) {
    freeze = true; 
  } else if (mouseButton == LEFT) {
    alignToCenter = !alignToCenter; 
  }
}

void mouseReleased() {
  if (mouseButton == RIGHT) {
    freeze = false; 
  }
}

void keyPressed() {
  if (key == ' ') {
    disperse = true; 
  }
}

void keyReleased() {
  if (key == ' ') {
    disperse = false; 
  }
}
