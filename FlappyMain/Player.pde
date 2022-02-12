class Player {

  PShape otter;

  PVector loc;
  PVector vel;
  PVector acc;

  boolean ready = false;
  boolean isCollided = false;

  Player(int x, int y) {
    //this.x = x;
    //this.y = y;

    otter = loadShape("nurOtter.svg");
    loc = new PVector(width/4, height/2);
    vel = new PVector(0, 0);
    acc = new PVector(0, 0);
  }

  void update() {
    if (ready==true) {
      acc.add(0, 0.3);
      vel.add(acc);
      loc.add(vel);
    }

    if (this.loc.y>=height) {
      this.loc.y = 0;
    }
    if (this.loc.y < 0) {
      this.loc.y = height;
    }

    if (vel.y < -6.0) {
      vel.y = -6.0;
    }

    acc.mult(0);
  }

  void display() {
    translate(loc.x, loc.y);
    
    circle(0, 0, 200);
    
    float angle = map(this.vel.y, 6, -10, -PI/4, PI/4);
    
    //translate(loc.x, loc.y);
    translate(-loc.x, -loc.y);
    rotate(angle);
    shape(otter, this.loc.x, this.loc.y, 50, 50);

    //translate(-loc.x, -loc.y);
    
    translate(-loc.x, -loc.y);
    
    
    fill(255, 155, 50, 50);
    circle(loc.x, loc.y, 23.7);
    //fill(255,255,0);
    //circle(loc.x, loc.y, 1.5);

    //drawCoordinatesText();
  }

  void applyForce(PVector force) {
    acc.add(force);
  }

  void drawCoordinatesText() {
    fill(50);
    text("x: " + loc.x, 10, 20);
    text("y: " + loc.y, 10, 40);
  }
}
