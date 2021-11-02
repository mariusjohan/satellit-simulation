class EnterButton {
  PVector pos;
  PVector size;
  String sat_id;
  int sat_counter;

  ArrayList<String> error_messages = new ArrayList<String>();

  EnterButton(PVector pos_, PVector size_) {
    pos = pos_;
    size = size_;
  }
  void update() {

    if (mousePressed == true) {

      boolean mouse_press_x = pos.x < mouseX && mouseX < pos.x + size.x;
      boolean mouse_press_y = pos.y < mouseY && mouseY < pos.y + size.y;
      
      if (mouse_press_y && mouse_press_x) {
        try {
          sat_id = cp5.get(Textfield.class, "sat_id").getText();
        } 
        catch (Exception e) {
        }

        error_messages = new ArrayList<String>();
        SatelliteUI x = new SatelliteUI(-1500, (1100+sat_counter*100)-1000, new Satellite("25544", color(255, 255, 0)));
        if (x.sat.name != "null") {
          satellitesUI.add(x);
          sat_counter++;
        }
      }
    }
  }
}
