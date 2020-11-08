bedView bed;
chestView chest;
deskView desk;
doorView door;
Inventory inventory;

int stage;
final int TITLE = 0;
final int GAME = 1;
final int ENDING = 2;
int click_count = 0;
int[] scene; //[main, bed_up, chest_up, desk_up, door_up]
//自分の見ている場所を表す配列です．
//mainにいるならmain=1，bedを見ているならbedを表すscene[1]=1となります．

void setup(){
  //それぞれのオブジェクトにクラスを割り当ててます
  //引数は左から順に(xの始点,xの終点,yの始点,yの終点)になっています
  bed = new bedView(20, 330, 220, 540);
  chest = new chestView(610, 670, 210, 370);
  desk = new deskView(750, 900, 220, 530);
  door = new doorView(345, 440, 200, 350);
  inventory = new Inventory(960,0,width - 960,height);
  scene = new int[5];
  scene[0] = 1; //最初の視点をmainに．
  size(1200, 600);
  background(255);
  //noLoop();
}

void draw(){
  if (stage == TITLE){ 
    title(); 
  }
  else if (stage == GAME){
    noLoop();
    // PImage 型の変数 に画像データを読み込む
    PImage main = loadImage("main.jpg");
    // 背景を表示
    image(main, 0, 0);
    //インベントリ表示
    inventory.display();
    //ベッド処理
    if(bed.check()){
      bed.display();
      bed.sceneChange();
    }
    //タンス処理
    else if(chest.check()){
      chest.display();
      chest.sceneChange();
    }
    //机処理
    else if(desk.check()){
      desk.display();
      desk.sceneChange();
    }
    //ドア処理
    else if(door.check()){
      door.display();
      door.sceneChange();
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

class bedView{
  int firstX=0, endX=0, firstY=0, endY=0;
  PImage return_button = loadImage("return_Main.png");
  PImage bed = loadImage("bed_up.jpg");
  bedView(int a, int b, int c, int d){
    firstX = a;
    endX = b;
    firstY = c;
    endY = d;
  }
  void display(){
    image(bed, 0, 0);
    image(return_button, 395, 490);
  }
  void sceneChange(){
    scene[0] = 0;
    scene[1] = 1;
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

class chestView{
  int firstX=0, endX=0, firstY=0, endY=0;
  PImage return_button = loadImage("return_Main.png");
  PImage chest = loadImage("chest_up.jpg");
  chestView(int a, int b, int c, int d){
    firstX = a;
    endX = b;
    firstY = c;
    endY = d;
  }
  void display(){
    image(chest, 0, 0);
    image(return_button, 395, 490);
  }
  void sceneChange(){
    scene[0] = 0;
    scene[2] = 1;
  }
  boolean check(){
    boolean result = false;
    if (mouseX >= this.firstX && mouseX <= this.endX){ if(mouseY >= this.firstY && mouseY <= this.endY){ result = true; }}
    return result;
  }
}

class deskView{
  int firstX=0, endX=0, firstY=0, endY=0;
  PImage return_button = loadImage("return_Main.png");
  PImage desk = loadImage("desk_up.jpg");
  deskView(int a, int b, int c, int d){
    firstX = a;
    endX = b;
    firstY = c;
    endY = d;
  }
  void display(){
    image(desk, 0, 0);
    image(return_button, 395, 490);
  }
  void sceneChange(){
    scene[0] = 0;
    scene[3] = 1;
  }
  boolean check(){
    boolean result = false;
    if (mouseX >= this.firstX && mouseX <= this.endX){ if(mouseY >= this.firstY && mouseY <= this.endY){ result = true; }}
    return result;
  }
}

class doorView{
  int firstX=0, endX=0, firstY=0, endY=0;
  PImage return_button = loadImage("return_Main.png");
  PImage door = loadImage("door_up.jpg");
  doorView(int a, int b, int c, int d){
    firstX = a;
    endX = b;
    firstY = c;
    endY = d;
  }
  void display(){
    image(door, 0, 0);
    image(return_button, 395, 490);
  }
  void sceneChange(){
    scene[0] = 0;
    scene[4] = 1;
  }
  boolean check(){
    boolean result = false;
    if (mouseX >= this.firstX && mouseX <= this.endX){ if(mouseY >= this.firstY && mouseY <= this.endY){ result = true; }}
    return result;
  }
}

class Inventory{      //インベントリ
    int firstX=0, endX=0, firstY=0, endY=0;
    Inventory(int a, int b, int c, int d){
    firstX = a;
    endX = b;
    firstY = c;
    endY = d;
    }
     void display(){      //アイテム欄表示
      stroke(128);  
      strokeWeight(4);
      fill(0,0,0);
      rect(960,0,width - 960,height);
      strokeWeight(3);
      rect(960,0,width - 960,height * 0.25);
      rect(960,height * 0.25,width - 960,height * 0.25);
      rect(960,height * 0.5,width - 960,height * 0.25);
      rect(960,height * 0.75,width - 960,height * 0.25);
     }
     //アイテム表示メソッド:アイテム画像用意され次第取り掛かります
     void Item1(){    
     }
     void Item2(){
     }
     void Item3(){
     }
     void Item4(){
     }
}
