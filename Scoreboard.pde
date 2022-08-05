class Scoreboard{
   
  String name;
  int time;
  int score;
  
  public Scoreboard(String name,int time){
   
   this.name = name;
   this.time = time;
   this.score = 0;
   
   
   }
   
  public void countdown(){
    time = time -1;
  }

  void show(){
  
    pushMatrix();
    translate(0,0,-1000);
    
    fill(0, 26, 255,100);
    rect(100,100,300,350);
    
    translate(0,0,10);
    fill(242, 255, 0);
    textSize(50);
    text(name,150,200);
    fill(242, 255, 0);
    textSize(50);
    text(time,150,300);
    fill(242, 255, 0);
    textSize(50);
    text(score,150,400);
    popMatrix();
    
    
  }



}
