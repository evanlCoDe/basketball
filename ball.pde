class Ball {

  float x;
  float y;
  float z;

  float ballSize = 13;


  float forwardSp;
  float forwardSpz = 1;
  float upSp;
  float theta;

  int power = 50;
  int powerDir = 1;
  boolean fly;

  int bounceCount=0;

  float hitx;
  float hitz;
  float hity = 1000;

  ArrayList<Float> trackx = new ArrayList<Float>();
  ArrayList<Float> tracky = new ArrayList<Float>();
  ArrayList<Float> trackz = new ArrayList<Float>();

  Ball(float x, float y, float z, float dx, float dz) {
    theta = atan(dx / dz);
    this.x = x - 100 * sin(theta);
    this.z = z - 100 * cos(theta);
    this.y = y;
    forwardSp = -10;
    upSp = -20;

    fly = false;
  }

  void fly(int ground) {

    if (bounceCount <3) {
      //println("fly.."+x+","+y+","+z);
   
      this.z = this.z + forwardSp * cos(theta)*forwardSpz;
      this.x = this.x + forwardSp * sin(theta);



      trackx.add(x);
      trackz.add(z);
      tracky.add(y);

      this.y = this.y + upSp; 
      // gravity
      upSp += 1;

      if (this.y>ground-ballSize/2) {
        bounceCount++;
        upSp = upSp*-0.9;
      }
    }
  }

  void update(float x, float y, float z, float dx, float dz) {
    theta = atan(dx / dz);
    this.x = x - 100 * sin(theta);
    this.z = z - 100 * cos(theta);
  }

  void show() {
    // ring

    pushMatrix();
    translate(x, y, z);
    noStroke();
    lights();
    fill(252, 190, 3);
    sphere(ballSize);

    if (fly==false) {
      fill(255, 0, 0);
      rotateY(theta);
      //rect(30,-30,5,50);
      color c1 = color(204, 102, 0);
      color c2 = color(0, 102, 153);
      setGradient(30, -32, 5, 55, c1, c2);

      translate(0, 0, 5);
      fill(255, 0, 0);
      rect(30, -30+power, 5, 2);

      upSp = -60+power/2;

      if (frameCount%2==0) {
        power = power + powerDir;
      }
      if (power>50) {
        powerDir = -1;
      } else if (power<0) {
        powerDir = 1;
      }
    }
    popMatrix();

    for (int i = 0; i<trackx.size(); i++) {
      pushMatrix();
      translate(trackx.get(i), tracky.get(i), trackz.get(i));

      fill(255);
      sphere(2);

      popMatrix();
    }
  }

  void setGradient(int x, int y, float w, float h, color c1, color c2) {

    noFill();
    for (int i = y; i <= y+h; i++) {
      float inter = map(i, y, y+h, 0, 1);
      color c = lerpColor(c1, c2, inter);
      stroke(c);
      strokeWeight(10);
      line(x, i, x+w, i);
    }
    noStroke();
  }
  void checkHit(Ring ring) {
    if (upSp>=0) {
      if (abs(y-ring.y)<20 && abs(y-ring.y)<abs(hity-ring.y)) {
        hitx = x;
        hity = y;
        hitz = z;
        double d = dist(x, y, z, ring.x, ring.y, ring.z);
        println("score : "+d);
      }

      if (hity!=1000) {
        pushMatrix();
        translate(hitx, hity, hitz);

        fill(255);
        sphere(13);

        popMatrix();
      }
      if(ringBoard.insideBoard(x,y)){
        if(abs(z-ringBoard.z)<20){
          forwardSpz = -1;
        }
      }
    }
  }
}
