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

Satellite sat;

void setup() {
  size(600, 600, P3D);
  earth = loadImage("earth.jpg");
  // table = loadTable("https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/significant_day.csv", "header");
  table = loadTable("https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_month.csv", "header");

  noStroke();
  globe = createShape(SPHERE, r);
  //globe.setTexture(earth);
  camera(0, 0, -500, 0, 0,0,0,1,0);
  directionalLight(180,180,180,-5,-2,-1);
  
  sat = new Satellite("25544");

}

void draw() {
  clear();
  //translate(width*0.5, height*0.5);

  background(51);
  //angle += 0.05;

  fill(200);
  noStroke();
  //sphere(r);
  shape(globe);
  sat.update();

}
