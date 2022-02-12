class PipePair {

  // preset
  int gapSize = 100;
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

  //-------------------------------------------------------------------------
  void drawUpperPipe() {
    fill(#416A52);
    rect(this.x, 0, pipeWidth, upperPipeHeight);
  }
  void drawBelowPipe() {
    fill(#416A52);
    rect(this.x, belowPipeY, pipeWidth, belowPipeHeight);
  }
  void drawPipePair() {
    drawUpperPipe();
    drawBelowPipe();
  }
  //-------------------------------------------------------------------------
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
  
  void setSpeed(float newSpeed){
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
