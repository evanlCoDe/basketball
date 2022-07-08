
PImage ground;
Ball ball ;

int groundDepth = 600;
int[] ring =  {600,250, -800};
int[] eyeTarget = {ring[0],ring[1],ring[2]};
float[] myPos = {600,500,600};
Ring bring ;

void setup() {
    size(1200, 800, P3D);
    
    noStroke();
    ground = loadImage("gsw.png");
    textureMode(IMAGE);
    
    bring = new Ring(ring[0], ring[2], ring[1],50);
}

void draw() {
    background(0);
    bring.show();
    
    // ring
    pushMatrix();
    translate(ring[0],ring[1], ring[2]);
    box(50);
    popMatrix();
    
    // ground image
    beginShape();
    texture(ground);    
    vertex( -400, groundDepth, -1000 , 0 , 0);
    vertex(1600, groundDepth, -1000,849,0);
    vertex(1600, groundDepth, 1000,849,1593);
    vertex( -400, groundDepth, 1000,0,1593);
    endShape();
    
    float mxDiff = mouseX - width/2 ;
    float myDiff = mouseY - height/2 ;
    float r = 2 ;
    camera(myPos[0], myPos[1],myPos[2], 
    eyeTarget[0]+mxDiff*r,eyeTarget[1]+myDiff, eyeTarget[2], 0,1, 0);

    if( mousePressed  ){
         ball = new Ball( myPos[0] , myPos[1] , myPos[2]  , mxDiff*r , eyeTarget[2]-myPos[2] ) ;
    }
    
    
    if (keyPressed == true) {
        println(keyCode);
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
    }

    if( ball != null ){
        ball.fly(groundDepth) ;
        ball.show() ;
    }
}


void mouseClicked() {

   // ball = new Ball( myPos[0] , myPos[1] , myPos[2]-130 ) ;
    //ball = new Ball( 600 , myPos[1] , -300 ) ;
    //ball = new Ball( ring[0] , ring[1] , ring[2] ) ;

}
