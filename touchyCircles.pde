Circle c, mouseC;

void setup() {
  size(1000, 1000);
  c = new Circle();
  mouseC = new Circle();
}

void draw() {
  background(20);
  translate(width / 2, height / 2);
  c.display();
  mouseC.display();
}

void mouseMoved() {
  mouseC.setPos(mouseX-width/2, mouseY-height/2);
}
