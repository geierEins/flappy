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

  textSize(80);    
  if (count>=0) {
    text(count, width/2, height/2);
  }else{
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
