class Satellite {

  int id; // id of object
  PVector rotationAxis; // axis of rotion of object
  float currentAngle; // current angle of the sat.
  float speed; // speed of sat
  String name; // name of sat
  boolean isActive = true; // is the sat active?

  PVector pos1; // first pos of sat from api
  PVector pos2; // second pos of sat from api
  int startTime; // first pos timestamp unix format
  color satColor; // Color of the sat

  Satellite(String id_, color col) {
    id = int(id_);
    // load the API json object with the id as regex
    JSONObject j = loadJSONObject("https://api.n2yo.com/rest/v1/satellite/positions/" + id_ + "/41.702/-76.014/0/2/&apiKey=FZER95-DNELVS-4MWYDD-4SQ0");
    // get the pos arrays
    JSONArray positionsJson = j.getJSONArray("positions");

    //take out both pos arrays as objects
    JSONObject Json_pos1 = positionsJson.getJSONObject(0);
    JSONObject Json_pos2 = positionsJson.getJSONObject(1);

    // get the different positions
    float startLong = Json_pos1.getFloat("satlongitude");
    float startLat = Json_pos1.getFloat("satlatitude");
    float endLong = Json_pos2.getFloat("satlongitude");
    float endLat = Json_pos2.getFloat("satlatitude");

    // get meta info about sat. name, time.
    JSONObject infoJson = j.getJSONObject("info");


    name = infoJson.getString("satname");




    startTime = Json_pos1.getInt("timestamp");

    // normalize radius
    r = (Json_pos1.getFloat("sataltitude") + 6371) / 6371 * 500;

    // define variables for later calculations
    float theta1 = radians(startLat);
    float phi1 = radians(startLong) + PI;
    float theta2 = radians(endLat);
    float phi2 = radians(endLong) + PI;

    // calc the two pos vectors.
    pos1 = new PVector(r * cos(theta1) * cos(phi1), -r * sin(theta1), -r * cos(theta1) * sin(phi1));
    pos2 = new PVector(r * cos(theta2) * cos(phi2), -r * sin(theta2), -r * cos(theta2) * sin(phi2));

    // calc the rotation axis. The rotation axis is what the object will be spinning around.
    rotationAxis = pos1.cross(pos2);

    // get the angle between the two pos.
    float angle_ = PVector.angleBetween(pos1, pos2);
    // calc the speed. since time is always with 1 sec delta, we get. angle/1 = angle. We mult by 5 for 5 sec for faster animation.
    speed = angle_ * 5;

    satColor = col;
  }

  void update() {
    fill(satColor);

    // update the angle with speed.
    currentAngle += speed;

    // if the sat is active. draw it on screen according to its rotationaxis and current angle.
    if (isActive) {
      pushMatrix();
      rotate(currentAngle, rotationAxis.x, rotationAxis.y, rotationAxis.z);
      translate(pos1.x, pos1.y, pos1.z);
      box(20);
      popMatrix();
    }
  }

  // toggle if the sat is visible.
  void Toggle() {
    isActive = !isActive;
  }
}
