class World {
 
    
  ArrayList<Particle> particles;
  ArrayList<Object> objects;
  
  
  World(int num) {
    particles = new ArrayList<Particle>();
    objects = new ArrayList<Object>();
    
    for (int i = 0; i < num; i++) {
      PVector l = new PVector(random(width),random(height));
      DNA dna = new DNA();
    particles.add(new Particle(l,dna));
    objects.add(new Object(l,dna));
  }
}

void run() {
  for (int i = particles.size()-1; i >= 0; i--) {
     
      Object o = objects.get(i);
         o.update();
         o.display();
         o.boundaries();
         o.borders();
         o.separate(world.particles);
  
  for (int j = particles.size()-1; j >= 0; j--) {
     
      Particle p = particles.get(i);
         p.update();
         p.display();
         p.boundaries();
         p.borders();
         p.separate(world.objects);
}
}
}
}
