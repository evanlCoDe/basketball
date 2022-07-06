class ball{
  float x;
  float y;
  float z;
  
  float forwardSp;
  float upSp;
  
  ball(float x, float y, float z){
    this.z = z;
    this.y = y;
    this.x = x;
    forwardSp = -10;
    upSp = -20;
  }
  
  void fly(){
    this.z = this.z +forwardSp;
    this.y = this.y + upSp;
    upSp+=1 ;
  }
  
  void show(){
    pushMatrix();
    translate(x,y,z);
    noStroke();
    sphere(10);
    popMatrix();
  }
}
