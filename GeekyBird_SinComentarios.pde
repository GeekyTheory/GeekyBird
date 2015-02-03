PImage backImg =loadImage("http://i.imgur.com/my83Fkg.png");
PImage birdImg =loadImage("http://i.imgur.com/xU1oPCO.png");
PImage wallImg =loadImage("http://i.imgur.com/LUQCYsB.png");
PImage startImg=loadImage("http://i.imgur.com/q3LPtxf.png");
int gamestate = 1; 
int score = 0, highScore = 0;
int x = -200, y, vy = 0;
int wx[] = new int[2], wy[] = new int[2]; 
void setup() { 
  size(600,700);
  fill(0); 
  textSize(40);
}
void draw() {
  if(gamestate == 0) { 
    imageMode(CORNER);
    image(backImg, x, 0);
    image(backImg, x+backImg.width, 0);
    x -= 6;
    vy += 1;
    y += vy;
    if(x == -1800) x = 0;
    for(int i = 0 ; i < 2; i++) {
      imageMode(CENTER);
      image(wallImg, wx[i], wy[i] - (wallImg.height/2+100));
      image(wallImg, wx[i], wy[i] + (wallImg.height/2+100));
      if(wx[i] < 0) {
        wy[i] = (int)random(200,height-200);
        wx[i] = width;
      }
      if(wx[i] == width/2){
        score++;
        highScore = max(score, highScore);
      }
      if(y>height||y<0||(abs(width/2-wx[i])<25 && abs(y-wy[i])>100)){
        gamestate=1;
      }
      wx[i] -= 6;
    }
    image(birdImg, width/2, y);
    text(""+score, width/2-15, 100);
  }
  else {
    imageMode(CENTER);
    image(startImg, width/2,height/2);
    text("Máxima puntuación: "+highScore, 50, width-50);
  }
}
void mousePressed() {
  vy = -17;
  if(gamestate==1) {
    wx[0] = 600;
    wy[0] = y = height/2;
    wx[1] = 900;
    wy[1] = 500;
    x = gamestate = score = 0;
  }
}
