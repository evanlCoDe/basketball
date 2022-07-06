PImage ground;
ball b1;

int groundDepth = 600;
int[] target =  {600,250, -800};
int[] eyeTarget = {600,250, -800};
float[] myPos = {600,500,600};

void setup() {
    size(1200, 800, P3D);
    
    noStroke();
    ground = loadImage("gsw.png");
    textureMode(IMAGE);
}

void draw() {
    background(0);
    
    // ring
    pushMatrix();
    translate(target[0],target[1], target[2]);
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
    
    float mxDiff = mouseX - width/2;
    float myDiff = mouseY - height/2;
    camera(myPos[0], myPos[1],myPos[2], eyeTarget[0]+mxDiff,eyeTarget[1]+myDiff, eyeTarget[2], 0,1, 0);
    
    
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
        if(b1 != null){
          b1.fly();
          b1.show();
        }
    }
}

void mouseClicked(){
  b1 = new ball(myPos[0],myPos[1],myPos[2]-130);
}
