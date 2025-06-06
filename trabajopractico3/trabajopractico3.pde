int cols = 10;
int rows = 10;
float spacing;
int modo = 1;
boolean randomColors = false;

void setup() {
  size(800, 400);
  spacing = width / 2.0 / cols;
  noFill();
}

void draw() {
  background(255);
  drawReferencePattern();   // Patrón Op Art a la izquierda
  drawInteractiveOpArt();   // Interacción a la derecha
}

// Patrón Op Art estático a la izquierda
void drawReferencePattern() {
  pushMatrix();
  translate(0, 0);

  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      float x = i * spacing + spacing / 2;
      float y = j * spacing + spacing / 2;
      drawStaticRings(x, y, spacing * 0.8, 5);
    }
  }
  popMatrix();
}

// Dibuja círculos concéntricos blancos y negros (solo para el lado izquierdo)
void drawStaticRings(float x, float y, float maxSize, int num) {
  float step = maxSize / num;
  for (int k = 0; k < num; k++) {
    float s = maxSize - k * step;
    if (k % 2 == 0) {
      fill(0);
    } else {
      fill(255);
    }
    stroke(0);
    ellipse(x, y, s, s);
  }
}

// Obra Op Art dinámica
void drawInteractiveOpArt() {
  translate(width / 2, 0);

  int numRings = int(map(mouseY, 0, height, 2, 12));
  float maxSize = map(mouseX, width / 2, width, spacing * 0.5, spacing * 1.2);

  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      float x = i * spacing + spacing / 2;
      float y = j * spacing + spacing / 2;
      drawRings(x, y, maxSize, numRings);
    }
  }
}

// Función que NO retorna valor
void drawRings(float x, float y, float maxSize, int num) {
  float step = ringStep(maxSize, num); // función que sí retorna

  for (int k = 0; k < num; k++) {
    float s = maxSize - k * step;

    stroke(randomColors ? color(random(255), random(255), random(255)) : 0);
    noFill();

    if (modo == 1) {
      ellipse(x, y, s, s);
    } else if (modo == 2) {
      rectMode(CENTER);
      rect(x, y, s, s);
    } else {
      line(x - s/2, y - s/2, x + s/2, y + s/2);
      line(x + s/2, y - s/2, x - s/2, y + s/2);
    }
  }
}

// Función que RETORNA valor
float ringStep(float maxSize, int num) {
  return maxSize / num;
}

// Teclas para cambiar modo y activar efectos
void keyPressed() {
  if (key == '1') modo = 1;
  if (key == '2') modo = 2;
  if (key == '3') modo = 3;
  if (key == 'c' || key == 'C') randomColors = !randomColors;
  if (key == 'r' || key == 'R') resetAll();
}

// Reinicio del programa
void resetAll() {
  modo = 1;
  randomColors = false;
}
// https://youtu.be/VxwjPLZQscY
