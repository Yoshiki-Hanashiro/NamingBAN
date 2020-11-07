/*ごめんなさい，メソッドが重複してると言われてBANが実行できなかったので
こっちいったん全部コメントアウトしました．11/7 19:00 にち．
//クラス名(クラスのインポートに近い?)
bedView bed;

void setup(){
  size(1200, 600);
  background(255);
  
  //クラスのオブジェクト化&コンストラクタを呼び出して初期値設定
  bed = new bedView(20, 330, 320, 540);
}


void draw(){
    // PImage 型の変数 に画像データを読み込むあ
    PImage main = loadImage("main.jpg");
    PImage item = loadImage("item.png");
    // 画像を表示
    image(main, 0, 0);
    image(item, 900, 0);
    if(mousePressed){
      //座標を取得する．クリックされると変数mouseX，mouseYが自動的に座標を取得する．
         System.out.println("X = " + mouseX + " ,Y = " + mouseY+"がクリックされました.");
         
         //定数をクラスの持つ変数で指定
        if (mouseX >= bed.firstX && mouseX <= bed.endX){
          if(mouseY >= bed.firstY && mouseY <= bed.endY){ 
          //  PImage bed_up = loadImage("bed_up.jpg");
          //  image(bed_up, 0, 0);
          
          //ここはまだ動作してないので無視して
           while(bed.bedFlag == 0){
           bed.draw();
           }
      }
     }
    }
 }




class bedView{
  int firstX, endX, firstY, endY;
  int bedFlag = 0;
  PImage bed = loadImage("bed_up.jpg");

  bedView(int a, int b , int c, int d){
    firstX = a;
    endX = b;
    firstY = c;
    endY = d;
  }
  //無視して
  void draw(){
    image(bed, 0, 0);
  }
}
*/
