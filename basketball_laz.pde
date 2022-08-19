PImage ground;
PImage[] loadMan = new PImage[72];
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
  for(int i = 0;i<loadMan.length;i++){
    String t = ""+i;
    if(i<10){
      t="0"+t;  
    }
    
    loadMan[i] = loadImage("img1/frame_"+t+"_delay-0.03s.png");
  }
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
    if(ball.addScore==false && ball.checkHit(ring)==true){
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
  showStartBoard();
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
//---------
void showStartBoard() {
    // draw Message Board
    rectMode(CENTER);
    fill(44, 48, 56 , 240);
    rect(width / 2 , height / 2 ,width / 2 , height * 4 / 5);
    
    pushMatrix();
    translate(0,0,10);
    
    // logo balls
    int cx = 400;
    int cy = 250;
    for (int i = 0; i < 10; ++i) {
        fill(150,150,150, 100 + i * 5);
        stroke(255);
        circle(cx,cy ,50 + i * 5); 
        cx += 20;
        cy += 2 * i;   
    }

    
    // loading 
    //if (loadingAnimation) {
    //    // loading man
        
        image(loadMan[(frameCount / 2) % 72] , 350,400);
        
        
    //} else{        
    //    // button
        int rectx = width / 2;
        int bty = height / 2 + 200;
        
        rect(rectx , bty , 300, 100,50);
        // check mouse over
        //if (abs(mouseX - rectx) < 300 / 2) {
        //    if (abs(mouseY - recty) < 100 / 2) {
        //        //println("mouse over !!" + frameCount);
        //        //println("dx " + abs(mouseX - rectx));
        //        //println("dy " + abs(mouseY - recty));
        //        if (mousePressed == true && timer == -9) {
        //            timer = -8; // start to count down
        //        }
        //    }
        //}        
        // triangle
        fill(255);
        int tx = width / 2 - 30;
        int ty = bty - 30;
        triangle(tx , ty , tx + 50 , ty + 30 , tx , ty + 60);
        popMatrix();
    }
