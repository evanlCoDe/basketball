PImage ground;
RingBoard ringBoard ;
Ball ball ;
Scoreboard sb ;


int groundDepth = 600;
int[] eyeTarget;
float[] myPos = {600, 500, 600};
Ring ring ;

void setup() {
  size(1200, 800, P3D);    
  noStroke();
  textureMode(IMAGE);

  ground = loadImage("gsw.png");
  PImage RBI = loadImage("ring_board.jpg");
  ringBoard = new RingBoard(RBI);
  // ------
  // free throw line : 15ft --> 268
  // ring height     : 10ft(305cm) --> getPixel(305)    
  ring = new Ring( 600, -722, groundDepth-getPixel(305), 26) ;
  sb = new Scoreboard( "Evan", 30) ;
  eyeTarget = new int[]{ring.x, ring.y, ring.z};

  println("center : "+getPixel(37.96));
  println("ring : "+getPixel(45.72));
}

void draw() {
  background(0);
  // ring
  ring.show(); 

  // 
  sb.show();
  if (frameCount%60 == 0) {
    sb.countdown();
  }


  // mark
  pushMatrix();
  translate(ring.x, groundDepth, -476);
  box(5);
  popMatrix();
  // wall
  pushMatrix();
  translate(ring.x, groundDepth, -746);
  fill(0, 0, 50, 105);
  box(100, 500, 1);
  popMatrix();

  groundImage();
  ringBoard.show();

  float mxDiff = mouseX - width/2 ;
  float myDiff = mouseY - height/2 ;
  float r = 2 ;
  camera(myPos[0], myPos[1], myPos[2], 
    eyeTarget[0]+mxDiff*r, eyeTarget[1]+myDiff, eyeTarget[2], 0, 1, 0);

  if ( mousePressed  ) {
    if (ball==null || ball.bounceCount>=3) {
      ball = new Ball( myPos[0], myPos[1], myPos[2], mxDiff*r, eyeTarget[2]-myPos[2] ) ;
    }
  }
  if (ball!=null) {
    if (ball.fly) {
      ball.fly(groundDepth);
    } else {
      ball.update( myPos[0], myPos[1], myPos[2], mxDiff*r, eyeTarget[2]-myPos[2] ) ;
    }
    ball.show();
    if(ball.checkHit(ring)==true){
      sb.addScore(2);
    }
  }




  if (keyPressed == true) {
    // println(keyCode);
    // 38,40,37,39
    switch(keyCode) {
    case 38 ://up
      myPos[2] -= 10;
      break;
    case 40 ://down
      myPos[2] += 10;
      break;
    case 37 ://left
      myPos[0] -= 10;
      eyeTarget[0] -= 10;
      break;
    case 39 ://right
      myPos[0] += 10;
      eyeTarget[0] += 10;

      break;
    }
    //println("z--->"+myPos[2]);
  }
}

void groundImage() {
  // ground image

  beginShape();
  texture(ground);    
  vertex( -400, groundDepth, -1000, 0, 0);
  vertex(1600, groundDepth, -1000, 849, 0);
  vertex(1600, groundDepth, 1000, 849, 1593);
  vertex( -400, groundDepth, 1000, 0, 1593);
  endShape();
}



void mouseClicked() {

  // ball = new Ball( myPos[0] , myPos[1] , myPos[2]-130 ) ;
  //ball = new Ball( 600 , myPos[1] , -300 ) ;
  //ball = new Ball( ring[0] , ring[1] , ring[2] ) ;
}

int getPixel(float cm ) {
  float ft = 0.032808399*cm;
  return (int)(ft*268/15) ; // 268 pixels <--> 15 fts
}

void mouseReleased() {
  if (ball!=null && ball.fly==false) {
    ball.fly=true;
  }
}
