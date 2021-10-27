class Satellite {
  PVector rotationAxis;
  float currentAngle;
  float speed;
  float size;


  Satellite(String id) {
        
    JSONObject j = loadJSONObject("https://api.n2yo.com/rest/v1/satellite/positions/" + id + "/41.702/-76.014/0/2/&apiKey=FZER95-DNELVS-4MWYDD-4SQ0");
    JSONArray positionsJson = j.getJSONArray("positions");
  
    JSONObject Json_pos1 = positionsJson.getJSONObject(0);
    JSONObject Json_pos2 = positionsJson.getJSONObject(1);
    
    float startLong = Json_pos1.getFloat("satlongitude");
    float startLat = Json_pos1.getFloat("satlatitude");
    
    float endLong = Json_pos2.getFloat("satlongitude");
    float endLat = Json_pos2.getFloat("satlatitude");
    
    // float startLat, float endLat, float startLong, float endLong
    
    float theta1 = radians(startLat);
    float phi1 = radians(startLong) + PI;

    float theta2 = radians(endLat);
    float phi2 = radians(endLong) + PI;

    // fix: in OpenGL, y & z axes are flipped from math notation of spherical coordinates
    PVector pos1 = new PVector(r * cos(theta1) * cos(phi1), -r * sin(theta1), -r * cos(theta1) * sin(phi1));

    PVector pos2 = new PVector(r * cos(theta2) * cos(phi2), -r * sin(theta2), -r * cos(theta2) * sin(phi2));
    
    println(pos1,pos2);
    rotationAxis = pos1.cross(pos2);

    speed = 0.01;
  }

  void update() {
    currentAngle += speed;

    pushMatrix();
    rotate(currentAngle, rotationAxis.x, rotationAxis.y, rotationAxis.z);
    translate(250, 0, 0);

    box(20);


    popMatrix();
    //println(currentAngle);
    //println(rotationAxis);
  }
}
