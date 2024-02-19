class Firefly {

  float xpos;
  float ypos;
  float xspeed;
  float yspeed;
  int rg = 125;
  int b = 125;
  float maxChemicalCharge;
  float chargeRate;
  float totalCharge = 0;
  boolean chargeUp = true;

  Firefly(float x, float y, color bodyColor, float maxCharge, float rate) {
    xpos = x;
    ypos = y;
    maxChemicalCharge = maxCharge;
    chargeRate = rate;
  }

  void display() {
    if (totalCharge > maxChemicalCharge && chargeUp) {
      rg = rg + 13;
      b = b - 13;
      if (rg >= 250 && b <= 5) {
        chargeUp = false;
      }
    } else if (!chargeUp) {
      rg = rg - 13;
      b = b + 13;
      totalCharge = totalCharge + -2*chargeRate;
      if (rg <= 125 && b >= 125) {
        chargeUp = true;
      }
    }else{
      totalCharge += chargeRate;
    }
    fill(rg, rg, b);
    ellipse(xpos, ypos, 15, 15);
    
  }

  void move() {
  }
}
