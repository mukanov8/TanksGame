/*
	Project 2
	Name of Project: TanksGame
	Author:	Ayan Mukanov 20170881
	Date:	June 2020
*/

import fisica.*;
import processing.sound.*;
import java.util.*;

import websockets.*;
import java.util.Iterator;

WebsocketServer ws;

//String bitbucketURL = "https://mukanov8.bitbucket.io/";

String bitbucketMapURL = "https://mukanov8.bitbucket.io/map.html";
String bitbucketTanksURL = "https://mukanov8.bitbucket.io/tanks.html";

String localMapURL;
String localTanksURL;
// add local addresses if needed. Ex: "http://127.0.0.1:5500/map.html" & "http://127.0.0.1:5500/tanks.html" 
// and assign them to two strings below
String mapCreateURL  = bitbucketMapURL; //localMapURL
String tankSelectURL = bitbucketTanksURL; //localTanksURL

//Websocket address: ws://localhost:8025/test

FWorld world;

Player player1;
Player player2;
color player1_color;
color player2_color;
int player1_tank_type;
int player2_tank_type;


ArrayList<FCircle> bullets1;
ArrayList<FCircle> bullets2;
ArrayList<FBox> bricks;
ArrayList<FBox> tanks;	
MenuPages pages = new MenuPages();

ArrayList<PVector> brickstorage;
ArrayList<FBox> map1;
ArrayList<FBox> map2;
ArrayList<FBox> map3;

int menuSetting = 1;
int gameTurns = 5;

int score1;
int score2;

float bulletTimer1 =0;
float bulletTimer2 =0;

boolean shootable1;
boolean shootable2;

float centerX;
float centerY;

int brickSize;


int brick_cnt;
int tank_cnt;


PImage intro, mapShot1, mapShot2;

ExplosionAnimation explosion1;
ExplosionAnimation explosion2;
boolean isExplosion1;
boolean isExplosion2;
SoundFile shootSound, explosionSound, matchendSound, gameendSound, crashSound, clickSound;
boolean keys1[] = new boolean[5]; //Boolean array to store key inputs for player1
boolean keys2[] = new boolean[5]; //Boolean array to store key inputs for player2

float health1;	//health of player1
float health2;	//health of player2

float explTimer1 = 0;
float explTimer2 = 0;
float incr=1;

void setup()
{
	size(1200, 800);
	smooth();
	Fisica.init(this);
	world = new FWorld();
	world.setGravity(0,0);
	world.setEdges(this,color(22,10,11));
	
	bricks = new ArrayList<FBox>();
	tanks = new ArrayList<FBox>(2);
	map1 = new ArrayList<FBox>();
	map2 = new ArrayList<FBox>();
	map3 = new ArrayList<FBox>();
	bullets1 =  new ArrayList<FCircle>();
	bullets2 =  new ArrayList<FCircle>();

	brickSize=80; 
	tank_cnt = 0; brick_cnt = 0;
	score1 = 0; score2 = 0;
	
	centerX = width/2 - 280;
  	centerY = height/2 - 120;

  	player1_color = color(184,44,34);
  	player2_color = color(44,104,154);
  	player1_tank_type =1;
  	player2_tank_type =1;

  	mapShot1 = loadImage("data/Map1.png");
	mapShot2 = loadImage("data/Map2.png");

	intro = loadImage("data/Gameplay_screenshot.png");

	shootSound = new SoundFile(this, "data/shoot.mp3");
  	explosionSound = new SoundFile(this, "data/explosion.mp3");
  	matchendSound = new SoundFile(this, "data/matchend.mp3");
  	gameendSound = new SoundFile(this, "data/gameend.mp3");
  	crashSound = new SoundFile(this, "data/metalcrash.mp3");
  	clickSound = new SoundFile(this, "data/click.mp3");

  	isExplosion1=false;
  	isExplosion2=false;

  	ws = new WebsocketServer(this, 8025, "/test");

}

void draw() {
	background(#E6D9C1);
	// game state(scene) managing
	if (menuSetting==1) 	{ pages.start(); }
	// else if (menuSetting==2){ pages.intro(); }
	else if (menuSetting==3){ pages.maps();	}
	else if (menuSetting==4){ pages.loadingMap();} //web. //open map.js
	else if (menuSetting==5){ world.draw(); world.step(); pages.loadingTanks();}  //open tank.js
	else if (menuSetting==6){ world.draw(); world.step(); pages.tankput();}
	else if (menuSetting==7){ 
		world.draw(); 
		tankControl(player1, keys1);
		tankControl(player2, keys2);
		updateScores();
		updateBullets();
		showExplosion();
		pages.gameplay(); 
		world.step();
	}
	else if (menuSetting==0) { pages.matchover(); }	
	else if (menuSetting==-1){ pages.gameover();  }	
}

void webSocketServerEvent(String msg) 
{
	
	JSONObject json= parseJSONObject(msg);
	try
	{
		if (json!=null)	
			{
				if(menuSetting == 4){
					println("Map received!");
					if(!(json.isNull("bricks"))){
						int mapCnt = (json.getJSONArray("bricks")).getInt(0);
						int brickSize = (json.getJSONArray("bricks")).getInt(1);
						// saveJSONObject(json, "data/map"+(3+mapCnt)+".json");
						saveJSONObject(json, "data/map"+3+".json");
						menuSetting = 3;
					}else {println("empty map");}
				}
				else if(menuSetting==5){
					println("Tanks Chosen");
					if(!(json.isNull("tanks"))){
						player1_tank_type = (json.getJSONArray("tanks")).getInt(0);
						player2_tank_type = (json.getJSONArray("tanks")).getInt(1);
						menuSetting = 3;
					}else {println("no tanks were selected");}

				}
			}
	}catch (Exception ie)
	{
		println("Exception: Invalid command");
	}
}

void showExplosion(){
    if(isExplosion1){
    	if (explosion1.on()) explosion1.draw();
    	else isExplosion1 =false;
    }
    if(isExplosion2){
    	if (explosion2.on()) explosion2.draw();
    	else isExplosion2=false;
    }
}
void updateScores() {	//updates scores according to health of each player
	if (health1<=0 ){ 
		if(score1<4 && score2<4){score2+=1; matchendSound.play(); menuSetting=0;	}	//when match ends
		else if(score2==4) 		{score2+=1; gameendSound.play();  menuSetting=-1;}	//when game ends,i.e. 5 wins
	}
	if (health2<=0 ){ 
		if(score1<4 && score2<4){score1+=1; matchendSound.play(); menuSetting=0;}
		else if(score1==4)		{score1+=1; gameendSound.play(); menuSetting=-1;}
	}
}	

void updateBullets(){
	//so that can only shoot 1 bullet per second
	if(bulletTimer1==0){shootable1 = true;}
	else if(millis() - bulletTimer1<1000){shootable1 = false;}
	else {shootable1 = true; }

	if(bulletTimer2==0){shootable2 = true;}
	else if(millis() - bulletTimer2<1000){shootable2 = false;}
	else {shootable2 = true; }

	//so that there're at most 4 bullets per player at any given time
	if (bullets1.size()>4){
		world.remove(bullets1.get(0)); bullets1.remove(0);
	}
	if (bullets2.size()>4){
		world.remove(bullets2.get(0)); bullets2.remove(0);
	}
	//deletes the bullet which is too slow
	if(!bullets1.isEmpty()){
		float x = (bullets1.get(0)).getVelocityX();
		float y = (bullets1.get(0)).getVelocityY();
		// if(bullets.get(0).)
		if((float)Math.sqrt(x*x + y*y)<40.0){
			world.remove(bullets1.get(0)); bullets1.remove(0);
		}
	}
	if(!bullets2.isEmpty()){
		float x = (bullets2.get(0)).getVelocityX();
		float y = (bullets2.get(0)).getVelocityY();
		if((float)Math.sqrt(x*x + y*y)<30.0){
			world.remove(bullets2.get(0)); bullets2.remove(0);
		}
	}
}

void mouseClicked() {
	//startingPage				//pressed 'play' button
	if (menuSetting==1&& (mouseX > 150 + centerX && mouseX < 400 + centerX) && (mouseY > 150 + centerY && mouseY < 200 + centerY)){
		clickSound.play();
		menuSetting = 3;
	}
	//intrusctions page. not used currently.
	// if (menuSetting==2&& (mouseX > 150 + centerX && mouseX < 400 + centerX) && (mouseY > 150 + centerY && mouseY < 200 + centerY)){
	// 	clickSound.play();
	// 	menuSetting = 3;
	// }

	//pressed map1
	else if (menuSetting==3&&((mouseX > centerX-125 && mouseX < 75 + centerX) && (mouseY > centerY && mouseY < 200 + centerY))){
		loadMapfromJSON("data/map1.json", map1);
		if(map1.size()>0){
			clickSound.play();
			loadMap(map1); 
			menuSetting=6;
		}
	}
	//pressed map2
	else if (menuSetting==3&&((mouseX > centerX+175 && mouseX < 375 + centerX) && (mouseY > centerY && mouseY < 200 + centerY))){
		loadMapfromJSON("data/map2.json", map2);
		if(map2.size()>0){
			clickSound.play();
			loadMap(map2); 
			menuSetting=6;
		}
	}
	//pressed map3
	else if (menuSetting==3&&((mouseX > centerX+475 && mouseX < 675 + centerX) && (mouseY > centerY && mouseY < 200 + centerY))){
		loadMapfromJSON("data/map3.json", map3);
		if(map3.size()>0){
			clickSound.play();
			loadMap(map3); 
			menuSetting=6;
		}
	}
	//MapChoosingPage			//pressed 'create map' button
 	else if (menuSetting==3&&(mouseX > centerX+150 && mouseX < 400 + centerX) && (mouseY > centerY+260 && mouseY < 320 + centerY)){
		clickSound.play();
		menuSetting = 4;
		// linking to the MapCreation Web Client Page
		link(mapCreateURL);
		ws.sendMessage("{\"message\":\"map\"}");
		
	}
	//pressed 'choose tanks' button
	else if (menuSetting==3&&(mouseX > centerX+150 && mouseX < 400 + centerX) && (mouseY > centerY+360 && mouseY < 420 + centerY)){
		clickSound.play();
		menuSetting = 5;
		// linking to the TanksSelection Web Client Page
		link(tankSelectURL);
		ws.sendMessage("{\"message\":\"tanks\"}");

	}

	//Places&adds two players(tanks) on the map
	else if (menuSetting==6){
		//pressed 'start' button
		if(tank_cnt==2 &&(mouseX > 550 && mouseX < 600) && (mouseY > 400 && mouseY < 430)){
			clickSound.play();
			menuSetting = 7; } 			//if pressed start->go to next stage
		//clicked on screen except 'start' button
		else if ((mouseX>=brickSize/2)&&(mouseX<=width-brickSize/2)&&(mouseY>=brickSize/2)&&(mouseY<=height-brickSize/2)){
			createTank(mouseX,mouseY);	//creates player/tank. Will be called only 2 times
			clickSound.play();
		}	
	}
	else if(menuSetting==7){
		if ((mouseX > 20 && mouseX < 80) && (mouseY > height-60 && mouseY < height-40)){
			player1.changeWeapon();
		}
		if ((mouseX > width-100 && mouseX < width-20) && (mouseY > height-60 && mouseY < height-40)){
			player2.changeWeapon();
		}
	}
	//restarts the match, i.e. soft reset (goes on until 5 wins)
	else if (menuSetting==0 && (mouseX > centerX+150 && mouseX < 400 + centerX) && (mouseY > centerY+300 && mouseY < 360 + centerY)){
		reset();
		clickSound.play();
		menuSetting = 3;
	}	//restart the game, i.e. hard reset (happens when player wins/loses 5 times)
	else if (menuSetting==-1 && (mouseX > centerX+150 && mouseX < 400 + centerX) && (mouseY > centerY+300 && mouseY < 360 + centerY)){
		reset();
		score1=0; score2=0;
		clickSound.play();
		menuSetting = 1;
		player1_tank_type=1; player2_tank_type =1;
	}
}

void keyPressed(){
	if(menuSetting==7){			//will register keypress only when in the playing menu/mode
		if (key =='w' || key =='W') 	{keys1[0] = true; }
		else if(key =='d' || key =='D') {keys1[1] = true; player1.adjustRight();} //adds angular velocity a bit if user keeps pressing turn button
		else if(key =='s' || key =='S') {keys1[2] = true; } 
		else if(key =='a' || key =='A') {keys1[3] = true; player1.adjustLeft(); } 
		else if(key ==' ') {keys1[4] = true; }
		//Player2
		if (keyCode == UP) 	  	   {keys2[0] = true; }
		else if (keyCode == RIGHT) {keys2[1] = true; player2.adjustRight();}
		else if (keyCode == DOWN)  {keys2[2] = true; }
		else if (keyCode == LEFT)  {keys2[3] = true; player2.adjustLeft();}
		else if (keyCode == ENTER) {keys2[4] = true; }	
	}
} 

void keyReleased() {
	if(menuSetting==7){
		//Player1
		if (key == 'w' || key =='W') {keys1[0] = false;}
		if (key == 'd' || key =='D') {keys1[1] = false;}
		if (key == 's' || key =='S') {keys1[2] = false;}
		if (key == 'a' || key =='A') {keys1[3] = false;}
		if ((key == ' ') && shootable1) {
			keys1[4] = false; 
			bulletTimer1= millis(); //so that user can shoot only once in 1 second
			player1.shoot(); 
			shootSound.play(); }  		//shoting sound
		//Player2
		if (keyCode == UP)    {keys2[0] = false;}
		if (keyCode == RIGHT) {keys2[1] = false;}
		if (keyCode == DOWN)  {keys2[2] = false;}
		if (keyCode == LEFT)  {keys2[3] = false;}
		if ((keyCode == ENTER)&&shootable2) {
			keys2[4] = false; 
			bulletTimer2= millis(); 
			player2.shoot(); 
			shootSound.play();} 
		//player1 change weapon
		if (key =='z' || key =='Z'){player1.changeWeapon(); clickSound.play();}
		//player2 change weapon
		if (key =='m' || key =='M') {player2.changeWeapon(); clickSound.play();}

	}
}

void tankControl(Player player, boolean[] keys){
	if(keys[0]) {player.forward(); player.adjustFront();}	//adds acceleration if user holds the button.
    if(keys[1]) {player.right();   } 
    if(keys[2]) {player.backward();player.adjustBack();}
    if(keys[3]) {player.left();    }
    //if(keys[4]) {} //shooting routine is activated upon releasing the keys[4] button
}
//for creating a new brick
void createBrick(float x, float y, int size, int b){
	brickSize = size;
	FBox brk = new FBox(brickSize,brickSize);
	brick_cnt+=1;
	brk.setPosition(x,y);
	brk.setGrabbable(true);
	brk.setStrokeWeight(5);
	if(b==1){
		brk.setStatic(true);		
		brk.setFill(194,112,57);	//orange color
		brk.setStroke(22,10,11);	//dark brown color
		brk.setGroupIndex(5);
		brk.setRestitution(0);
	}
	else if(b==2){
		brk.setStatic(true);
		brk.setFill(255, 237, 184); //ligth yellow color - soft brick
		brk.setStroke(240, 208, 127); //dark yellow
		brk.setGroupIndex(6);
		brk.setRestitution(0);
	}
	else if(b==3){
		brk.setStatic(false);
		brk.setFill(156, 156, 156); // grey color - moveable brick
		brk.setStroke(102, 102, 102); //dark grey
		brk.setGroupIndex(7);
		brk.setRestitution(1);
	}
	world.add(brk);
	bricks.add(brk);
}

void loadMap(ArrayList<FBox> map){
	if (map.size()>0){
		for(FBox brick:map){
			world.add(brick);
			bricks.add(brick);
		}
	}
}

//for loading brick(FBox object) and adding it to the correct map
void loadBrick(ArrayList<FBox> br, float x, float y,int size, int b){
	brickSize = size;
	FBox brk = new FBox(brickSize,brickSize);
	brick_cnt+=1;
	brk.setPosition(x,y);
	brk.setGrabbable(false);
	brk.setStrokeWeight(5);
	if(b==1){
		brk.setStatic(true);		
		brk.setFill(194,112,57);	//orange color
		brk.setStroke(22,10,11);	//dark brown color
		brk.setGroupIndex(5);
		brk.setRestitution(0);
	}
	else if(b==2){
		brk.setStatic(true);
		brk.setFill(255, 237, 184); //ligth yellow color - soft brick
		brk.setStroke(240, 208, 127); //dark yellow
		brk.setGroupIndex(6);
		brk.setRestitution(0);
	}
	else if(b==3){
		brk.setStatic(false);
		brk.setFill(156, 156, 156); // grey color - moveable brick
		brk.setStroke(102, 102, 102); //dark grey
		brk.setGroupIndex(7);
		brk.setRestitution(0);
	}
	br.add(brk);
}
void loadMapfromJSON(String filename, ArrayList<FBox> map ){
	// If file does not exists
	File f = new File(sketchPath(filename));
	if(!f.exists()) return;
	JSONObject json = loadJSONObject(filename);
	JSONArray pts = json.getJSONArray("bricks");
	for (int i = 2; i < pts.size(); i++) 
	{
    	JSONObject point= pts.getJSONObject(i); 
    	loadBrick(map, point.getFloat("x"), point.getFloat("y"), pts.getInt(1), point.getInt("b"));
    }
}

//not used currently. Needed to save map from the game to JSON.
// void saveMaptoJSON(String filename, ArrayList<FBox> map){
// 	JSONObject json = new JSONObject();
// 	JSONArray pts = new JSONArray();
// 	json.setJSONArray("bricks", pts);
// 	int i=0;
// 	for (FBody b:bricks){
// 		JSONObject point = new JSONObject();
// 		point.setFloat("x", b.getX());
// 		point.setFloat("y", b.getY());
// 		pts.setJSONObject(i,point);
// 		i++;
// 	}
// 	saveJSONObject(json, filename);
// 	saveMap(bricks, map); 	
// }

void createTank(float x, float y){
	ArrayList<FBody> overlap = new ArrayList<FBody>();	//to roughly check that there aren't any bodies where we want to add a tank
	overlap = world.getBodies(x,y);
	for (int i = -20;i<20;i+=10){
		for (int j = -20;j<20;j+=10){
		overlap.addAll(world.getBodies(x+i, y+j));
		}
	}
	if(overlap.size()>0){ println("pick another location!"); return;}
	else { if(tank_cnt==0) 	   { player1=new Player(x,y,"player1", player1_color, player1_tank_type); tank_cnt+=1; health1=player1.getHealth(); }
		   else if(tank_cnt==1) { player2=new Player(x,y,"player2", player2_color, player2_tank_type); tank_cnt+=1; health2=player2.getHealth();}
		   else 				   { println("Can't add more tanks"); return;}
	}
}
//to get the damage values of bullet
float getDamage(FBody bullet){
	if ( (bullet.getName()).equals("bouncer") ){ return 20.0; }
	else if ( (bullet.getName()).equals("destroyer") ){ return 50.0; }
	else return 0.0;
}

//for playing crash sound when tank collides with environment or other tank
void contactStarted(FContact c) {	
	//when two tanks collide the crash sound will play
	if ( ((c.getBody1()).getGroupIndex() ==1) && ((c.getBody2()).getGroupIndex() ==2) ){
		crashSound.play();
	}	
}

//checks the collision between bullet and tank.
void contactResult(FContactResult c){
	FBody body1 = null; 
  	FBody body2 = null;
	if (collided(c, body1, body2)){
		explosionSound.play();
	}
	if (body1 == null && body2==null) return;
}
boolean collided(FContactResult c, FBody one, FBody two){
	if ( (((c.getBody1()).getGroupIndex() ==1) || ((c.getBody1()).getGroupIndex() ==2)) && ((c.getBody2()).getGroupIndex() <0)){
		one = (FBody)c.getBody1();			//the FBody object of tank
		two = (FBody)c.getBody2();			//the FBody object of bullet
		if (one.getGroupIndex() == 1) {		//if player1 has been hit
			health1-=getDamage(two); 
			explTimer2=millis();
			isExplosion2=true;
			explosion2 = new ExplosionAnimation((FCircle)two , explTimer2);
			isExplosion2 = true;
			world.remove(two); 
			bullets2.remove((FCircle)two); 
		}
		else if (one.getGroupIndex() == 2) {//if player2 has been hit
			health2-= getDamage(two);
			explTimer1=millis();
			isExplosion1=true;
			explosion1 = new ExplosionAnimation((FCircle)two , explTimer1);
			isExplosion1 = true;
			world.remove(two); 
			bullets1.remove((FCircle)two);
		}
		return true;
	}
	//to check collisions of bullets with soft(destroyable) bricks
	if ( ((c.getBody1()).getGroupIndex() ==6) && ((c.getBody2()).getGroupIndex() <0) ){
		one = (FBody)c.getBody1();			//the FBody object of soft brick
		two = (FBody)c.getBody2();			//the FBody object of bullet
		if ( (two.getGroupIndex()== -1)||(two.getGroupIndex()== -3) ){
			explTimer1=millis();
			isExplosion1=true;
			explosion1 = new ExplosionAnimation((FCircle)two , explTimer1);
			isExplosion1 = true;
			world.remove(two); 
			bullets1.remove((FCircle)two);
			world.remove(one);
			bricks.remove(one);
		}
		else if ( (two.getGroupIndex()== -2)||(two.getGroupIndex()== -4) ){
			explTimer2=millis();
			isExplosion2=true;
			explosion2 = new ExplosionAnimation((FCircle)two , explTimer2);
			isExplosion2 = true;
			world.remove(two); 
			bullets2.remove((FCircle)two); 
			world.remove(one);
			bricks.remove(one);
		}
		return true;
	}
	return false;
	
}
//resets the game state
void reset(){
	tank_cnt=0; brick_cnt =0;
	player1 = null; player2 = null;
	bulletTimer1 = 0; bulletTimer2 = 0;
	player1 = null; player2 = null;
	if (bricks.size()>0){
		for (FBox brick:bricks){
			world.remove(brick);}
		bricks.clear();
	}
	if (bullets1.size()>0){
		for (FCircle bullet:bullets1){
			world.remove(bullet);}
		bullets1.clear();
	}
	if (bullets2.size()>0){
		for (FCircle bullet:bullets2){
			world.remove(bullet);}
		bullets2.clear();
	}
	if (tanks.size()>0){
		for (FBox tank:tanks){
			world.remove(tank);}
		tanks.clear();
	}
	if (map1.size()>0){
		for (FBox brick:map1){
			world.remove(brick);}
		map1.clear();
	}
	if (map2.size()>0){
		for (FBox brick:map2){
			world.remove(brick);}
		map2.clear();
	}
	if (map3.size()>0){
		for (FBox brick:map3){
			world.remove(brick);}
		map3.clear();
	}
	for (int i =0;i<4;i++){
		keys1[i] = false;
		keys2[i] = false;
	}
}


