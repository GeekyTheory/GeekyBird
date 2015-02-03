PImage backImg =loadImage("http://i.imgur.com/my83Fkg.png");
PImage birdImg =loadImage("http://i.imgur.com/xU1oPCO.png");
PImage wallImg =loadImage("http://i.imgur.com/LUQCYsB.png");
PImage startImg=loadImage("http://i.imgur.com/q3LPtxf.png");
int gamestate = 1; //Estado del juego. 1 menu de inicio, 0 en juego
int score = 0, highScore = 0; // ¿Hace falta que os diga para qué es cada una?
int x = -200, y, vy = 0; // Posición 'y, 'x' y la velocidad horizontal 'vy'
// Paredes: wx contiene la distancia horizontal y wy la vertical
int wx[] = new int[2], wy[] = new int[2]; 
void setup() { // inicialización
  size(600,700); // Tamaño de la ventana: ancho x alto (px)
  fill(0); 
  textSize(40);  // ... Tamaño de la letra, claro
}
void draw() {  // Se ejecuta 60 por segundo
  if(gamestate == 0) { // Si estamos en juego, se hará todo lo siguiente
    // Establecemos el fondo del juego
    imageMode(CORNER);
    image(backImg, x, 0);
    image(backImg, x+backImg.width, 0); // Se suma la x para crear el desplazamiento del fondo (*)
    x -= 6;
    vy += 1;
    y += vy; // Esta será la aceleración de caída de nuestro personaje
    if(x == -1800) x = 0; // Se reinicia el fondo llegada a esta longitud
    for(int i = 0 ; i < 2; i++) { // Este bucle renderiza las paredes
      imageMode(CENTER);
      image(wallImg, wx[i], wy[i] - (wallImg.height/2+100));
      image(wallImg, wx[i], wy[i] + (wallImg.height/2+100));
      if(wx[i] < 0) { 
        // Si la pared "pasa de largo" por la izquierda, se recoloca a la derecha
        // ¡Con diferente posición, claro!
        wy[i] = (int)random(200,height-200);
        wx[i] = width;
      }
      if(wx[i] == width/2){ // Si el jugador pasa los muros
        score++; // Sumamos un punto
        highScore = max(score, highScore); // Se comprueba si se ha batido record
      }
      if(y>height||y<0||(abs(width/2-wx[i])<25 && abs(y-wy[i])>100)){ 
      // Para abreviar: Si tocas el techo, el suelo, o una pared, mueres.
        gamestate=1; // Te envía al menu de inicio
      }
      wx[i] -= 6; // Desplazamos las paredes al ritmo del mapa!
    }
    image(birdImg, width/2, y); // Hacemos aparecer a nuestro personajillo
    text(""+score, width/2-15, 100); // Mostramos la puntuación
  } // Hasta aquí
  else { // Si no estamos en juego, se hará esto otro
  // Centramos las imágenes y mostramos la portada con la máxima puntuación
    imageMode(CENTER);
    image(startImg, width/2,height/2);
    text("Máxima puntuación: "+highScore, 50, width-50);
  }
}
void mousePressed() { // Se llama cuando hacemos click
  vy = -17; // Hacemos "saltar" a nuestro pequeñín
  if(gamestate==1) { // Si el juego está en el menú
  // Inicializamos las paredes, y ponemos marcadores y modo de juego a 0
    wx[0] = 600;
    wy[0] = y = height/2;
    wx[1] = 900;
    wy[1] = 500;
    x = gamestate = score = 0;
  }
}
