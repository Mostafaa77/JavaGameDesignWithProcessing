/* Game Class Starter File
 * Authors: Christian A & Mostafa Aboelfadl
 * Last Edit: 5/29/2024
 * Modified for AnimatedSprites
 */

//import processing.sound.*;

//------------------ GAME VARIABLES --------------------//

//VARIABLES: Title Bar
String titleText = "Final Destiny";
String extraText = "The Last Saga?";

//VARIABLES: Whole Game
AnimatedSprite runningHorse;
boolean doAnimation;

//VARIABLES: Splash Screen
Screen splashScreen;
PImage splashBg;
String splashBgFile = "images/apcsa.png";
//SoundFile song;

//VARIABLES: level1World Pixel-based Screen
World level1World;
//background for woods
PImage bg1a;
PImage bg1b;
PImage bg1c;
//flooring background
PImage f1a;
PImage f1b;
PImage f1c;
PImage f1d;
PImage f1e;
PImage f1f;
PImage f1g;
PImage f1h;
PImage f1i;
PImage f1j;
PImage f1k;
PImage f1l;
PImage f1m;
PImage f1n;
//Declearing Sprites
//kingith
AnimatedSprite knight; 
AnimatedSprite fightingKnightL;
AnimatedSprite fightingKnightR;
AnimatedSprite knightRun;
AnimatedSprite knightHurt;
AnimatedSprite knightHealth;
AnimatedSprite knightDeath;
//witch
AnimatedSprite witch;

//Use Sprite for a pixel-based Location
//String knightFile = "sprites/knight.png";
int knightstartX = 50;
int knightstartY = 430;
int witchstartX = 200;
int witchstartY = 300;

//VARIABLES: level2Grid Screen
Grid level2Grid;

PImage level2Bg;
String level2BgFile = "images/chess.jpg";
PImage knight2;   //Use PImage to display the image in a GridLocation
String knight2File = "images/x_wood.png";
int knight2Row = 3;
int knight2Col = 0;
int health = 3;
AnimatedSprite walkingChick;
Button b1 = new Button("rect", 650, 525, 100, 50, "GoToLevel2");

//VARIABLES: EndScreen
World endScreen;
PImage endBg;
String endBgFile = "images/youwin.png";


//VARIABLES: Tracking the current Screen being displayed
Screen currentScreen;
World currentWorld;
Grid currentGrid;
private int msElapsed = 0;


//------------------ REQUIRED PROCESSING METHODS --------------------//

//Required Processing method that gets run once
void setup() {

  //SETUP: Match the screen size to the background image size
  size(800,600);  //these will automatically be saved as width & height
  imageMode(CORNER);    //Set Images to read coordinates at corners
  //fullScreen();   //only use if not using a specfic bg image
  
  //SETUP: Set the title on the title bar
  surface.setTitle(titleText);

  //SETUP: Load BG images used in all screens
  splashBg = loadImage(splashBgFile);
  splashBg.resize(width, height);

  bg1a = loadImage("images/woods/background/woods_Background1.png");
  bg1a.resize(width, height);
  level2Bg = loadImage(level2BgFile);
  level2Bg.resize(width, height);
  endBg = loadImage(endBgFile);
  endBg.resize(width, height);  

  //SETUP: Screens, Worlds, Grids
  splashScreen = new Screen("splash", splashBg);
  level1World = new World("woods", bg1a);
  // level2Grid = new Grid("basement", level2Bg, 6, 8);
  //level2Grid.startPrintingGridMarks();
  endScreen = new World("end", endBg);
  currentScreen = splashScreen;

  //SETUP: All Game objects
  // runningHorse = new AnimatedSprite("sprites/horse_run.png", "sprites/horse_run.json", 50.0, 75.0, 10.0);

  //SETUP: Level 1
    bg1b = loadImage("images/woods/background/woods_Background2.png");
  bg1c= loadImage("images/woods/background/woods_Background3.png");
bg1b.resize(width, height);
bg1c.resize(width, height);
//flooring setup
f1a = loadImage("images/floor/flooring1.png");
f1a.resize(100*3,100*3);

f1b = loadImage("images/floor/flooring2.png");
f1b.resize(100*2,100);

f1c = loadImage("images/floor/flooring3.png");
f1c.resize(100*3,100*3);

f1d = loadImage("images/floor/flooring6.png");
f1d.resize(100*3,100*3);

f1e = loadImage("images/floor/flooring7.png");
f1e.resize(100*3,100);

//knight Sprite
  knightRun = new AnimatedSprite("sprites/knight.png","sprites/knightRun.json",knightstartX, knightstartY, 0.0 );
  knightRun.resize(31*2,45*2);
  knight = new AnimatedSprite("sprites/knight.png", "sprites/knight.json", knightstartX, knightstartY, 0.0);
  knight.resize(128*2,64*2);
//witch sprite
  witch = new AnimatedSprite("sprites/witch.png","sprites/witch.json",witchstartX, witchstartY, 0.0 );
  witch.resize(19*2,39*2);
  // witch = new AnimatedSprite("sprites/knight.png", "sprites/knight.json", witchstartX, witchstartY, 0.0);
  // witch.resize(128*2,64*2);

  //level1World.addSpriteCopyTo(runningHorse, 100, 200);  //example Sprite added to a World at a location, with a speed
  level1World.printWorldSprites();


   // knight.resize(level2Grid.getTileWidth(),level2Grid.getTileHeight());
  //walkingChick = new AnimatedSprite("sprites/chick_walk.png", "sprites/chick_walk.json", 0.0, 0.0, 5.0);
  //level2Grid.setTileSprite(new GridLocation (5,5), walkingChick);
  System.out.println("Done loading Level 1 ...");
  
  //SETUP: Level 2


  System.out.println("Done loading Level 2 ...");
  
  //SETUP: Sound
  // Load a soundfile from the /data folder of the sketch and play it back
  // song = new SoundFile(this, "sounds/Lenny_Kravitz_Fly_Away.mp3");
  // song.play();
  
  println("Game started...");

} //end setup()


//Required Processing method that automatically loops
//(Anything drawn on the screen should be called from here)
void draw() {

  updateTitleBar();
  updateScreen();

  //simple timing handling
  if (msElapsed % 300 == 0) {
    //sprite handling
    populateSprites();
    moveSprites();
  }
  msElapsed +=100;
  currentScreen.pause(10);

  //check for end of game
  if(isGameOver()){
    endGame();
  }

} //end draw()

//------------------ USER INPUT METHODS --------------------//


//Known Processing method that automatically will run whenever a key is pressed
void keyPressed(){

  //check what key was pressed
  System.out.println("\nKey pressed: " + keyCode); //key gives you a character for the key pressed

  //What to do when a key is pressed?
  
  //KEYS FOR LEVEL1
  if(currentScreen == level1World){

    //set [W] key to move the knight2 up & avoid Out-of-Bounds errors
    if(key == 'w'){
     
      knight.setSpeed(5.0);
      knight.move(0,-5);
    }
 else if(key == 'd'){

  knight.setSpeed(5.0);
  knight.move(5,0);  
}
else if(key=='a'){

knight.setSpeed(5.0);
knight.move(-5,0);
}
else if(key=='s'){
knight.setSpeed(5.0);
knight.move(0,5);



}


  }

  //CHANGING SCREENS BASED ON KEYS
  //change to level1 if 1 key pressed, level2 if 2 key is pressed
  if(key == '1'){
    currentScreen = level2Grid;
  } else if(key == '2'){
    currentScreen = level1World;
  }


}

//Known Processing method that automatically will run when a mouse click triggers it
void mouseClicked(){
  
  //check if click was successful
  System.out.println("\nMouse was clicked at (" + mouseX + "," + mouseY + ")");
  if(currentGrid != null){
    System.out.println("Grid location: " + currentGrid.getGridLocation());
  }

  //what to do if clicked? (Make knight2 jump back?)
  


  //Toggle the animation on & off
  // doAnimation = !doAnimation;
  // System.out.println("doAnimation: " + doAnimation);
  if(currentGrid != null){
    currentGrid.setMark("X",currentGrid.getGridLocation());
  }

}



//------------------ CUSTOM  GAME METHODS --------------------//

//method to update the Title Bar of the Game
public void updateTitleBar(){

  if(!isGameOver()) {
    //set the title each loop
    surface.setTitle(titleText + "    " + extraText + " " + health);

    //adjust the extra text as desired
  
  }
}

//method to update what is drawn on the screen each frame
public void updateScreen(){


  //UPDATE: Background of the current Screen
  if(currentScreen.getBg() != null){
    background(currentScreen.getBg());
  }

  //UPDATE: splashScreen
  if(currentScreen == splashScreen && splashScreen.getScreenTime() > 3000 && splashScreen.getScreenTime() < 5000){
    System.out.print("s");
    currentScreen = level1World;
  }


  //UPDATE: level1World Scren
  if(currentScreen == level1World){
    System.out.print("w");
    currentWorld = level1World;
    currentGrid = null;

    
   //background
      image(bg1b, 0,0);
    image(bg1c, 0,0);
    //flooring
  image(f1a, -10, 550);
image(f1e, 248, 525);
image(f1a, 400, 550);
    //level1World.moveBgXY(-3.0, 0);
    //level1World.show();
//sprites
    knight.animate();
    witch.animate();
   

    level1World.showWorldSprites();

  }


  //UPDATE: level2Grid Screen
  if(currentScreen == level2Grid){
    System.out.print("b");
    currentGrid = level2Grid;

    //Display the knight2 image
    GridLocation knight2Loc = new GridLocation(knight2Row,0);
    level2Grid.setTileImage(knight2Loc, knight2);
    
    //update other screen elements
    level2Grid.showGridImages();
    level2Grid.showGridSprites();
    level2Grid.showWorldSprites();

    //move to next level based on a button click
    b1.show();
    if(b1.isClicked()){
      System.out.println("\nButton Clicked");
      currentScreen = level1World;
    }
  
  }
  
  //UPDATE: End Screen
  // if(currentScreen == endScreen){

  // }

  //UPDATE: Any Screen
  if(doAnimation){
    runningHorse.animateHorizontal(5.0, 10.0, true);
  }


}

//Method to populate enemies or other sprites on the screen
public void populateSprites(){

  //What is the index for the last column?
  

  //Loop through all the rows in the last column

    //Generate a random number


    //10% of the time, decide to add an enemy image to a Tile
    

}

//Method to move around the enemies/sprites on the screen
public void moveSprites(){

//Loop through all of the rows & cols in the grid

      //Store the current GridLocation

      //Store the next GridLocation

      //Check if the current tile has an image that is not knight2      


        //Get image/sprite from current location
          

        //CASE 1: Collision with knight2


        //CASE 2: Move enemy over to new location


        //Erase image/sprite from old location

        //System.out.println(loc + " " + grid.hasTileImage(loc));

          
      //CASE 3: Enemy leaves screen at first column

}

//Method to check if there is a collision between Sprites on the Screen
public boolean checkCollision(GridLocation loc, GridLocation nextLoc){

  //Check what image/sprite is stored in the CURRENT location
  // PImage image = grid.getTileImage(loc);
  // AnimatedSprite sprite = grid.getTileSprite(loc);

  //if empty --> no collision

  //Check what image/sprite is stored in the NEXT location

  //if empty --> no collision

  //check if enemy runs into player

    //clear out the enemy if it hits the player (using cleartTileImage() or clearTileSprite() from Grid class)

    //Update status variable

  //check if a player collides into enemy

  return false; //<--default return
}

//method to indicate when the main game is over
public boolean isGameOver(){
  
  return false; //by default, the game is never over
}

//method to describe what happens after the game is over
public void endGame(){
    System.out.println("Game Over!");

    //Update the title bar

    //Show any end imagery
    currentScreen = endScreen;

}
