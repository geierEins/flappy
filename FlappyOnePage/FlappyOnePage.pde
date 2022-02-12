Player player;
PipePairSystem pps;
long time;
int timer;
int millisTilPipeSpawn;
int count;
float mainSpeed;

void setup() {
  size (1000, 700);
  frameRate(60);
  millisTilPipeSpawn = 2000;
  count = -2;

  // new PipePairSystem
  pps = new PipePairSystem();

  // new Player
  player = new Player(0, 0);
}

void draw() {
  background(255);
  //showLocAcc();

  //timer to add a new PipePair
  if (millis() - timer >= millisTilPipeSpawn) {
    pps.addPipePair();
    count++;
    timer = millis();
  }
  fill(#432D2D);
  textSize(80);    
  if (count>=0) {
    text(count, width/2, height/2);
  } else {
    text(0, width/2, height/2);
  }
  // collision statement
  for (int i = 0; i < pps.pipes.size(); i++) { 
    PipePair pp = pps.pipes.get(i);
    if (pp.collides(player.loc )) {
      text(count, width/2, height/2);
      delay(1000000000);
    }
  }

  pps.run();

  player.update();
  player.display();
}

void mousePressed() {
  player.vel.add(0, -14.5);
  player.acc.mult(0);
  player.ready = true;
}

void showLocAcc() {
  println("Loc.y = " + player.loc.y + ", Vel.y: " + player.vel.y + ", Acc.y: " + player.acc.y);
}

void drawCollisionBox() {
  fill(255, 0, 0);
  rect(width/4, height/4, width/2, height/2);
  fill(0, 0, 0);
  text("Collision", width/2, height/2);
}
//-------------------------------------------------------------
class PipePair {

  // preset
  int gapSize = 90;
  int pipeWidth = 75;

  // to be initialized
  int x;
  float speed;
  int gapHeight;

  // to be calculated
  int belowPipeY;
  int upperPipeHeight;
  int belowPipeHeight;

  PipePair(int x, int gapHeight, float speed) {
    this.x = x;
    this.gapHeight = gapHeight;
    this.speed = speed;
    belowPipeY = gapHeight + (gapSize/2);
    belowPipeHeight = height - belowPipeY;
    upperPipeHeight = gapHeight - (gapSize/2);
  }

  void update() {
    x+=speed;
  }

  void display() {
    drawPipePair();
  }


  void drawUpperPipe() {
    strokeWeight(2);
    stroke(#7C1D1E);
    fill(#F2494C, 50);
    rect(this.x, 0, pipeWidth, upperPipeHeight);
  }
  void drawBelowPipe() {
    strokeWeight(2);
    stroke(#7C1D1E);
    fill(#F2494C, 50);
    rect(this.x, belowPipeY, pipeWidth, belowPipeHeight);
  }
  void drawPipePair() {
    drawUpperPipe();
    drawBelowPipe();
  }

  boolean collides(PVector loc) {
    if (loc.x > this.x &&
      loc.x < this.x + this.pipeWidth &&
      loc.y < this.upperPipeHeight ||

      loc.x > this.x &&
      loc.x < this.x + this.pipeWidth &&
      loc.y > this.belowPipeY) {
      return true;
    } else {
      return false;
    }
  }

  void setSpeed(float newSpeed) {
    this.speed = newSpeed;
  }

  boolean isDead() {
    if (x<=-width) {
      return true;
    } else {
      return false;
    }
  }
}
//--------------------------------------------------------------------------------
class PipePairSystem {

  ArrayList<PipePair> pipes;

  float pipePairSystemSpeed;

  PipePairSystem() {
    pipes = new ArrayList<PipePair>();
    pipePairSystemSpeed = -3;
  }

  void addPipePair() {
    pipes.add(new PipePair(width, (int)random(100, height-100), pipePairSystemSpeed));
  }

  void run() {
    for (int i=0; i<pipes.size(); i++) {
      PipePair pp = pipes.get(i);
      if (pp.isDead()) {
        pipes.remove(pp);
      }

      pp.update();
      pp.display();
    }
  }
}
//--------------------------------------------------------------------------------
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

    //otter = loadShape("nurOtter.svg");
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

    //circle(0, 0, 200); // ursprung zur kontrolle von (0,0);

    //translate(-25, -25);
    //shape(otter, this.loc.x, this.loc.y, 50, 50);
    //translate(25, 25);
    fill(255, 155, 25, 25);
    circle(loc.x, loc.y, 25);
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
//--------------------------------------------------------------------------------
