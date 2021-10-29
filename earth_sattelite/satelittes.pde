class Satellite {
  int id;
  PVector rotationAxis;
  float currentAngle;
  float speed;
  float size;
  String name;
  boolean isActive = true;

  PVector pos1;
  PVector pos2;
  int startTime;




  Satellite(String id_) {

    id = int(id_);
    JSONObject j = loadJSONObject("https://api.n2yo.com/rest/v1/satellite/positions/" + id_ + "/41.702/-76.014/0/2/&apiKey=FZER95-DNELVS-4MWYDD-4SQ0");
    ;
    JSONArray positionsJson = j.getJSONArray("positions");

    JSONObject Json_pos1 = positionsJson.getJSONObject(0);
    JSONObject Json_pos2 = positionsJson.getJSONObject(1);

    float startLong = Json_pos1.getFloat("satlongitude");
    float startLat = Json_pos1.getFloat("satlatitude");

    float endLong = Json_pos2.getFloat("satlongitude");
    float endLat = Json_pos2.getFloat("satlatitude");

    JSONObject infoJson = j.getJSONObject("info");
    String name = infoJson.getString("satname");


    r = (Json_pos1.getFloat("sataltitude") + 6371) / 6371 * 200;

    // float startLat, float endLat, float startLong, float endLong

    float theta1 = radians(startLat);
    float phi1 = radians(startLong) + PI;

    float theta2 = radians(endLat);
    float phi2 = radians(endLong) + PI;

    // fix: in OpenGL, y & z axes are flipped from math notation of spherical coordinates
    pos1 = new PVector(r * cos(theta1) * cos(phi1), -r * sin(theta1), -r * cos(theta1) * sin(phi1));

    pos2 = new PVector(r * cos(theta2) * cos(phi2), -r * sin(theta2), -r * cos(theta2) * sin(phi2));

    rotationAxis = pos1.cross(pos2);

    float angle_ = PVector.angleBetween(pos1, pos2);
    startTime = Json_pos1.getInt("timestamp");
    speed = angle_ * 5;
  }

  void update() {

    currentAngle += speed;

    if (isActive) {
      pushMatrix();
      rotate(currentAngle, rotationAxis.x, rotationAxis.y, rotationAxis.z);
      translate(pos1.x, pos1.y, pos1.z);
      box(20);
      popMatrix();
    }
  }
  
  void toggle() {
    isActive = !isActive;
  }
}
