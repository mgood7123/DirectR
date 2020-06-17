DirectR g2;

void settings() {
  // 23 FPS
  //fullScreen(P3D);
  
  // 60FPS
  size(500, 500, P3D);
}

boolean originallyLooping;

void setup() {
  background(0);
  g2 = new DirectR(this, width, height);
  
  // create a new FBO and set up a texture
  g2.beginDraw_();
  
  looping = false;
  
  originallyLooping = looping;
}

void exit() {
  // destroy the FBO and copy its texture to the PGraphic texture
  g2.endDraw_();
  super.exit();
}

int wrap(int count, int max) {
  int remainder = count % (max+1);
  if (count > max) return remainder;
  else return count;
}

void drawBox() {
  // draw a box onto the PGraphics object
  g2.background(0);
  int c = wrap(frameCount, 255);
  g2.fill(0, c, c);
  if (frameCount == 1) g2.lights();
  g2.noStroke();
  //g2.translate(width/2, height/2);
  //g2.rotateX(frameCount/100.0);
  //g2.rotateY(frameCount/200.0);
  g2.box(40);
}

// TODO: reset geometry and related on each draw

void draw() {
  if (!looping) looping = true;
  
  background(0);

  //g2.beginDraw();
  drawBox();
  //g2.endDraw();
  //image(g2, 0, 0);
  // render the PGraphic's FBO, note this fails in loop mode
  g2.imageFrameBuffer();
  
  int oldColor = getGraphics().fillColor;
  fill(255);
  textSize(16);
  text("frameCount = " + frameCount + ", FPS: " + frameRate, 10, 20);
  fill(oldColor);
}
