BedView bed;
ChestView chest;
DeskView desk;
DoorView door;
Inventory inventory;
Textbox text_bed;
Textbox text_chest;
Textbox text_desk;
Textbox text_door;
SceneControl sc;
TextOut to;
Mysterys myst;

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
boolean have_item1 = false;
boolean have_item2 = false;
boolean have_item3 = false;
boolean have_item4 = false; //初めは何もアイテムを持っていない．
String strData; //テキストボックスに入力された文字を保存する変数．
float gray = 255.0; //画像の暗さを保存しておく変数 0になると真っ暗になる．フェードアウトに使います

boolean item1_Display = false; //item1を拡大表示しているならばtrueになる． item4の生成に使います．
boolean item2_Display = false; //item2を拡大表示しているならばtrueになる． item4の生成に使います．

void setup(){
  //それぞれのオブジェクトにクラスを割り当ててます
  //引数は左から順に(xの始点,xの終点,yの始点,yの終点)になっています
  bed = new BedView(20, 330, 220, 540);
  chest = new ChestView(610, 670, 210, 370);
  desk = new DeskView(750, 900, 220, 530);
  door = new DoorView(345, 440, 200, 350);
  inventory = new Inventory(960,0,width - 960,height);
  text_bed = new Textbox(310, 310, 150, 30); //bed_upでtextboxを表示するため
  text_chest = new Textbox(310, 310, 150, 30); //chest_upでtextboxを表示するため
  text_desk = new Textbox(310, 310, 150, 30); //desk_upでtextboxを表示するため
  text_door = new Textbox(310, 310, 150, 30); //door_upでtextboxを表示するため
  field = new JTextField();
  sc = new SceneControl();
  to = new TextOut();
  myst = new Mysterys();
  size(1200, 600);
  background(255);
  PFont font = createFont("HiraMaruProN-W4", 50);//プログラム内で使うフォントを日本語に． Meiryoが使えなくなったので変えました．
  textFont(font);
  Canvas canvas = (Canvas) surface.getNative();
  pane = (JLayeredPane) canvas.getParent().getParent();
}


void draw(){
  text_bed.remove_box();
  text_chest.remove_box();
  text_desk.remove_box();
  text_door.remove_box();
  if (stage == TITLE){ title(); }
  else if (stage == GAME){
    noLoop();
    to.textInit();
    //↑テキスト管理のクラスにまとめて関数作りました
    //0,543は左下テキスト表示箇所の左上の座標です．
    //そこからx=955ピクセル，y=100ピクセルの真っ黒な長方形を出力するの3でテキストを消します．

    if(sc.check("main")){//mainにいるならば
      // PImage 型の変数 に画像データを読み込む
      PImage main = loadImage("main.jpg");
      image(main, 0, 0);
      //インベントリ表示
      inventory.display();
      //item持ってたらアイテム欄に表示
      have_item();
      //item拡大表示メソッド
      up_show_item();
      //ベッドをクリックした時
      if(bed.check()){
        bed.display();
        bed.sceneChange();
      }
      //タンスをクリックした時
      else if(chest.check()){
        chest.display();
        chest.sceneChange();
      }
      //机をクリックした時
      else if(desk.check()){
        desk.display();
        desk.sceneChange();
      }
      //ドアをクリックした時
      else if(door.check()){
        door.display();
        door.sceneChange();
      }
    }else if (sc.check("bed")){ //ベッドにいる時
      if(mouseX <= 955){ //インベントリ以外をクリックしたら
        bed.display(); //アイテム拡大を隠す．
        bed.sceneChange();
        //上からインベントリ表示 
        inventory.display();
      }
      //item持ってたらアイテム欄に表示
      have_item();
      //item拡大表示メソッド
      up_show_item();
      if(bed.bedCheck()){ //ベッドをクリック
        //謎の画像を表示
        myst.mysteryDisplay(4);
        text_bed.remove_box();
        to.serifDisplay("ん・・・？紙がある．どういう意味だろう・・・？");
      }
      if(bed.trashCheck()){ //ゴミ箱をクリック
        if(myst.getMystery(1) != 1){
          myst.mysteryDisplay(1);
          to.serifDisplay("パスワードは何だろう・・？ (キーボードで入力，ゴミ箱をクリックで決定) →");
          text_bed.add_box(750,555,150,30); //テキストボックスの表示
          strData = field.getText();
          strData = trim(strData); //文字列の先頭と末尾の空白文字を削除する
          if(myst.answerCheck(strData,1)){
            //テキストの初期化
            to.textInit();
            to.serifDisplay("開いた…！　謎の文章を手に入れた．");
            have_item1 = true;
            have_item();
            myst.setMystery(1);
          }else{
            field.setText(""); //テキストボックスを初期化
          }
        }else{ //謎を解いた後
          to.textInit();
          to.serifDisplay("ここの謎はもう解けたみたいだ．");
        }
        if(mouseX >= 965 && mouseX <= 1195){
          if(mouseY > 6 && mouseY <= 146){
            up_show_item();
          }
        }
      }
    }else if (sc.check("chest")){//chestにいるとき
      if(mouseX <= 955){ //インベントリ以外をクリックしたら
        chest.display();
        chest.sceneChange();
        //上からインベントリ表示 
        inventory.display();
      }
      //item持ってたらアイテム欄に表示
      have_item();
      //item拡大表示メソッド
      up_show_item();
      if(chest.mirrorCheck()){
        text_chest.remove_box();
        to.serifDisplay("鏡だ．いつも通りのクールビューティなマイフェイスが映っている．");
      }
      if(chest.otherMirror()){ //チェストの鏡以外の座標
        if(myst.getMystery(2) != 1){ //まだ謎を解いていないならば
          myst.mysteryDisplay(2);
          to.serifDisplay("パスワードは何だろう・・？ (キーボードで入力，チェストをクリックで決定) →");
          text_chest.add_box(750,555,150,30); //テキストボックスの表示
          strData = field.getText();
          strData = trim(strData); //文字列の先頭と末尾の空白文字を削除する
          if(myst.answerCheck(strData,2)){
            to.textInit();
            to.serifDisplay("開いた…！　謎の地図を手に入れた．");
            have_item2 = true;
            have_item();
            myst.setMystery(2);
          }else{
            field.setText(""); //テキストボックスを初期化
          }
        }else{ //謎を解いた後
          to.textInit();
          to.serifDisplay("ここの謎はもう解けたみたいだ．");
        }
      }
    }else if (sc.check("desk")){ //deskにいるならば
      if(mouseX <= 955){ //インベントリ以外をクリックしたら
        desk.display();
        desk.sceneChange();
        //上からインベントリ表示 
        inventory.display();
      }
      //item持ってたらアイテム欄に表示
      have_item();
      //item拡大表示メソッド
      up_show_item();
      if(desk.strageCheck()){
        if(myst.getMystery(3) != 1){  //机の右下の収納をクリック
          myst.mysteryDisplay(3);
          to.serifDisplay("パスワードは何だろう・・？ (キーボードで入力，デスクをクリックで決定) →");
          text_desk.add_box(750,555,150,30); //テキストボックスの表示
          strData = field.getText();
          strData = trim(strData); //文字列の先頭と末尾の空白文字を削除する
          if(myst.answerCheck(strData,3)){
            //正解
            to.textInit();
            to.serifDisplay("開いた…！　謎のメモを手に入れた．");
            have_item3 = true;
            have_item();
            myst.setMystery(3);
          }else{
            field.setText(""); //テキストボックスを初期化
          }
        }else{ //謎を解いた後
          to.textInit();
          to.serifDisplay("ここの謎はもう解けたみたいだ．");
        }
      }
    }else if (sc.check("door")){//doorにいるならば
      if(mouseX <= 955){ //インベントリ以外をクリックしたら
        door.display();
        door.sceneChange();
        //上からインベントリ表示 
        inventory.display();
      }
      //item持ってたらアイテム欄に表示
      have_item();
      //item拡大表示メソッド
      up_show_item();
      if(door.doorCheck()){//ドアの座標
        to.serifDisplay("パスワードは何だろう・・？ (キーボードで入力，ドアをクリックで決定) →");
        text_door.add_box(750,555,150,30); //テキストボックスの表示
        strData = field.getText();
        strData = trim(strData); //文字列の先頭と末尾の空白文字を削除する
        if(myst.answerCheck(strData,5)){
          to.textInit();
          //インベントリ表示 下の方が消えるバグ修正
          inventory.display();
          text_door.remove_box();
          stage = ENDING; // エンディングへ
          loop(); //ループを再開して入力がなくても自動的にエンディング画面へ
        }else{
          field.setText(""); //テキストボックスを初期化
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
  to.titleDisplay();
  mouseX = 0; //タイトル画面でのクリックを無効化 (初期部屋を移動しないように)
  mouseY = 0;
}

void opening(){
  noLoop();
  to.openingDisplay();
}

void ending(){
  to.endingDisplay();
}


void mousePressed() {
  //mainにいないときには戻るボタン以外ではdraw()を回さない，オブジェクトクリック判定の可能にするために場合分け．
  if(!(sc.check("main"))){//mainにいないときに
    if(mouseX >=397 && mouseX <= 552){//戻るボタンが押されたら，main画像を表示する．
      if(mouseY >= 493 && mouseY <= 531){
        sc.returnMain();
      }
    }
    redraw();
  }else{
    if(stage == GAME){ //タイトル，オープニング，エンディングではdrawを回さない．
      redraw(); //main == 1 mainにいるときには移動するためにdrawを回す．
    }
  }
}

void keyReleased() {
  if(stage == TITLE){
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

class Mysterys{
  final String mystery1 = "1342";
  final String mystery2 = "1423";
  final String mystery3 = "cloud";
  final String mystery4 = ""; //入力は無し
  final String mystery5 = "えすけーぷ";
  int[] mystery = new int[5];

  int getMystery(int num){
    return this.mystery[num];
  }
  void setMystery(int num){
    this.mystery[num] = 1;
  }
  boolean answerCheck(String ans,int num){
    boolean result = false;
    if(num == 1){ if(ans.equals(this.mystery1)) result = true; }
    else if(num == 2){ if(ans.equals(this.mystery2)) result = true; }
    else if(num == 3){ if(ans.equals(this.mystery3)) result = true; }
    else if(num == 5){ if(ans.equals(this.mystery5)) result = true; }
    return result;
  }
  void mysteryDisplay(int num){
    switch(num){
      case 1:
        PImage Q1 = loadImage("Q1.png");
        image(Q1, 150, 10);
        break;
      case 2:
        PImage Q2 = loadImage("Q2.png");
        image(Q2, 30, 10);
        break;
      case 3:
        PImage Q3 = loadImage("Q3.png");
        image(Q3, 0, 10);
        break;
      case 4:
        PImage Q4 = loadImage("Q4.png");
        image(Q4, 30, 30);
        break;
    }
  }
}

class TextOut{
  void titleDisplay(){
    background(0); 
    fill(255);
    textSize(24);
    textAlign(CENTER);
    text("Ban-escape", width * 0.5, height * 0.3);
    text("Press any key to start", width * 0.5, height * 0.7);
  }
  void openingDisplay(){
    fill(0);
    stroke(0);
    rect(0,0,1200,600);
    fill(255);
    textSize(20);
    textAlign(CENTER);
    text("遅刻遅刻！！\n　\n今日はテスト当日．\n大事なテストなのに寝坊してしまった！\n急いで準備を済ませ，学校に向かおうとしたけど，何故かドアが開かない！！\nしかも部屋の中には見知らぬものが・・？\n \n部屋の中を探索し，ドアを開けてクリアを目指そう！", width * 0.5, height * 0.2);
    text("Press any key to continue →", 600, 500);
    textAlign(LEFT);
    text("クリック:移動，選択，決定\nキーボード:テキストボックスをクリック時 パスワード入力", 300, 400);
  }
  void endingDisplay(){
    delay(1000);
    background(0); 
    fill(255);
    textSize(24);
    textAlign(CENTER);
    text("The end", width * 0.5, height * 0.3);
    text("Thank you for playing!", width * 0.5, height * 0.5);
  }
  void textInit(){
    fill(0);
    stroke(0);  
    rect(0,543,955,100);
  }
  void serifDisplay(String serif){
    fill(255);
    textSize(20);
    textAlign(LEFT);
    text(serif,10,580);
  }
}

class SceneControl{
  int[] scene = new int[5];
  SceneControl(){
    this.returnMain();
  }
  void returnMain(){
    scene[0] = 1;
    for(int i = 1 ; i < 5; i++){ scene[i] = 0; }
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

class BedView{
  int firstX=0, endX=0, firstY=0, endY=0;
  PImage return_button = loadImage("return_Main.png");
  PImage bed = loadImage("bed_up.jpg");
  BedView(int a, int b, int c, int d){
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
  boolean bedCheck(){
    boolean result = false;
    if( mouseX >= 363 && mouseX <= 727){
      if(mouseY >= 211 && mouseY <= 422){ result = true; }
    } return result;
  }
  boolean trashCheck(){
    boolean result = false;
    if(mouseX >= 565 && mouseX <= 638){
      if(mouseY >= 446 && mouseY <= 536){ result = true; }
    } return result;
  }
  boolean check(){
    boolean result = false;
    if (mouseX >= this.firstX && mouseX <= this.endX){
      if(mouseY >= this.firstY && mouseY <= this.endY){ result = true; }
    } return result;
  }
}


class ChestView{
  int firstX=0, endX=0, firstY=0, endY=0;
  PImage return_button = loadImage("return_Main.png");
  PImage chest = loadImage("chest_up.jpg");
  ChestView(int a, int b, int c, int d){
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
  boolean mirrorCheck(){
    boolean result = false;
    if(mouseX >= 382 && mouseX <= 563){
      if (mouseY >= 124 && mouseY <= 286){ result = true; }
    } return result;  
  }
  boolean otherMirror(){
    boolean result = false;
    if(mouseX >= 301 && mouseX <= 646){
        if(mouseY >= 294 && mouseY <= 481){ result = true; }
    } return result;
  }
  boolean check(){
    boolean result = false;
    if (mouseX >= this.firstX && mouseX <= this.endX){ if(mouseY >= this.firstY && mouseY <= this.endY){ result = true; }
    } return result;
  }
}


class DeskView{
  int firstX=0, endX=0, firstY=0, endY=0;
  PImage return_button = loadImage("return_Main.png");
  PImage desk = loadImage("desk_up.jpg");
  DeskView(int a, int b, int c, int d){
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
  boolean strageCheck(){
    boolean result = false;
    if(mouseX >= 499 && mouseX <= 676){
      if(mouseY >= 197 && mouseY <=472){ result = true; }
    } return result;
  }
  boolean check(){
    boolean result = false;
    if (mouseX >= this.firstX && mouseX <= this.endX){ if(mouseY >= this.firstY && mouseY <= this.endY){ result = true; }
    } return result;
  }
}


class DoorView{
  int firstX=0, endX=0, firstY=0, endY=0;
  PImage return_button = loadImage("return_Main.png");
  PImage door = loadImage("door_up.jpg");
  DoorView(int a, int b, int c, int d){
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
  boolean doorCheck(){
    boolean result = false;
    if(mouseX >= 389 && mouseX <=531){
      if(mouseY >= 143 && mouseY <= 421){ result = true; }
    } return result;
  }
  boolean check(){
    boolean result = false;
    if (mouseX >= this.firstX && mouseX <= this.endX){ if(mouseY >= this.firstY && mouseY <= this.endY){ result = true; }
    } return result;
  }
}


class Textbox{  //textboxクラス
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
    pane.remove(field);
  }
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
        item1_Display = true; //item1を拡大中．
        if(have_item3 && item2_Display){ // item3まで取得し，item2を拡大している時にitem1を拡大する事がitem4の入手条件
            to.serifDisplay("アイテム1とアイテム2..うまく重なりそうだ..! (表4を手に入れた!)");
            have_item4 = true;
          }
        }
      }
    }
  if(have_item2){
    if(mouseX >= 965 && mouseX <= 1195){
      if(mouseY > 158&& mouseY <= 298){
        inventory.show_item2("mys_2.png");
        item2_Display = true; //item2を拡大しています．
        if(have_item3 && item1_Display){ // item1を拡大している時にitem2を拡大する事もitem4の入手条件
            to.serifDisplay("アイテム1とアイテム2..うまく重なりそうだ..! (表4を手に入れた!)");
            have_item4 = true;
          }
        }
      }
    }
  if(have_item3){
    if(mouseX >= 965 && mouseX <= 1195){
      if(mouseY > 307&& mouseY <= 447){
        inventory.show_item3("mys_3.png");
        item1_Display = false; //item1も2も拡大していない．
        item2_Display = false;
      }
    }
  }
  if(have_item4){
    if(mouseX >= 965 && mouseX <= 1195){
      if(mouseY > 457&& mouseY <= 597){
        inventory.show_item4("mys_4.png");
        item1_Display = false; //item1も2も拡大していない．
        item2_Display = false;
      }
    }
  }
}


class Inventory{  //インベントリ
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
    fill(46,45,45,200);
    rect(0,0,960,540);
    PImage item_1_big = loadImage(image_file_name);
    image(item_1_big, 500,10);
  }
  void show_item2(String image_file_name){
    fill(46,45,45,200);
    rect(0,0,960,540);
    PImage item_2_big = loadImage(image_file_name);
    item_2_big.resize(850,500);
    image(item_2_big, 50,20);
  }
  void show_item3(String image_file_name){
    fill(46,45,45,200);
    rect(0,0,960,540);
    PImage item_3_big = loadImage(image_file_name);
    item_3_big.resize(850,500);
    image(item_3_big, 50,20);
  }
  void show_item4(String image_file_name){
    fill(46,45,45,200);
    rect(0,0,960,537);
    PImage item_4_big = loadImage(image_file_name);
    image(item_4_big, 400,10);
  }    
}