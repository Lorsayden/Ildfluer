//Firefly program
Firefly[] fireflies = new Firefly[200];

void setup() {

  size(1000, 800);

  for (int i = 0; i < fireflies.length; i++) {
    fireflies[i] = new Firefly(random(10, width-10), random(150, height-10), 120, 1000, random(2,10)); // Pass speed as i+1 to vary speed
    //fireflies[i] = new Firefly(random(40, 80), random(40, 80), 120, 1000, random(2, 10));
  }
}

void draw() {
  background(0);
  for (int i = 0; i < fireflies.length; i++) {
    fireflies[i].display();
  }
}
