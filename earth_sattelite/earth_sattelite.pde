// 3D Earthquake Data Visualization
// The Coding Train / Daniel Shiffman
// https://thecodingtrain.com/CodingChallenges/058-earthquakeviz3d.html
// https://youtu.be/dbs4IYGfAXc
// https://editor.p5js.org/codingtrain/sketches/tttPKxZi

float angle;

Table table;
float r = 200;

PImage earth;
PShape globe;

ArrayList<Satellite> satellites = new ArrayList<Satellite>();

void setup() {
  size(600, 600, P3D);
  earth = loadImage("earth.jpg");
  // table = loadTable("https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/significant_day.csv", "header");
  table = loadTable("https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_month.csv", "header");

  noStroke();
  globe = createShape(SPHERE, r);
  globe.setTexture(earth);
  camera(0, 0, -500, 0, 0,0,0,1,0);
  directionalLight(180,180,180,-5,-2,-1);
  
  satellites.add(new Satellite("25544"));
  satellites.add(new Satellite("36516"));
  satellites.add(new Satellite("33591"));
  satellites.add(new Satellite("29155"));
  satellites.add(new Satellite("25338"));
}

void draw() {
  clear();
  //translate(width*0.5, height*0.5);

  //angle += 0.005;
  rotateY(angle);

  background(51);

  fill(200);
  noStroke();
  //sphere(r);
  shape(globe);
  
  for (Satellite sat_i : satellites) {
    sat_i.update(); 
  }
}
