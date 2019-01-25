ArrayList<Circle> cs;

void setup() {
  size(1200, 1200);
  cs = new ArrayList<Circle>();
  //cs.add(new Circle());
}

void draw() {
  background(20);
  translate(width / 2, height / 2);
  resetAllTouching();
  checkTouching();
  for(Circle c : cs) {
    c.display();
  }
}

void resetAllTouching() {
  for(Circle c : cs) {
    c.resetTouching();
  }
}

void checkTouching() {
  for(Circle c1 : cs) {
    for(Circle c2 : cs) {
      if (c1 != c2 && c1.pos.dist(c2.pos) <= c1.radius + c2.radius) {
        c1.touch(c2);
        //c2.touch(c1);
      }
    }
  }
}

void mouseDragged() {
  moveLast();
}

void mouseMoved() {
  moveLast();
}

void moveLast() {
  cs.get(cs.size()-1).setPos(mouseX-width/2, mouseY-height/2);
}

void mousePressed() {
  cs.add(new Circle());
}