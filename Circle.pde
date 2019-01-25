class Circle {
  PVector pos;
  float radius;
  ArrayList<Circle> touchingWith;
  ArrayList<ArrayList<PVector>> intersections;
  ArrayList<PVector> arcs;
  PVector ref;

  Circle() {
    pos = new PVector(0, 0);
    radius = 200;
    touchingWith = new ArrayList<Circle>();
    arcs = new ArrayList<PVector>();
    intersections = new ArrayList<ArrayList<PVector>>();
    //arcs.add(new PVector(0, TWO_PI));
    ref = new PVector(100, 0);
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

    ellipse(0, 0, radius*2, radius*2);

    stroke(20);
    strokeWeight(6);
    for (PVector a : arcs) {
      arc(0, 0, radius*2, radius*2, a.x, a.y);
    }
    
    strokeWeight(3);
    displayIntersectionPoints();
    stroke(250);
    line(0, 0, ref.x, ref.y);

    popMatrix();
  }

  void displayIntersectionPoints() {
    noStroke();
    fill(240);
    for (ArrayList<PVector> i : intersections) {
      for (PVector p : i) {
        ellipse(p.x, p.y, 10, 10);
        stroke(250);
        line(0, 0, p.x, p.y);
      }
    }
  }

  void touch(Circle c) {
    if (!isTouching(c)) {
      this.touchingWith.add(c);
      ArrayList<PVector> is = findIntersectionOfCircle(c);
      intersections.add(is);
      if (is.size() == 2) {
        arcs.add(calcNewNegativeArcs(is));
      }
    }
  }

  PVector calcNewNegativeArcs(ArrayList<PVector> is) {
    return new PVector(
      PVector.angleBetween(is.get(0), ref), 
      PVector.angleBetween(is.get(1), ref)
      );
  }

  void resetTouching() {
    this.touchingWith = new ArrayList<Circle>();
    this.intersections = new ArrayList<ArrayList<PVector>>();
    this.arcs = new ArrayList<PVector>();
  }

  boolean isTouching(Circle c) {
    return this.touchingWith.contains(c);
  }

  //http://paulbourke.net/geometry/circlesphere/
  ArrayList<PVector> findIntersectionOfCircle(Circle c) {
    ArrayList<PVector> intersection = new ArrayList<PVector>();

    //Calculate distance between centres of circle
    float d = PVector.dist(pos, c.pos);
    float c1r = radius;
    float c2r = c.radius;
    float m = c1r + c2r;
    float n = c1r - c2r;

    if (n < 0)
      n *= -1;

    //No solns
    if ( d > m ) {
    }

    //Circle are contained within each other
    if ( d < n ) {
    }

    //Circles are the same
    if ( d == 0 && c1r == c2r ) {
    }

    //Solve for a
    float a = ( c1r * c1r - c2r * c2r + d * d ) / (2 * d);

    //Solve for h
    float h = sqrt( c1r * c1r - a * a );

    //Calculate point p, where the line through the circle intersection points crosses the line between the circle centers.  
    PVector p = new PVector();

    p.x = pos.x + ( a / d ) * ( c.pos.x -pos.x );
    p.y = pos.y + ( a / d ) * ( c.pos.y -pos.y );

    //1 soln , circles are touching
    if ( d == c1r + c2r ) {
      intersection.add(p);
    }

    //2solns  
    PVector p1 = new PVector();
    PVector p2 = new PVector();

    p1.x = p.x + ( h / d ) * ( c.pos.y - pos.y );
    p1.y = p.y - ( h / d ) * ( c.pos.x - pos.x );

    p2.x = p.x - ( h / d ) * ( c.pos.y - pos.y );
    p2.y = p.y + ( h / d ) * ( c.pos.x - pos.x );

    intersection.add(p1.sub(pos));
    intersection.add(p2.sub(pos));

    return intersection;
  }
}
