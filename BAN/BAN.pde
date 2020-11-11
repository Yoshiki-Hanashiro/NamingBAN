bedView bed;
chestView chest;
deskView desk;
doorView door;
Inventory inventory;
textbox text_bed;
textbox text_chest;
textbox text_desk;
textbox text_door;
sceneControl sc;

import javax.swing.*;
import java.awt.*;

JLayeredPane pane;
JTextField field;
JTextArea area;

int stage;
final int TITLE = 0;
final int GAME = 1;
final int ENDING = 2;
int opening_count = 0;
int click_count = 0;
int key_count = 0;
int[] scene; //[main, bed_up, chest_up, desk_up, door_up]
//自分の見ている場所を表す配列です．
//mainにいるならmain=1，bedを見ているならbedを表すscene[1]=1となります．
int[] mystery; //謎のクリア状況を保存するリスト 謎は三つだがmystery1などと対応させるため，[1,2,3]しか使用していません
String keyData; //キー入力を保存する変数
String strData; //テキストボックスに入力された文字を保存する変数．
float gray = 255.0; //画像の暗さを保存しておく変数 0になると真っ暗になる．フェードアウトに使います

//_________________________________________以下，mystery
final String mystery1 = "1342";
final String mystery2 = "1423";
final String mystery3 = "cloud";
final String mystery4 = ""; //入力は無し
final String mystery5 = "えすけーぷ";

void setup(){
  //それぞれのオブジェクトにクラスを割り当ててます
  //引数は左から順に(xの始点,xの終点,yの始点,yの終点)になっています
  bed = new bedView(20, 330, 220, 540);
  chest = new chestView(610, 670, 210, 370);
  desk = new deskView(750, 900, 220, 530);
  door = new doorView(345, 440, 200, 350);
  inventory = new Inventory(960,0,width - 960,height);
  text_bed = new textbox(310, 310, 150, 30); //bed_upでtextboxを表示するため
  text_chest = new textbox(310, 310, 150, 30); //chest_upでtextboxを表示するため
  text_desk = new textbox(310, 310, 150, 30); //desk_upでtextboxを表示するため
  text_door = new textbox(310, 310, 150, 30); //door_upでtextboxを表示するため
  field = new JTextField();
  scene = new int[5];
  mystery = new int[5];
  keyData = new String();
  sc = new sceneControl();
  size(1200, 600);
  background(255);
  PFont font = createFont("HiraMaruProN-W4", 50);//プログラム内で使うフォントを日本語に． Meiryoが使えなくなったので変えました．
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
    stroke(0);  
    rect(0,543,900,100); 
    //0,543は左下テキスト表示箇所の左上の座標です．
    //そこからx=900ピクセル，y=100ピクセルの真っ黒な長方形を出力するこの3行でテキストを消します．
              
    if(sc.check("main")){//mainにいるならば
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
        keyData="";
      }
    //タンス処理
    else if(chest.check()){
      chest.display();
      chest.sceneChange();
      keyData ="";//今まで保存していたキー入力を初期化．
    }
    //机処理
    else if(desk.check()){
      desk.display();
      desk.sceneChange();
      keyData ="";//今まで保存していたキー入力を初期化．
    }
    //ドア処理
    else if(door.check()){
      door.display();
      door.sceneChange();
      keyData ="";//今まで保存していたキー入力を初期化．
    }
  }else if (sc.check("bed")){ //ベッドにいる時，
    if( mouseX >= 363 && mouseX <= 727){ //ベッドをクリック
      if(mouseY >= 211 && mouseY <= 422){
        //画像を表示
        text_bed.remove_box();
        println("ベッドをクリックしました");
        fill(255);
        textSize(20);
        textAlign(LEFT);
        text("ん・・・？紙がある．どういう意味だろう・・・？",10,580);
      }
    }
    if(mouseX >= 565 && mouseX <= 638){ //ゴミ箱をクリック
      if(mouseY >= 446 && mouseY <= 536){
        if(mystery[1] != 1){
          fill(255);
          textSize(20);
          textAlign(LEFT);
          text("パスワードは何だろう・・？ (キーボードで入力，ゴミ箱をクリックで決定) →",10,580);
          text_bed.add_box(750,555,150,30); //テキストボックスの表示
          strData = field.getText();
          println("入力されたパスワードは"+strData);
          strData = trim(strData); //文字列の先頭と末尾の空白文字を削除する
          if(strData.equals(mystery1)){
            fill(0);
            stroke(0);
            rect(0,543,900,100);
            fill(255);
            textSize(20);
            textAlign(LEFT);
            text("開いた…！　謎の文章を手に入れた．",10,580);
            mystery[1] = 1;
          }else{
            println("パスワードが違います");
            keyData = "";
            field.setText(""); //テキストボックスを初期化
          }
        }else{ //謎を解いた後
          fill(0);
          stroke(0);
          rect(0,543,900,100);
          fill(255);
          textSize(20);
          textAlign(LEFT);
          text("ここの謎はもう解けたみたいだ．",10,580);
          }
        }
      }
    }else if (sc.check("chest")){//chestにいるとき
      if(mouseX >= 382 && mouseX <= 563){
        if (mouseY >= 124 && mouseY <= 286){
          println("チェストの鏡をクリックしました");
          text_chest.remove_box();
          fill(255);
          textSize(20);
          textAlign(LEFT);
          text("鏡だ．いつも通りのクールビューティなマイフェイスが映っている．",10,580);
        }
     }
      if(mouseX >= 301 && mouseX <= 646){
        if(mouseY >= 294 && mouseY <= 481){ //チェストの鏡以外の座標
          if(mystery[2] != 1){ //まだ謎を解いていないならば
            fill(255);
            textSize(20);
            textAlign(LEFT);
            text("パスワードは何だろう・・？ (キーボードで入力，チェストをクリックで決定) →",10,580);
            text_chest.add_box(750,555,150,30); //テキストボックスの表示
            //text(keyData,626,580); //key入力を画面に表示
            print(key);
            strData = field.getText();
            //key = UP; //直前のキーをENTERから何かに変えておく
            println("入力されたパスワードは"+strData);
            strData = trim(strData); //文字列の先頭と末尾の空白文字を削除する
            if(strData.equals(mystery2)){
              fill(0);
              stroke(0);
              rect(0,543,900,100);
              fill(255);
              textSize(20);
              textAlign(LEFT);
              text("開いた…！　謎の地図を手に入れた．",10,580);
              mystery[2] = 1;
            }else{
              println("パスワードが違います");
              keyData = "";
              field.setText(""); //テキストボックスを初期化
            }
          }else{ //謎を解いた後
            fill(0);
            stroke(0);
            rect(0,543,900,100);
            fill(255);
            textSize(20);
            textAlign(LEFT);
            text("ここの謎はもう解けたみたいだ．",10,580);
            }
          }
        }
      }else if (sc.check("desk")){ //deskにいるならば
        if(mouseX >= 499 && mouseX <= 676){
          if(mouseY >= 197 && mouseY <=472){
            if (mystery[3] != 1){
              fill(255);
              textSize(20);
              textAlign(LEFT);
              text("パスワードは何だろう・・？ (キーボードで入力，チェストをクリックで決定) →",10,580);
              text_desk.add_box(750,555,150,30); //テキストボックスの表示
              print(key);
              strData = field.getText();
              println("入力されたパスワードは"+strData);
              strData = trim(strData); //文字列の先頭と末尾の空白文字を削除する
              if(strData.equals(mystery3)){
                //正解
                fill(0);
                stroke(0);
                rect(0,543,900,100);
                fill(255);
                textSize(20);
                textAlign(LEFT);
                text("開いた…！　謎のメモを手に入れた．",10,580);
                mystery[3] = 1;
              }else{
                println("パスワードが違います");
                keyData = "";
                field.setText(""); //テキストボックスを初期化
             }
          }else{ //謎を解いた後
            fill(0);
            stroke(0);
            rect(0,543,900,100);
            fill(255);
            textSize(20);
            textAlign(LEFT);
            text("ここの謎はもう解けたみたいだ．",10,580);
          }
        }
      }
    }else if (sc.check("door")){//doorにいるならば
      if(mouseX >= 389 && mouseX <=531){
        if(mouseY >= 143 && mouseY <= 421){ //ドアの座標
          fill(255);
          textSize(20);
          textAlign(LEFT);
          text("パスワードは何だろう・・？ (キーボードで入力，ドアをクリックで決定) →",10,580);
          text_door.add_box(750,555,150,30); //テキストボックスの表示
          print(key);
          strData = field.getText();
          println("入力されたパスワードは"+strData);
          strData = trim(strData); //文字列の先頭と末尾の空白文字を削除する
          if(strData.equals(mystery5)){
            println("gameclear!");
            fill(0);
            stroke(0);
            rect(0,543,2000,100);
            //インベントリ表示 下の方が消えるバグ修正
            inventory.display();
            text_door.remove_box();
            stage = ENDING;   // エンディングへ
            loop(); //ループを再開して入力がなくても自動的にエンディング画面へ
          }else{
            println("パスワードが違います");
            keyData = "";
            field.setText(""); //テキストボックスを初期化
          }
        }
      }
    }
  }else if (stage == ENDING){
    PImage door_up = loadImage("door_up.jpg");
    tint(gray); //tint(gray) 暗さ　小さいほど暗く． 
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
  mouseX = 0; //タイトル画面でのクリックを無効化 (初期部屋を移動しないように)
  mouseY = 0;
}

void opening(){
  println("オープニングに移動しました");
  noLoop();
  fill(0);
  stroke(0);
  rect(0,0,1200,600);
  fill(255);
  textSize(20);
  textAlign(CENTER);
  text("遅刻遅刻！！\n　\n今日はテスト当日．\n大事なテストなのに寝坊してしまった！\n急いで準備を済ませ，学校に向かおうとしたけど，何故かドアが開かない！！\nしかも部屋の中には見知らぬものが・・？\n \n部屋の中を探索し，ドアを開けてクリアを目指そう！", width * 0.5, height * 0.2);
  text("Press any key to start", 600, 500);
  textAlign(LEFT);
  text("クリック:移動，選択，決定\nキーボード:テキストボックスをクリック時 パスワード入力", 300, 400);
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
  click_count++;
  println("クリックされた回数は"+click_count+"回です");
  println("X = " + mouseX + " ,Y = " + mouseY+"がクリックされました.");
  println(scene);
  //mainにいないときには戻るボタン以外ではdraw()を回さない，オブジェクトクリック判定の可能にするために場合分け．
  if  (!(sc.check("main"))){//mainにいないときに
    if(mouseX >=397 && mouseX <= 552){//戻るボタンが押されたら，main画像を表示する．
      if(mouseY >= 493 && mouseY <= 531){
         sc.returnMain();
      }
    }
    if(sc.check("bed")){ //ベッドにいるとき
      if(mouseX >= 363 && mouseX <= 727){ //ベッドをクリック
        if(mouseY >= 211 && mouseY <= 422){
          redraw();
        }
      }
      if(mouseX >= 565 && mouseX <= 638){ //ゴミ箱をクリック
        if(mouseY >= 446 && mouseY <= 536){
          redraw();
        }
      }
    }
    if(sc.check("chest")){//chestにいるとき
      if(mouseX >= 382 && mouseX <= 563){
        if (mouseY >= 124 && mouseY <= 286){//鏡の座標がクリックされたらdrawを回す．
          redraw();
        }
      }
      if(mouseX >= 301 && mouseX <= 646){
        if(mouseY >= 294 && mouseY <= 481){ //チェストの鏡以外部分，したの方
          redraw();
          }
        }
      }
    if (sc.check("desk")){ //deskにいるとき
      if(mouseX >= 499 && mouseX <= 676){ //右下の棚がクリックされたらdrawを回す．
        if(mouseY >= 197 && mouseY <=472){
          redraw();
        }
      }
    }
    if (sc.check("door")){//doorにいるとき
      if(mouseX >= 389 && mouseX <=531){
        if(mouseY >= 143 && mouseY <= 421){ //ドアがクリックされたらdrawを回す
          redraw();
        }
      }
    }
  }else{
    if(stage == GAME){ //タイトル，オープニング，エンディングではdrawを回さない．
      redraw(); //main == 1 mainにいるときには移動するためにdrawを回す．
      }
    }
}


void keyPressed(){
  key_count+=1;
  println("キー「"+key+"」が押されました.");
  keyData = keyData + key; //String keyData に入力されたkeyを保存する
  println(keyData);
}

void keyReleased() {
  if (stage == TITLE){
    if(opening_count != 1){ //オープニングが一度も再生されていないならば
      opening();//オープニングを再生
      opening_count++; //再生は一度のみ
  }else{ //オープニングを再生したならば
    mouseX = 0; //オープニング中のクリックをリセット (初期部屋を移動しないように)
    mouseY = 0;
    stage = GAME; //ゲームを開始
    redraw();
    }
  }
}

class sceneControl{
  int[] scene = new int[5];
  sceneControl(){
    this.returnMain();
  }
  void returnMain(){
    scene[0] = 1;
    for(int i = 1 ; i < 5; i++){ scene[i] = 0; }
    println("mainに戻ります");
    redraw();
  }
  boolean check(String name){
    boolean result = false;
    if(name == "bed"){ if(scene[1] == 1){ result = true; } }
    else if(name == "chest"){ if(scene[2] == 1){ result = true; } }
    else if(name == "desk"){ if(scene[3] == 1){ result = true; } }
    else if(name == "door"){ if(scene[4] == 1){ result = true; } }
    else if(name == "main"){ if(scene[0] == 1){ result = true; } }
    return result;
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
    sc.scene[0] = 0;
    sc.scene[1] = 1;
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
    sc.scene[0] = 0;
    sc.scene[2] = 1;
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
    sc.scene[0] = 0;
    sc.scene[3] = 1;
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
    sc.scene[0] = 0;
    sc.scene[4] = 1;
}
  boolean check(){
    boolean result = false;
    if (mouseX >= this.firstX && mouseX <= this.endX){ if(mouseY >= this.firstY && mouseY <= this.endY){ result = true; }}
    return result;
  }
}


class Inventory{  //インベントリ
    int firstX=0, endX=0, firstY=0, endY=0;
    Inventory(int a, int b, int c, int d){
      firstX = a;
      endX = b;
      firstY = c;
      endY = d;
    }
     void display(){ //アイテム欄表示
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

class textbox{    //textboxクラス
  int firstX=0, endX=0, text_width=0, text_height=0;
  textbox(int a, int b, int c, int d){
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
