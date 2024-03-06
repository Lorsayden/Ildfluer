class Firefly {
  //Unitvector and position of the firefly
  PVector direction = new PVector(random(-1, 1), random(-1, 1));
  float directionMagnitude = 0.2;
  float xpos;
  float ypos; 

  //color for the firefly, going from grey to yellow and firefly size
  int fireflyDiameter = 10;
  int redAndGreen = 80;
  int blue = 80;
  int colorDefault = 80;
  int colorIncrease = 5;

  //variables for the logic that makes the fireflies blink
  int maxCharge = 3000;
  int chargeRate;
  int totalCharge;
  int extraCharge = 10;
  boolean maxChargeReached = true;
  boolean discharged = true;


  Firefly(float x, float y, int charge, int rate) {
    xpos = x;
    ypos = y;
    totalCharge = charge;
    chargeRate = rate;
  }


  void display() {
    fireflyCharge();
    drawFirefly();
  }

  //if the maximal charge has been reached, increase the light, then decrease the light.
  void fireflyCharge() {
    if (totalCharge > maxCharge) {
      increaseLight();
    } else if (!maxChargeReached) {
      decreaseLight();
    } else {
      totalCharge += chargeRate;
      discharged = false;
    }
  }

  //increases the light that the firefly emits to a maximum
  void increaseLight() {
    redAndGreen = constrain(redAndGreen + colorIncrease, colorDefault, 255);
    blue = constrain(blue - colorIncrease, 0, colorDefault);
    if (redAndGreen >= 255 && blue <= 0 && !discharged) {
      fireflyProximityCheck();
      resetCharge();
    }
  }

  //decreases the light that the firefly emits to a minimum/default
  void decreaseLight() {
    redAndGreen = constrain(redAndGreen - colorIncrease, colorDefault, 255);
    blue = constrain(blue + colorIncrease, 0, colorDefault);
    if (redAndGreen <= colorDefault && blue >= colorDefault) {
      maxChargeReached = true;
    }
  }

  //After blinking, the firefly resets its charge to 0
  void resetCharge() {
    totalCharge = 0;
    maxChargeReached = false;
  }

  void drawFirefly() {
    fill(redAndGreen, redAndGreen, blue);
    ellipseMode(CENTER);
    ellipse(xpos, ypos, fireflyDiameter, fireflyDiameter);
  }


  //movement logic for the firefly
  void move() {
    //gives the firefly a direction/unitvector and speed/magnitude
    direction.x = direction.x + random(-0.06, 0.06);
    direction.y = direction.y + random(-0.06, 0.06);
    direction.normalize();
    direction.setMag(directionMagnitude);

    //change position
    xpos = xpos + direction.x;
    ypos = ypos + direction.y;

    //Wall colision detection
    collisionDetection();
  }

  //Detects collisions with the screen border
  void collisionDetection() {
    int screenBorderSize = 7;

    if (xpos < screenBorderSize && direction.x < 0 || xpos > width-screenBorderSize && direction.x > 0) {
      direction.x = -direction.x;
    }
    if (ypos < screenBorderSize && direction.y < 0 || ypos > height-screenBorderSize && direction.y > 0) {
      direction.y = -direction.y;
    }
  }

  //when blinking, the firefly checks if there are fireflies in the proximity
  void fireflyProximityCheck() {
    float distance;
    int fireflyInteractionDistance = 75;

    for (int i = 0; i < fireflies.length; i++) {
      distance = sqrt(pow(fireflies[i].xpos-xpos, 2)+pow(fireflies[i].ypos-ypos, 2));
      if (distance < fireflyInteractionDistance) {
        //giver mere eller mindre ladning baseret på hvor meget ladning den anden ildflue har
        fireflies[i].totalCharge += -fireflies[i].extraCharge*sin((TWO_PI*fireflies[i].totalCharge)/fireflies[i].maxCharge);
      }
    }
    discharged = true;
  }
}
