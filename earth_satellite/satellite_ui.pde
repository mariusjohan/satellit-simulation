class SatelliteUI {

  PVector buttonPos; // button position
  boolean isActive = true; //is satellite displayed
  boolean spam = true; // preventing unintentional clicks. Without this the button is not usable. If the user clicks a button it will update multiple times. 
  Satellite sat; // the sat correnponding to the UI elem.

  SatelliteUI(float startX, float startY, Satellite satellite) {
    // create button pos vector.
    buttonPos = new PVector(startX, startY);
    sat = satellite;
  }

  void render() {
    // checks if button is pressed. If it is, toggle the sat.
    if (CheckForButtonPress()) {
      sat.Toggle();
      isActive = !isActive;
    }
    if (isActive) {
      fill(sat.satColor);
    } else {
      fill(255, 0, 0);
    }

    text(sat.name, buttonPos.x+75, buttonPos.y+30);

    circle(buttonPos.x, buttonPos.y, 100);
  }
  
  // check if the corrensponding button has been pressed.
  boolean CheckForButtonPress() {
    if (mousePressed && spam) {
      spam = false;
      PVector mousePos = new PVector(map(mouseX, 0, 1000, -1750, 1750), map(mouseY, 0, 1000, -1750, 1750));
      if (mousePos.dist(buttonPos) <= 100) {
        return true;
      }
    } 
    if (!mousePressed) {
      spam = true;
    }
    return false;
  }
}
