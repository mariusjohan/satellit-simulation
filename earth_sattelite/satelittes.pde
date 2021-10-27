

class Satellite {
  PVector rotationAxis;
  float currentAngle;
  float speed;
  float size;


  Satellite(float startLat, float endLat, float startLong, float endLong) {

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
