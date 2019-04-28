 DNA dna;
 Object o;
 Particle p;
 World world;
 
void setup() {
  size(640, 320, P2D);
  
  int n = 10;
  world = new World(n);
 
}


void draw() {
  background(0);
  world.run();
   
}
