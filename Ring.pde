class Ring{

  PShape s;
  int x;
  int y;
  int z;
  
  public Ring(int x, int z, int y , int radius){
    s = createShape();
    s.beginShape();
    s.noFill();
    s.stroke(250, 141, 17);
    s.strokeWeight(2);
    
    for(int i = 0;i<360;i++){
      float dx = radius*cos(i*PI/180);
      float dz = radius*sin(i*PI/180);
      s.vertex(dx,0,z+dz);
    }
    s.endShape(CLOSE);
    
    this.x = x;
    this.y = y;
    this.z = z;
  }
  
  void show(){
    
    shape(s, x , y);
  }
}
