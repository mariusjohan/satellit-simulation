class SatHandler {
  int sat_counter =1;

  ArrayList<String> error_messages = new ArrayList<String>();

  SatHandler() {
  }

  void new_sat(String sat_id) {
    error_messages = new ArrayList<String>();
    
    try {
      SatelliteUI x = new SatelliteUI(-1500, (1100+sat_counter*200)-1000, new Satellite(sat_id, color(int(random(0,255)), int(random(0,255)), int(random(0,255)))));
      x.sat.startTime -= time;
      satellitesUI.add(x);
      sat_counter++;
    } catch(Exception e) {
      println("sat_id is not valid: ", sat_id);
    }
  }
}
