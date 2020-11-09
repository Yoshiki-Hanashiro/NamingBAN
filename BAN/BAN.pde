bedView bed;
chestView chest;
deskView desk;
doorView door;
<<<<<<< HEAD
Inventory inventory;
=======
>>>>>>> refs/remotes/origin/master

int stage;
final int TITLE = 0;
final int GAME = 1;
final int ENDING = 2;
int click_count = 0;
<<<<<<< HEAD
int key_count = 0;
int[] scene; //[main, bed_up, chest_up, desk_up, door_up]
//自分の見ている場所を表す配列です．
//mainにいるならmain=1，bedを見ているならbedを表すscene[1]=1となります．
String keyData; //キー入力を保存する変数
float gray = 255.0; //画像の暗さを保存しておく変数 0になると真っ暗になる．フェードアウトに使います

//_________________________________________以下，mystery
final String mystery5 = "escape";
=======
int[] scene; //[main, bed_up, chest_up, desk_up, door_up]
//自分の見ている場所を表す配列です．
//mainにいるならmain=1，bedを見ているならbedを表すscene[1]=1となります．
>>>>>>> refs/remotes/origin/master

void setup(){
  //それぞれのオブジェクトにクラスを割り当ててます
  //引数は左から順に(xの始点,xの終点,yの始点,yの終点)になっています
  bed = new bedView(20, 330, 220, 540);
  chest = new chestView(610, 670, 210, 370);
  desk = new deskView(750, 900, 220, 530);
  door = new doorView(345, 440, 200, 350);
<<<<<<< HEAD
  inventory = new Inventory(960,0,width - 960,height);
  scene = new int[5];
  keyData = new String();
=======
  scene = new int[5];
>>>>>>> refs/remotes/origin/master
  scene[0] = 1; //最初の視点をmainに．
  size(1200, 600);
  background(255);
  //noLoop();
<<<<<<< HEAD
  PFont font = createFont("Meiryo", 50); //日本語が表示されるように．
  textFont(font);
=======
>>>>>>> refs/remotes/origin/master
}

void draw(){
  if (stage == TITLE){ 
    title(); 
  }
  else if (stage == GAME){
    noLoop();
<<<<<<< HEAD
    fill(0);
    rect(0,543,2000,100); 
    //0,543は左下テキスト描画ウィンドウの左上の座標です．
    //そこからx=2000ピクセル，y=100ピクセルの真っ黒な長方形を出力することでテキスト描画ウィンドウをリセットしています．
              
    if(scene[0] == 1){//mainにいるならば
=======
>>>>>>> refs/remotes/origin/master
    // PImage 型の変数 に画像データを読み込む
    PImage main = loadImage("main.jpg");
    // 背景を表示
    image(main, 0, 0);
<<<<<<< HEAD
    //インベントリ表示
    inventory.display();
    

=======
    image(item, 900, 0);
>>>>>>> refs/remotes/origin/master
    //ベッド処理
    if(bed.check()){
      bed.display();
      bed.sceneChange();
<<<<<<< HEAD

      keyData ="";//今まで保存していた入力を初期化．
=======
>>>>>>> refs/remotes/origin/master
    }
    //タンス処理
    else if(chest.check()){
      chest.display();
      chest.sceneChange();
<<<<<<< HEAD

      keyData ="";//今まで保存していたキー入力を初期化．
=======
>>>>>>> refs/remotes/origin/master
    }
    //机処理
    else if(desk.check()){
      desk.display();
      desk.sceneChange();
<<<<<<< HEAD

      keyData ="";//今まで保存していたキー入力を初期化．
    }
    //ドア処理
    else if(door.check()){
      door.display();
      door.sceneChange();

      keyData ="";//今まで保存していたキー入力を初期化．
    }

  }else if (scene[4] == 1){//doorにいるならば
    if(mouseX >= 389 && mouseX <=531){
      if(mouseY >= 143 && mouseY <= 421){ //ドアの座標]          
        fill(255);
        textSize(20);
        textAlign(LEFT);
        text("パスワードは何だろう・・？ (キーボードで入力，Enterで決定) →",10,580);
        text(keyData,626,580); //key入力を表示
        if(key == ENTER || key == RETURN){
          println("入力されたパスワードは"+keyData);
          keyData = trim(keyData); //文字列の先頭と末尾の空白文字を削除する
          if(keyData.equals(mystery5)){
            println("gameclear!");
            fill(0);
            rect(0,543,2000,100); 
            stage = ENDING;   // エンディングへ
            mouseX = 0;
            mouseY = 0;
            loop(); //ループを再開して自動的にエンディング画面へ
          }else{
            println("パスワードが違います");
            keyData = "";
          }
        }
      }
    }
  }
 }else if (stage == ENDING){ 
  PImage door_up = loadImage("door_up.jpg");
  tint(gray); //tint(rgb,alpha) alphaが小さいほど透明 0-255
  image(door_up,0,0);
  gray = gray - 8;
  if(gray <= 0){
    ending(); 
  }
=======
    }
    //ドア処理
    else if(door.check()){
      door.display();
      door.sceneChange();
    }
>>>>>>> refs/remotes/origin/master
  }
 }

void title(){
<<<<<<< HEAD
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


void ending(){
  delay(1000);
  background(0); 
  fill(255);
  textSize(24);
  textAlign(CENTER);
  text("The end", width * 0.5, height * 0.3);
  text("Thank you for playing!", width * 0.5, height * 0.5);
}


void mousePressed() {
  if(stage == GAME){
=======
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
>>>>>>> refs/remotes/origin/master
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
<<<<<<< HEAD
    if (scene[4] == 1){//doorにいるとき
      if(mouseX >= 389 && mouseX <=531){
        if(mouseY >= 143 && mouseY <= 421){ //ドアの座標がクリックされたらdrawを回す
          redraw();
      }
    }
  }
  } else{
        redraw(); //main == 1 mainにいるときには移動するためにdrawを回す．
      }   if(scene[4] == 1){//doorにいるときドアをクリックしたら，パスワード入力を始める．

  }
}
}


void keyPressed(){ 
  key_count+=1;
  println("キー「"+key+"」が押されました.");
  if(key != ENTER){
    //コード化されたキーではないならばString keyDataに追加する
    keyData = keyData + key; //String keyData に入力されたkeyを保存する
    println(keyData);
  }else if (key == BACKSPACE || key == DELETE){
    keyData.substring(0,keyData.length()-1);//0番目から最後ー1番目の文字まで取得する．(Enter等を消す．)
    println("文字が消されました削除した結果，"+keyData);
  }
  redraw();
}


=======
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
>>>>>>> refs/remotes/origin/master
void return_main(){
   scene[0] = 1; //mainに戻るのでmainを1に．
   scene[1] = 0; //bedを0に．
   scene[2] = 0; //chestを0に．
   scene[3] = 0; //deskを0に．
   scene[4] = 0; //doorを0に．
   println("mainに戻ります");
   redraw();
}

<<<<<<< HEAD

=======
>>>>>>> refs/remotes/origin/master
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
<<<<<<< HEAD
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
=======
}

class chestView{
  int firstX=0, endX=0, firstY=0, endY=0;
  PImage return_button = loadImage("return_Main.png");
  PImage chest = loadImage("chest_up.jpg");
  chestView(int a, int b, int c, int d){
>>>>>>> refs/remotes/origin/master
    firstX = a;
    endX = b;
    firstY = c;
    endY = d;
<<<<<<< HEAD
}
  void display(){
    image(door, 0, 0);
=======
  }
  void display(){
    image(chest, 0, 0);
>>>>>>> refs/remotes/origin/master
    image(return_button, 395, 490);
  }
  void sceneChange(){
    scene[0] = 0;
<<<<<<< HEAD
    scene[4] = 1;
}
=======
    scene[2] = 1;
  }
>>>>>>> refs/remotes/origin/master
  boolean check(){
    boolean result = false;
    if (mouseX >= this.firstX && mouseX <= this.endX){ if(mouseY >= this.firstY && mouseY <= this.endY){ result = true; }}
    return result;
  }
}

<<<<<<< HEAD

class Inventory{      //インベントリ
    int firstX=0, endX=0, firstY=0, endY=0;
    Inventory(int a, int b, int c, int d){
=======
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
>>>>>>> refs/remotes/origin/master
    firstX = a;
    endX = b;
    firstY = c;
    endY = d;
<<<<<<< HEAD
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
=======
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
>>>>>>> refs/remotes/origin/master
}