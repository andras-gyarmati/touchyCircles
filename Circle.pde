class Circle {
  PVector pos;
  float radius;

  Circle() {
    pos = new PVector(0, 0);
    radius = 20;
  }

  void setPos(float x, float y) {
    pos.set(x, y);
  }

  void display() {
    stroke(200);
    noFill();
    pushMatrix();
    translate(pos.x, pos.y);
    ellipse(0, 0, radius, radius);
    popMatrix();
  }
}
