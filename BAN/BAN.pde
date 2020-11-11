bedView bed;
chestView chest;
deskView desk;
doorView door;
Inventory inventory;
Textbox text_bed;

import javax.swing.*;
import java.awt.*;

JLayeredPane pane;
JTextField field;
JTextArea area;

int stage;
final int TITLE = 0;
final int GAME = 1;
final int ENDING = 2;
int click_count = 0;
int key_count = 0;
boolean have_item1 = false;
boolean have_item2 = false;
boolean have_item3 = false;
boolean have_item4 = false;
int[] scene; //[main, bed_up, chest_up, desk_up, door_up]
//自分の見ている場所を表す配列です．
//mainにいるならmain=1，bedを見ているならbedを表すscene[1]=1となります．
String keyData; //キー入力を保存する変数
float gray = 255.0; //画像の暗さを保存しておく変数 0になると真っ暗になる．フェードアウトに使います

//_________________________________________以下，mystery
final String mystery5 = "escape";

void setup(){
  //それぞれのオブジェクトにクラスを割り当ててます
  //引数は左から順に(xの始点,xの終点,yの始点,yの終点)になっています
  bed = new bedView(20, 330, 220, 540);
  chest = new chestView(610, 670, 210, 370);
  desk = new deskView(750, 900, 220, 530);
  door = new doorView(345, 440, 200, 350);
  inventory = new Inventory(960,0,width - 960,height);
  text_bed = new Textbox(310, 310, 150, 30);
  field = new JTextField();
  scene = new int[5];
  keyData = new String();
  scene[0] = 1; //最初の視点をmainに．
  size(1200, 600);
  background(255);
  //noLoop();
  PFont font = createFont("Meiryo", 50); //日本語が表示されるように．
  textFont(font);
  Canvas canvas = (Canvas) surface.getNative();
  pane = (JLayeredPane) canvas.getParent().getParent();
}

void draw(){
  if (stage == TITLE){ 
    title(); 
  }
  else if (stage == GAME){
    noLoop();
    fill(0);
    rect(0,543,2000,100); 
    //0,543は左下テキスト描画ウィンドウの左上の座標です．
    //そこからx=2000ピクセル，y=100ピクセルの真っ黒な長方形を出力することでテキスト描画ウィンドウをリセットしています．
    if(scene[0] == 1){//mainにいるならば
    // PImage 型の変数 に画像データを読み込む
    PImage main = loadImage("main.jpg");
    // 背景を表示
    image(main, 0, 0);
    //インベントリ表示
    inventory.display();
    //item持ってたらアイテム欄に表示
    have_item();
    //item拡大表示メソッド
    up_show_item();
    //ベッド処理
    if(bed.check()){
      bed.display();
      bed.sceneChange();
      have_item1 = true;
      keyData="";
    }
    //タンス処理
    else if(chest.check()){
      chest.display();
      chest.sceneChange();
      have_item2 = true;
      keyData ="";//今まで保存していたキー入力を初期化．
    }
    //机処理
    else if(desk.check()){
      desk.display();
      desk.sceneChange();
      have_item3 = true;
      have_item4 = true;  //テストのためフラグをここに置いてるだけ
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
      if(mouseY >= 143 && mouseY <= 421){ //ドアの座標          
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

void ending(){
  delay(1000);
  background(0); 
  fill(255);
  textSize(24);
  textAlign(CENTER);
  text("The end", width * 0.5, height * 0.3);
  text("Thank you for playing!", width * 0.5, height * 0.5);
}


void mousePressed(){
  if(stage == GAME){
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


void return_main(){
   scene[0] = 1; //mainに戻るのでmainを1に．
   scene[1] = 0; //bedを0に．
   scene[2] = 0; //chestを0に．
   scene[3] = 0; //deskを0に．
   scene[4] = 0; //doorを0に．
   text_bed.remove_box();   //テキストboxをremove
   println("mainに戻ります");
   redraw();
}

//item持ったらインベントリに表示
void have_item(){
    if(have_item1){
      inventory.item1("mys_1.png");
    }
    if(have_item2){
      inventory.item2("mys_2.png");
    }
    if(have_item3){
      inventory.item3("mys_3.png");
    }
    if(have_item4){
      inventory.item4("mys_4.png");
    }
}
//  アイテム拡大表示メソッド
void up_show_item(){
  if(have_item1){
    if(mouseX >= 965 && mouseX <= 1195){
      if(mouseY > 6 && mouseY <= 146){
        inventory.show_item1("mys_1.png");
      }
    }
  }
  if(have_item2){
    if(mouseX >= 965 && mouseX <= 1195){
      if(mouseY > 158&& mouseY <= 298){
        inventory.show_item2("mys_2.png");
      }
    }
  }
  if(have_item3){
    if(mouseX >= 965 && mouseX <= 1195){
      if(mouseY > 307&& mouseY <= 447){
        inventory.show_item3("mys_3.png");
      }
    }
  }
  if(have_item4){
    if(mouseX >= 965 && mouseX <= 1195){
      if(mouseY > 457&& mouseY <= 597){
        inventory.show_item4("mys_4.png");
      }
    }
  }
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
    int firstX=0, endX=0, inv_width=0, inv_height=0;
    Inventory(int a, int b, int c, int d){
      firstX = a;
      endX = b;
      inv_width = c;
      inv_height = d;
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
     //アイテム表示メソッド
     void item1(String image_file_name){
       PImage item_1 = loadImage(image_file_name);
       item_1.resize(150,90);
       image(item_1, 1000, height * 0.25 * 0.25);
     }
     void item2(String image_file_name){
       PImage item_2 = loadImage(image_file_name);
       item_2.resize(150,90);
       image(item_2, 1000, 180);
     }
     void item3(String image_file_name){
       PImage item_3 = loadImage(image_file_name);
       item_3.resize(150,90);
       image(item_3, 1000, 335);
     }
     void item4(String image_file_name){
       PImage item_4 = loadImage(image_file_name);
       item_4.resize(150,90);
       image(item_4, 1000, 480);
     }
     // itemを拡大表示するメソッド
     
     void show_item1(String image_file_name){
        println("item" + image_file_name + "が押されました");
        fill(46,45,45,200);
        rect(0,0,1200,600);
        PImage item_1_big = loadImage(image_file_name);
        item_1_big.resize(850,500);
        image(item_1_big, 50,20);
     }
     void show_item2(String image_file_name){
        println("item" + image_file_name + "が押されました");
        fill(46,45,45,200);
        rect(0,0,1200,600);
        PImage item_2_big = loadImage(image_file_name);
        item_2_big.resize(850,500);
        image(item_2_big, 50,20);
     }
     void show_item3(String image_file_name){
        println("item" + image_file_name + "が押されました");
        fill(46,45,45,200);
        rect(0,0,1200,600);
        PImage item_3_big = loadImage(image_file_name);
        item_3_big.resize(850,500);
        image(item_3_big, 50,20);
     }
     void show_item4(String image_file_name){
        println("item" + image_file_name + "が押されました");
        fill(46,45,45,200);
        rect(0,0,1200,600);
        PImage item_4_big = loadImage(image_file_name);
        item_4_big.resize(850,500);
        image(item_4_big, 50,20);
     }
     
}

class Textbox{    //textboxクラス
  int firstX=0, endX=0, text_width=0, text_height=0;
  Textbox(int a, int b, int c, int d){
  firstX = a;
  endX = b;
  text_width = c;
  text_height = d;
  }
  void add_box(int x, int y, int box_width, int box_height){
      field.setBounds(x,y,box_width,box_height);
      pane.add(field);
  }
  void remove_box(){
    println(field.getText());
    pane.remove(field);
  }
}