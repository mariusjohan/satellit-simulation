import java.util.Date;
float angle;
long time; // !c
Table table;
float r = 200;
PImage earth;
PShape globe;
ArrayList<Satellite> satellites = new ArrayList<Satellite>();

void setup() {
  size(1000, 1000, P3D);
  textSize(100);

  earth = loadImage("earth.jpg");

  noStroke();
  globe = createShape(SPHERE, r);
  globe.setTexture(earth);
  camera(0, 0, 3000, 0, 0, 0, 0, 1, 0);
  directionalLight(180, 180, 180, -5, -2, -1);

  satellites.add(new Satellite("25544"));
  satellites.add(new Satellite("36516"));
  satellites.add(new Satellite("33591"));
  satellites.add(new Satellite("29155"));
  satellites.add(new Satellite("25338"));
  time = satellites.get(0).startTime;
}

void draw() {
  clear();
  background(51);
  time+=5;

  fill(255);

  Date date = new Date(time*1000);

  text(date.toString(), (-3000/2)+10, (-3000/2)+10);


  angle += 0.005;
  rotateY(angle);


  fill(200);
  noStroke();
  shape(globe);

  for (Satellite sat_i : satellites) {
    sat_i.update(); 
    println(sat_i.name);
  }
}
