import java.util.Date;
float angle;
long time; // !c
Table table;
float r = 500;
PImage earth;
PShape globe;
ArrayList<SatelliteUI> satellitesUI = new ArrayList<SatelliteUI>();

void setup() {
  size(1000, 1000, P3D);
  textSize(100);
  
  // import earth and set texture
  earth = loadImage("earth.jpg");
  globe = createShape(SPHERE, r);
  globe.setTexture(earth);
  
  noStroke();
 
  //camera configuration
  camera(0, 0, 3000, 0, 0, 0, 0, 1, 0);
  directionalLight(180, 180, 180, -5, -2, -1);
  
  // add satellites
  satellitesUI.add(new SatelliteUI(-1500, 100-1000, new Satellite("25544",color(255,255,0))));
  satellitesUI.add(new SatelliteUI(-1500, 300-1000, new Satellite("36516",color(255,0,255))));
  satellitesUI.add(new SatelliteUI(-1500, 500-1000, new Satellite("33591",color(0,255,255))));
  satellitesUI.add(new SatelliteUI(-1500, 700-1000, new Satellite("25338",color(0,255,0))));
  satellitesUI.add(new SatelliteUI(-1500, 900-1000, new Satellite("25994",color(0,0,255))));
  satellitesUI.add(new SatelliteUI(-1500, 1100-1000, new Satellite("27424",color(0,255,0))));
  satellitesUI.add(new SatelliteUI(-1500, 1300-1000, new Satellite("38771",color(0,255,0))));
  satellitesUI.add(new SatelliteUI(-1500, 1500-1000, new Satellite("37849",color(0,255,0))));
  
  // get time of first satellite for setting timeline.
  time = satellitesUI.get(0).sat.startTime;
}

void draw() {
  clear();
  background(51);

  
  fill(255);
  
  // add 5 sec to time.
  time+=5;
  // Change date to UTC instead of unix
  Date date = new Date(time*1000);
  text(date.toString(), (-3000/2)+10, (-3000/2)+10);

  //Create the globe
  fill(200);
  noStroke();
  shape(globe);

  //draw all satellites
  for (SatelliteUI sat_i : satellitesUI) {
    //update satellites
    sat_i.sat.update(); 
    // render the satellites and UI elem.
    sat_i.render();
  }
}