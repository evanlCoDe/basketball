class Ball{
    
    float x;
    float y;
    float z;
    
    
    float forwardSp;
    float upSp;
    float theta;
    Ball(float x , float y , float z , float dx , float dz) {
        theta = atan(dx / dz);
        this.x = x - 100 * sin(theta);;
        this.z = z - 100 * cos(theta);
        this.y = y;
        forwardSp = -10;
        upSp = -20;
    }
    
    void fly(int ground) {
        
        this.z = this.z + forwardSp * cos(theta);
        this.x = this.x + forwardSp * sin(theta);
        
        
        
        this.y = this.y + upSp; 
        // gravity
        upSp += 1;
        
        if(this.y>ground){
           upSp = upSp*-0.9;
        }
    }
    
    void show() {
        // ring
        pushMatrix();
        translate(x,y,z);
        noStroke();
        lights();
        sphere(10);
        popMatrix();
    }
}
