/*
	Project 1
	Name of Project: TanksGame
	Author:	Ayan Mukanov 20170881
	Date:	May 2020
*/

import fisica.*;
import processing.sound.*;
import java.util.*;

FWorld world;

Player player1;
Player player2;

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

int brick_w,brick_h;


int brick_cnt;
int tank_cnt;

// PImage img_b;
// PImage img_c;

Animation expl;
SoundFile shoot, explosion, matchend, gameend, crash, click;
boolean keys1[] = new boolean[5]; //Boolean array to store key inputs for player1
boolean keys2[] = new boolean[5]; //Boolean array to store key inputs for player2

float health1;	//health of player1
float health2;	//health of player2

void setup()
{
	size(1200, 900);
	smooth();
	Fisica.init(this);
	world = new FWorld();
	world.setGravity(0,0);
	world.setEdges(this,color(22,10,11));

	brick_w=75; brick_h=brick_w; 
	brick_cnt =0;

	bricks = new ArrayList<FBox>();
	tanks = new ArrayList<FBox>(2);
	map1 = new ArrayList<FBox>();
	map2 = new ArrayList<FBox>();
	map3 = new ArrayList<FBox>();
	bullets1 =  new ArrayList<FCircle>();
	bullets2 =  new ArrayList<FCircle>();

	tank_cnt = 0; brick_cnt = 0;
	score1 = 0; score2 = 0;
	
	centerX = width/2 - 280;
  	centerY = height/2 - 120;

  	// img_b =loadImage("data/brick_75.png");
	// img_b =loadImage("data/brick_color.png");
	// img_b =loadImage("concrete.png");
	
	shoot = new SoundFile(this, "data/shoot.mp3");
  	explosion = new SoundFile(this, "data/explosion.mp3");
  	matchend = new SoundFile(this, "data/matchend.mp3");
  	gameend = new SoundFile(this, "data/gameend.mp3");
  	crash = new SoundFile(this, "data/metalcrash.mp3");
  	click = new SoundFile(this, "data/click.mp3");
  	expl =  new Animation();

}

void draw() {
	background(#E6D9C1);
	if (menuSetting==1) 	{ pages.start(); }
	else if (menuSetting==2){ pages.maps();  }
	else if (menuSetting==3){ pages.mapcustom();world.draw(); world.step();}
	else if (menuSetting==4){ pages.tankput();  world.draw(); world.step();}
	else if (menuSetting==5){ 
		pages.gameplay(); 
		tankControl(player1, keys1);
		tankControl(player2, keys2);
		updateScores();
		updateBullets();
		world.draw(); 
		world.step();
	}
	else if (menuSetting==0) { pages.matchover(); }	
	else if (menuSetting==-1){ pages.gameover();  }	
}

void updateScores() {	//updates scores according to health of each player
	if (health1<=0 ){ 
		if(score1<4 && score2<4){score2+=1; matchend.play(); menuSetting=0;	}	//when match ends
		else if(score2==4) 		{score2+=1; gameend.play();  menuSetting=-1;}	//when game ends,i.e. 5 wins
	}
	if (health2<=0 ){ 
		if(score1<4 && score2<4){score1+=1; matchend.play(); menuSetting=0;}
		else if(score1==4)		{score1+=1; gameend.play(); menuSetting=-1;}
	}
}	

void updateBullets(){
	//so that can only 1 bullet per second
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
		if((float)Math.sqrt(x*x + y*y)<30.0){
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
		click.play();
		menuSetting = 2;
	}
	//pressed map1
	else if (menuSetting==2&&((mouseX > centerX-125 && mouseX < 75 + centerX) && (mouseY > centerY && mouseY < 200 + centerY))){
		loadMapfromJSON("data/map1.json", map1);
		if(map1.size()>0){
			click.play();
			loadMap(map1); 
			menuSetting=4;
		}
	}
	//pressed map2
	else if (menuSetting==2&&((mouseX > centerX+175 && mouseX < 375 + centerX) && (mouseY > centerY && mouseY < 200 + centerY))){
		loadMapfromJSON("data/map2.json", map2);
		if(map2.size()>0){
			click.play();
			loadMap(map2); 
			menuSetting=4;
		}
	}
	//pressed map3
	else if (menuSetting==2&&((mouseX > centerX+475 && mouseX < 675 + centerX) && (mouseY > centerY && mouseY < 200 + centerY))){
		if(map3.size()>0){
			click.play();
			loadMap(map3); 
			menuSetting=4;
		}
	}
	//MapChoosingPage			//pressed 'create map' button
 	else if (menuSetting==2&&(mouseX > centerX+150 && mouseX < 400 + centerX) && (mouseY > centerY+300 && mouseY < 360 + centerY)){
		click.play();
		menuSetting = 3;
	}
	//CustomMapCreatingPage 
	else if (menuSetting==3){
		//pressed 'done' button
		if((mouseX > 550 && mouseX < 600) && (mouseY > 400 && mouseY < 430)){
			click.play();
			saveMap(bricks, map3);	//saves the map in map3 slot
			menuSetting = 4;}	
		//right clicked on screen except 'done' button -> delete brick from the map
		else if ((mouseX>=brick_w/2)&&(mouseX<=width-brick_w/2)&&(mouseY>=brick_h/2)&&(mouseY<=height-brick_h/2) && (mouseButton == RIGHT)){
			deleteBrick(mouseX,mouseY);
		}	
		//clicked on screen -> adds a brick to the map
		else if ((mouseX>=brick_w/2)&&(mouseX<=width-brick_w/2)&&(mouseY>=brick_h/2)&&(mouseY<=height-brick_h/2)){
			createBrick(mouseX,mouseY);	//adds a brick to the map
			click.play();
		}

	}
	//Places&adds two players(tanks) on the map
	else if (menuSetting==4){
		//pressed 'start' button
		if(tank_cnt==2 &&(mouseX > 550 && mouseX < 600) && (mouseY > 400 && mouseY < 430)){
			click.play();
			menuSetting = 5; } 			//if pressed start->go to next stage
		//clicked on screen except 'start' button
		else if ((mouseX>=brick_w/2)&&(mouseX<=width-brick_w/2)&&(mouseY>=brick_h/2)&&(mouseY<=height-brick_h/2)){
			createTank(mouseX,mouseY);	//creates player/tank. Will be called only 2 times
			click.play();
		}	
	}
	else if(menuSetting==5){
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
		click.play();
		menuSetting = 2;
	}	//restart the game, i.e. hard reset (happens when player wins/loses 5 times)
	else if (menuSetting==-1 && (mouseX > centerX+150 && mouseX < 400 + centerX) && (mouseY > centerY+300 && mouseY < 360 + centerY)){
		reset();
		score1=0; score2=0;
		click.play();
		menuSetting = 1;
	}
}

void keyPressed(){
	if(menuSetting==5){			//will register keypress only when in the playing menu/mode
		if (key =='w') 	   {keys1[0] = true; }
		else if(key =='d') {keys1[1] = true; player1.adjustRight();} //adds angular velocity a bit if user keeps pressing turn button
		else if(key =='s') {keys1[2] = true; } 
		else if(key =='a') {keys1[3] = true; player1.adjustLeft(); } 
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
	if(menuSetting==5){
		//Player1
		if (key == 'w') {keys1[0] = false;}
		if (key == 'd') {keys1[1] = false;}
		if (key == 's') {keys1[2] = false;}
		if (key == 'a') {keys1[3] = false;}
		if ((key == ' ') && shootable1) {
			keys1[4] = false; 
			bulletTimer1= millis(); //so that user can shoot only once in 1 second
			player1.shoot(); 
			shoot.play(); }  		//shoting sound
		//Player2
		if (keyCode == UP)    {keys2[0] = false;}
		if (keyCode == RIGHT) {keys2[1] = false;}
		if (keyCode == DOWN)  {keys2[2] = false;}
		if (keyCode == LEFT)  {keys2[3] = false;}
		if ((keyCode == ENTER)&&shootable2) {
			keys2[4] = false; 
			bulletTimer2= millis(); 
			player2.shoot(); 
			shoot.play();} 
	}
}

void tankControl(Player player, boolean[] keys){
	if(keys[0]) {player.forward(); }
    if(keys[1]) {player.right();   } 
    if(keys[2]) {player.backward();}
    if(keys[3]) {player.left();    }
    //if(keys[4]) {} //shooting routine is activated upon releasing the keys[4] button
}

void createBrick(float x, float y){
	FBox brk = new FBox(brick_w,brick_h);
	brick_cnt+=1;
	brk.setPosition(x,y);
	brk.setRestitution(0);
	brk.setStatic(true);		
	brk.setFill(194,112,57);	//orange color
	brk.setStroke(22,10,11);	//dark brown color
	brk.setStrokeWeight(5);
	brk.setGrabbable(true);
	// brk.attachImage(img_b);
	// brk.draw(this);
	world.add(brk);
	bricks.add(brk);
}
void deleteBrick(float x, float y){
	FBody del = (FBody)world.getBody(x,y); 
	bricks.remove((FBox)del);
	world.remove(del);
	brick_cnt-=1;
}
void saveMap(ArrayList<FBox> bricks, ArrayList<FBox> map ){
	if (bricks.size()>0){
		for(FBox brick:bricks){
			map.add(brick);
		}
	}
}
void loadMap(ArrayList<FBox> map){
	if (map.size()>0){
		for(FBox brick:map){
			world.add(brick);
			bricks.add(brick);
		}
	}
}
//for creating brick(FBox object) and adding it to the correct map
void loadBrick(ArrayList<FBox> br, float x, float y){
	FBox brk = new FBox(brick_w,brick_h);
	brick_cnt+=1;
	brk.setPosition(x,y);
	brk.setRestitution(0);
	brk.setStatic(true);	
	brk.setFill(194,112,57);	//orange color
	brk.setStroke(22,10,11);	//dark brown color
	brk.setStrokeWeight(5);
	brk.setGrabbable(true);
	br.add(brk);
}
void loadMapfromJSON(String filename, ArrayList<FBox> map ){
	// If file does not exists
	File f = new File(sketchPath(filename));
	if(!f.exists()) return;
	JSONObject json = loadJSONObject(filename);
	JSONArray pts = json.getJSONArray("bricks");
	for (int i = 0; i < pts.size(); i++) 
	{
    	JSONObject point= pts.getJSONObject(i); 
    	loadBrick(map, point.getFloat("x"), point.getFloat("y"));
    }
}

//not used currently
void saveMaptoJSON(String filename, ArrayList<FBox> map){
	JSONObject json = new JSONObject();
	JSONArray pts = new JSONArray();
	json.setJSONArray("bricks", pts);
	int i=0;
	for (FBody b:bricks){
		JSONObject point = new JSONObject();
		point.setFloat("x", b.getX());
		point.setFloat("y", b.getY());
		pts.setJSONObject(i,point);
		i++;
	}
	saveJSONObject(json, filename);
	saveMap(bricks, map); 	
}

void createTank(float x, float y){
	ArrayList<FBody> overlap = new ArrayList<FBody>();	//to roughly check that there aren't any bodies where we want to add a tank
	overlap = world.getBodies(x,y);
	overlap.addAll(world.getBodies(x+10, y+10));
	overlap.addAll(world.getBodies(x-10, y-10));
	overlap.addAll(world.getBodies(x+10, y-10));
	overlap.addAll(world.getBodies(x-10, y+10));
	if(overlap.size()>0){ println("pick another location!"); return;}
	else{ if(tank_cnt==0) 	   { player1=new Player(x,y,"player1"); tank_cnt+=1; health1=player1.getHealth();}
		  else if(tank_cnt==1) { player2=new Player(x,y,"player2"); tank_cnt+=1; health2=player2.getHealth();}
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
	//when any tank collides with other bricks & map borders
	if( ((c.getBody1()).getGroupIndex() >0) && ((c.getBody2()).isStatic()) ){
		// crash.play();		
	}
	//I decided to not play the sound since it becomes too loud when players start hitting the bricks
	else if ( ((c.getBody2()).getGroupIndex() >0) && ((c.getBody1()).isStatic()) ){
		// crash.play();
	}
	//when two tanks collide
	else if ( ((c.getBody2()).getGroupIndex() >0) && ((c.getBody2()).getGroupIndex() >0) ){
		crash.play();
	}
	// else if(((c.getBody1()).isStatic()) && ((c.getBody2()).getGroupIndex() <0) ){
	// 	world.remove(c.getBody2()); 
	// }
}

//checks the collision between bullet and tank.
void contactResult(FContactResult c){
	FBody body1 = null; 
  	FBody body2 = null;
	if (collided(c, body1, body2)){
		explosion.play();
		expl.drawAnimation(c.getX()-20, c.getY()); 
	}
	if (body1 == null && body2==null) return;
}
boolean collided(FContactResult c, FBody one, FBody two){
	
	if ( ((c.getBody1()).getGroupIndex() >0) && ((c.getBody2()).getGroupIndex() <0)){
		one = (FBody)c.getBody1();			//the FBody object of tank
		two = (FBody)c.getBody2();			//the FBody object of bullet
		if (one.getGroupIndex() == 1) {		//if player1 has been hit
			health1-=getDamage(two); 
			world.remove(two); 
			bullets2.remove((FCircle)two); 
		}
		else if (one.getGroupIndex() == 2) {//if player2 has been hit
			health2-= getDamage(two);
			world.remove(two); 
			bullets1.remove((FCircle)two);
		}
		return true;
	}
	return false;
}

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
	for (int i =0;i<4;i++){
		keys1[i] = false;
		keys2[i] = false;
	}
}


