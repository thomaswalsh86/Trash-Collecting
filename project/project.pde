// Declare integer variables
/*
-Trash sorting game-
*/
int randImg = 0, score = 0;
int x = 300, y = 50;
// Array to store images
PImage[] img = new PImage[14];
PImage currentImg;
PImage re, comp, gw;
// Variables for timing and game control
int start;
int elapsed = 0;
boolean timerStarted = false;
String timeFinal = "";
boolean gameOver = false;
int displayDuration = 5000;
String ftime = "";
int totalSeconds = 0; 
int minutes = 0; 
int seconds = 0;
int milliseconds = 0; 
int SCORE_LIMIT = 10;

void setup() {
  size(600, 600);
 // fullScreen();  
  //comp
  img[0] = loadImage("comp-apple.png");
  img[1] = loadImage("comp-banana.PNG");
  img[2] = loadImage("comp-egg.PNG");
  img[3] = loadImage("comp-tea.PNG");
  //re
  img[4] = loadImage("re-paper.PNG");
  img[5] = loadImage("re-cardboard.PNG");
  img[6] = loadImage("re-bottle.PNG");
  img[7] = loadImage("re-bag.PNG");
  //gw
  img[8] = loadImage("re-cans.PNG");//gw
  img[9] = loadImage("gw-papertowel.PNG");
  img[10] = loadImage("gw-foam.PNG");
  img[11] = loadImage("gw-bottle.PNG");
  img[12] = loadImage("gw-battery.PNG");
  
  randImg = int(random(13));
  currentImg = img[randImg];
  
  comp = loadImage("brown-bin.png");
  re = loadImage("green-bin.png");
  gw = loadImage("black-bin.png");
}
//https://www.digitalocean.com/
//https://www.geeksforgeeks.org/
//https://sojamo.de/
//https://processing.org/
void draw() {
  background(135,206,235);
    // Display the current image to sort
  currentImg.resize(100, 100);
  image(currentImg, x - currentImg.width / 2, y - currentImg.height / 2);
    // Display timer and score if the game has started
  if (timerStarted) {
    elapsed = millis() - start;
    int totalSeconds = elapsed / 1000;

    int minutes = totalSeconds / 60; 
    int seconds = totalSeconds % 60;
    int milliseconds = elapsed % 1000;
    String formattedTime = nf(minutes, 2) + ":" + nf(seconds, 2) + "." + nf(milliseconds, 3);

    textSize(32);
    if(gameOver==false){
    text(formattedTime, width - 150, 50);
    text(score, width/2-230, 50);
    }
  }
// image(image-loaded, (pos-x, pos-y),(size-x,size-y))
  image(re, width / 2 -230 , height-225, 120, 200);
  image(gw, width / 2 -60, height-225, 120, 200);
  image(comp, width /2+110 , height-225, 120, 200);
// Checks for mouse interactions and update score
// Checks if there is a overlap with the items and bins
//adds or decreaces to the score accordingly

   if (!mousePressed) {//re
   if ((x > width / 2 - 230 && x < width / 2 - 230 + 120) && (y > height - 225 && y < height - 225 + 200)) { 
      if ( randImg >=4 && randImg <8) {
        score++;
        resetImage();
      } else {
        resetMinus();
      }
    }
   if ((x > width / 2 - 60 && x < width / 2 - 60 + 120) && (y > height - 225 && y < height - 225 + 200)) {//gw
      if (randImg >= 8 && randImg <= 13) {//gw
        score++;
        resetImage();
      } else {
        resetMinus();
      }
    }
    if ((x > width / 2 + 110 && x < width / 2 + 110 + 120) && (y > height - 225 && y < height - 225 + 200)) {
      if (randImg < 4) {//comp
        score++;
        resetImage();
      } else {
        resetMinus();
      }
    }
  }

if (gameOver) {
    textSize(50);
    text("Game over", width/2 - 150, height / 2 - 100); 
    text("Final time: " + timeFinal, width/2 - 200, height / 2 - 50);
    String formattedTime="";
    text("average time: 0.50.000", width/2 - 200, height / 2 + 50); 
    
  }
}

// Track mouse movement
void mouseDragged() {
  x = mouseX;
  y = mouseY;
}

// Start timer on mouse click
void mousePressed() {
  if (!timerStarted) {
    start = millis();
    timerStarted = true;
  }
}
// Reset image and score when correct item sorted
void resetImage() {
  x = 300;
  y = 50;
 int newrandImg = randImg;
 
  while (newrandImg == randImg) {
    newrandImg = int(random(13));
  }
  
  randImg = newrandImg;
  currentImg = img[randImg];

  elapsed = millis() - start;
  int totalSeconds = elapsed / 1000;
  int minutes = totalSeconds / 60; 
  int seconds = totalSeconds % 60;
  int milliseconds = elapsed % 1000;
// Capture time when score reaches 10
  if (score == SCORE_LIMIT) {
    gameOver = true;
    timeFinal = nf(minutes, 2) + ":" + nf(seconds, 2) + "." + nf(milliseconds, 3);
    start = millis();
    score = 0;
  }
}
// Reset image and score when incorrect item sorted

void resetMinus() {
  // Capture time when score reaches 10
  if (score == SCORE_LIMIT) {
    gameOver = true;
    timeFinal = nf(minutes, 2) + ":" + nf(seconds, 2) + "." + nf(milliseconds, 3);
    ftime = timeFinal; // Store the final time when score reaches 10
    start = millis();
    score = 0;
  } else {
    x = 300;
    y = 50;
    int newrandImg = randImg;
 
  while (newrandImg == randImg) {
    newrandImg = int(random(13));
  }
  
  randImg = newrandImg;
  currentImg = img[randImg];
    score--;

    elapsed = millis() - start;
    totalSeconds = elapsed / 1000; // Update variable name to be accessible elsewhere
    minutes = totalSeconds / 60; 
    seconds = totalSeconds % 60;
    milliseconds = elapsed % 1000;
  }
}
