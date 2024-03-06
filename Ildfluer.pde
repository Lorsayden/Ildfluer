//Firefly program
Firefly[] fireflies = new Firefly[800];

int borderMargin = 10;
int rateOfCharge = 10;

void setup() {
  size(1000, 700);

  for (int i = 0; i < fireflies.length; i++) {
    //firefly position X, firefly position Y, totalCharge, chargeRate
    fireflies[i] = new Firefly(random(borderMargin, width-borderMargin), random(borderMargin, height-borderMargin), (int)random(-3000, 3000), rateOfCharge);
  }
}

void draw() {
  background(20);
  for (int i = 0; i < fireflies.length; i++) {
    fireflies[i].display();
    fireflies[i].move();
  }
}
