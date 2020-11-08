bedView bed;
deskView desk;

int stage;
final int TITLE = 0;
final int GAME = 1;
final int ENDING = 2;
int click_count = 0;

void setup(){
  bed = new bedView(20, 330, 220, 540);
  size(1200, 600);
  background(255);
}
void draw(){
  if (stage == TITLE){
    title();
    }
  else if (stage == GAME){
    noLoop();
    // PImage 型の変数 に画像データを読み込む
    PImage main = loadImage("main.jpg");
    PImage item = loadImage("item.png");
    // 画像を表示
    image(main, 0, 0);
    image(item, 900, 0);
    if(bed.check()){
      bed.display();
    }
    else if (mouseX >= 610 && mouseX <= 670){
      if(mouseY >= 210 && mouseY <= 370){
        //タンス(右上)を拡大する
        PImage chest_up = loadImage("chest_up.jpg");
         image(chest_up, 0, 0);
       }
     }
     else if (mouseX >= 750 && mouseX <= 900){
       if (mouseY >=220 && mouseY <= 530){
         //机(右下)を拡大する
         PImage desk_up = loadImage("desk_up.jpg");
          image(desk_up, 0, 0);
        }
      }
      else if(mouseX >= 345 && mouseX <= 440){
        if(mouseY >= 200 && mouseY <=350){
          //中央ドア(出口)ドア
          PImage door_up = loadImage("door_up.jpg");
          image(door_up, 0, 0);
        }
      }
    }
  }

void title(){
   background(0); 
    fill(255);
    textSize(24);
    textAlign(CENTER);
    text("Ban-escape", width * 0.5, height * 0.3);
    text("Press any key to start", width * 0.5, height * 0.7);
    if (keyPressed) { // 何かのキーが押されていれば
      stage = GAME;   // ゲーム画面に遷移
      //redraw();
    }
}

void mousePressed() {
  click_count++;
  System.out.println(click_count);
  System.out.println("X = " + mouseX + " ,Y = " + mouseY+"がクリックされました.");
  redraw();      // ボタンが押されたときだけdrawを実行
}

void keyPressed(){
  System.out.println("キー「"+key+"」が押されました.");
  redraw();
}

class bedView{
  int firstX, endX, firstY, endY;
  PImage bed = loadImage("bed_up.jpg");
  
  bedView(int a, int b, int c, int d){
    firstX = a;
    endX = b;
    firstY = c;
    endY = d;
  }
  void display(){
    image(bed, 0, 0);
  }
  boolean check(){
    boolean result = false;
    if (mouseX >= this.firstX && mouseX <= this.endX){ 
      if(mouseY >= this.firstY && mouseY <= this.endY){
        result = true;
      }
    }
   return result;
  }
}

class deskView{
  int count = o
}