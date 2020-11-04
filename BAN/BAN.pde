//DVDのものまねをするプログラム
class Ball
{
  static final int R = 50;  
  Ball()
  {
     x = random(width);
     y = random(height);
     
     float v = 5;
     vx = random(v*2)-v;
     vy = random(v*2)-v;
     
     col = color(random(255),random(255),random(255));     
  }
  
  void move(float d)
  {
    x += vx*d;
    y += vy*d;

    if(x < 0 || width < x) {
       vx = -vx;
        col = color(random(255),random(255),random(255));     
    }
    
    if(y < 0 || height < y) {
      vy = -vy;
      col = color(random(255),random(255),random(255)); 
    }
  }
  
  void interact(Ball b)
  {
     float dx = b.x - x;
     float dy = b.y - y;
     
     if(sqrt(dx*dx+dy*dy) < R*2)
     {
        float tvx = b.vx;
        float tvy = b.vy;
        
        b.vx = vx;
        b.vy = vy;
        vx = tvx;
        vy = tvy;
        
        col = color(random(255),random(255),random(255));     
        b.col = color(random(255),random(255),random(255));     

     }
  }

  void draw()
  {
    fill(col);
    noStroke();
    ellipse(x,y, R*2, R*2);
  }
  
  float x,y;    // position 
  float vx, vy; // velocity
  color col;
  
}


ArrayList<Ball> balls;

void setup()
{
  size(640, 480);
  smooth();

  balls = new ArrayList<Ball>();
  final int num_obj = 1;
  
  for(int i=0; i<num_obj; ++i) {
    balls.add( new Ball() );
  }
  
}

void draw()
{
  background(0,0,0);

  for(Ball b : balls) {
      
      b.move(1);
      b.draw();
      
      for(Ball b2 : balls) {
          if(b != b2) {
             b.interact(b2);   
          }
      }
  }
}
