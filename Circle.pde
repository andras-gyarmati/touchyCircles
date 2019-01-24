class Circle {
  PVector pos;
  float radius;
  ArrayList<Circle> touchingWith;
  ArrayList<PVector> arcs;

  Circle() {
    pos = new PVector(0, 0);
    radius = 100;
    touchingWith = new ArrayList<Circle>();
    arcs = new ArrayList<PVector>();
    arcs.add(new PVector(0, TWO_PI-1));
  }

  void setPos(float x, float y) {
    pos.set(x, y);
  }

  void display() {
    stroke(200);
    strokeWeight(3);
    noFill();
    if (touchingWith.size() > 0) {
      stroke(255, 0, 0);
    }
    pushMatrix();
    translate(pos.x, pos.y);
    if (touchingWith.size() > 0) {
      float angle = PVector.angleBetween(pos.copy().sub(touchingWith.get(0).pos), new PVector(-1, 0));
      rotate(angle);
    }
    for(PVector a : arcs) {
      arc(0, 0, radius*2, radius*2, a.x, a.y);
    }
    popMatrix();
  }
  
  void touch(Circle c) {
    if(!isTouching(c)) {
      this.touchingWith.add(c);
    }
  }
  
  void resetTouching() {
    this.touchingWith = new ArrayList<Circle>();
  }
  
  boolean isTouching(Circle c) {
    return this.touchingWith.contains(c);
  }
}