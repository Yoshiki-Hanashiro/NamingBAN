int stage;
final int TITLE = 0;
final int GAME = 1;
final int ENDING = 2;
int click_count = 0;
int[] scene; //[main, bed_up, chest_up, desk_up, door_up]
//自分の見ている場所を表す配列です．
//mainにいるならmain=1，bedを見ているならbedを表すscene[1]=1となります．

void setup(){
  scene = new int[5];
  scene[0] = 1; //最初の視点をmainに．
  size(1200, 600);
  background(255);
  noLoop();
}

void draw(){
  if (stage == TITLE){
    title();
    }
  else if (stage == GAME){
    // PImage 型の変数 に画像データを読み込む
    PImage main = loadImage("main.jpg");
    PImage item = loadImage("item.png");
    // 画像を表示
    image(main, 0, 0);
    image(item, 900, 0);
    if (mouseX >= 20 && mouseX <= 330){ 
      if(mouseY >= 320 && mouseY <= 540){
          //ベッド(左下)を拡大する
          PImage bed_up = loadImage("bed_up.jpg");
          image(bed_up, 0, 0);
          PImage return_button = loadImage("return_Main.png");
          image(return_button, 395, 490);
          scene[0] = 0; //mainではないので0に変える．
          scene[1] = 1; //bedを見るので1へ
         }
    }else if (mouseX >= 610 && mouseX <= 670){
        if(mouseY >= 210 && mouseY <= 370){
          //タンス(右上)を拡大する
            PImage chest_up = loadImage("chest_up.jpg");
            image(chest_up, 0, 0);
            PImage return_button = loadImage("return_Main.png");
            image(return_button, 395, 490);
            scene[0] = 0; //mainではないので0に変える．
            scene[2] = 1; //chestを見るので1へ
        }
      }else if (mouseX >= 750 && mouseX <= 900){
        if (mouseY >=220 && mouseY <= 530){
          //机(右下)を拡大する
            PImage desk_up = loadImage("desk_up.jpg");
            image(desk_up, 0, 0);
            PImage return_button = loadImage("return_Main.png");
            image(return_button, 395, 490);
            scene[0] = 0; //mainではないので0に変える．
            scene[3] = 1; //deskを見るので1へ
        }
      }else if(mouseX >= 345 && mouseX <= 440){
        if(mouseY >= 200 && mouseY <=350){
          //中央ドア(出口)ドア
           PImage door_up = loadImage("door_up.jpg");
           image(door_up, 0, 0);
           PImage return_button = loadImage("return_Main.png");
           image(return_button, 395, 490);
           scene[0] = 0; //mainではないので0に変える．
           scene[4] = 1; //doorを見るので1へ
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
      redraw();
    }
}
void mousePressed() {
  click_count++;
  println("クリックされた回数は"+click_count+"回です");
  println("X = " + mouseX + " ,Y = " + mouseY+"がクリックされました.");
  println(scene);
  //mainにいないときには戻るボタン以外ではdraw()を回さないように場合分け．
  if (scene[0] != 1){//mainにいないときに
    if(mouseX >=397 && mouseX <= 552){//戻るボタンが押されたら，main画像を表示する．
      if(mouseY >= 493 && mouseY <= 531){
        return_main();
      }
    }
  }else{
    redraw(); //main ==1 メインにいるときは他の場所に移動するためにdraw()を実行． 
}
}

void keyPressed(){ 
  println("キー「"+key+"」が押されました.");
    /*
    キー押すたびにdraw()を回してたらmain以外の視点の時にキーを押した時，
    配列がめちゃくちゃになってしまうので
    現状，title画面にいるときのみdraw()を回してmainの画像を表示するようにしています．
    パスワード入力とかでキー入力を受け付けるならここ変更しましょう．．．
    */
  if (scene[0] == 1){
  redraw();
  }
}
void return_main(){
   scene[0] = 1; //mainに戻るのでmainを1に．
   scene[1] = 0; //bedを0に．
   scene[2] = 0; //chestを0に．
   scene[3] = 0; //deskを0に．
   scene[4] = 0; //doorを0に．
   println("mainに戻ります");
   redraw();
}
