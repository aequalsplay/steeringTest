class Particle {
  
  PVector position;
  PVector velocity;
  PVector acceleration;
  float r;
  float mass;
  float maxforce;  
  float maxspeed;
  float xoff;       
  float yoff;
  
  DNA dna;
  
 Particle(PVector l, DNA dna_) {
   r = random(12, 50); 
   mass = r;
   maxspeed = 0.3;
   maxforce = 0.2;
   position = l.copy();
   dna = dna_;
   acceleration = new PVector(0, 0);
   velocity = new PVector(0, 0);
 }
 
 void applyForce(PVector force) {
   acceleration.add(force).div(mass);
 }
 
  void seek(ArrayList<Particle> particle){
  float desiredSeparation = r * 2;
  PVector sum = new PVector();
  int count = 0;
  for(Particle p : particle) {
   float d = PVector.dist(p.position, position);
   if((d > 0) && (d < desiredSeparation)) {
     PVector diff = PVector.sub(position, p.position);
     diff.normalize();
     diff.div(d);
     sum.add(diff);
     count++;
   }
  }
  if( count > 0) {
   sum.setMag(maxspeed);
   PVector steer = PVector.sub(sum, velocity);
   steer.limit(maxforce);
   applyForce(steer);
  }
 }

 
 void separate(ArrayList<Object> object){
  float desiredSeparation = r * 2;
  PVector sum = new PVector();
  int count = 0;
  for(Object o : object) {
   float d = PVector.dist(position, o.position);
   if((d > 0) && (d < desiredSeparation)) {
     PVector diff = PVector.sub(position, o.position);
     diff.normalize();
     diff.div(d);
     sum.add(diff);
     count++;
   }
  }
  if( count > 0) {
   sum.setMag(maxspeed);
   PVector steer = PVector.sub(sum, velocity);
   steer.limit(maxforce);
   applyForce(steer);
  }
 }
 
 void update() {
  velocity.add(acceleration);
  velocity.limit(maxspeed);
  position.add(velocity);
  acceleration.mult(0);
  
  // Random Movement
  float vx = map(noise(xoff),0,1,-maxspeed,maxspeed);
  float vy = map(noise(yoff),0,1,-maxspeed,maxspeed);
  PVector noise = new PVector(vx,vy);
    xoff += 0.01;
    yoff += 0.01;
  applyForce(noise);
 }
 
 void display() {
  noFill();
  stroke(255);
  pushMatrix();
  translate(position.x, position.y);
  ellipse(0, 0, r, r);
  popMatrix();
 }
 
  
  // Boundaries
  void boundaries() {

    float d = 100;

    PVector force = new PVector(0, 0);

    if (position.x < d) {
      force.x = 1;
    } 
    else if (position.x > width -d) {
      force.x = -1;
    } 

    if (position.y < d) {
      force.y = 1;
    } 
    else if (position.y > height-d) {
      force.y = -1;
    } 

    force.normalize();
    force.mult(0.1);

    applyForce(force);
  }
  
   // Wraparound
  void borders() {
    if (position.x < 0) position.x = 0;
    if (position.y < 0) position.y = 0;
    if (position.x > width) position.x = width;
    if (position.y > height) position.y = height;
  }
  
 
  }
  
