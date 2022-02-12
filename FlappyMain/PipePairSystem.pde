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
