int enemy_x[]=new int[10],enemy_y[]=new int[10];
int enemy_speed[]=new int[10];
int enemy_hp[]=new int[10];
int score;
void setup(){
  size(500,500);
  for(int i=0;i<10;i++){
    enemy_x[i]=int(random(width));
    enemy_y[i]=-50;
    enemy_speed[i]=int(random(2,6));
    enemy_hp[i]=50;
  }
  score=0;
}

void draw(){
  background(255);
  fill(0);
  textSize(40);
  text("score: "+score,10,25);
  fill(255);
  ellipse(mouseX,mouseY,50,50);
  if(mousePressed){
      line(mouseX,mouseY,mouseX,0);
  } 
  for(int i=0;i<10;i++){
    ellipse(enemy_x[i],enemy_y[i],50,50);
    enemy_y[i]+=enemy_speed[i];
    if(enemy_y[i]-25>height){
      enemy_x[i]=int(random(width));
      enemy_y[i]=-50;
      enemy_speed[i]=int(random(2,6));
      enemy_hp[i]=100;
     }
    if(enemy_x[i]-25<mouseX && mouseX<enemy_x[i]+25){
      enemy_hp[i]--;
    }
    if(enemy_hp[i]<0){
      enemy_x[i]=int(random(width));
      enemy_y[i]=-50;
      enemy_speed[i]=int(random(2,6));
      enemy_hp[i]=100;
      score++;
    }
  }
}
