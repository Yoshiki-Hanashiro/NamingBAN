int stage;
final int TITLE = 0;
final int GAME = 1;
final int ENDING = 2;

void setup(){
  size(1200, 600);
  background(255);
}


void draw(){
  if (stage == TITLE){
    title();
    }
  else if (stage == GAME){
    // PImage 型の変数 に画像データを読み込むあ
    PImage main = loadImage("main.jpg");
    PImage item = loadImage("item.png");
    // 画像を表示
    image(main, 0, 0);
    image(item, 900, 0);
    if(mousePressed){
      //座標を取得する．クリックされると変数mouseX，mouseYが自動的に座標を取得する．
         System.out.println("X = " + mouseX + " ,Y = " + mouseY+"がクリックされました.");
        if (mouseX >= 20 && mouseX <= 330){
          if(mouseY >= 320 && mouseY <= 540){ 
            PImage bed_up = loadImage("bed_up.jpg");
            image(bed_up, 0, 0);
           }
      }else if (mouseX >= 610 && mouseX <= 670){
        if(mouseY >= 210 && mouseY <= 370){
            PImage chest_up = loadImage("chest_up.jpg");
            image(chest_up, 0, 0);
        }
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
    }
}
