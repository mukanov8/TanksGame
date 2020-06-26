// class for creating a player, by using an object of class FBox.
// TankFactory
public class Player {
	private FBox tank;
	public Weapon weapon;
	private String weapon_name;
	private float x =0;
	private float y =0;
	private float speed = 20.0;
	private float ang_vel = 2;
	private float ang_vel_upd = 10;
	private float vel_upd = 10;
	private float ang_pos= 4.71239;
	private float damping = 5.0;
	private float ang_damping = 5.0;
	private float friction = 5.0;
	private float restitution = 0.0;
	public int health;
	private String player_name;
	private color col;
	private int w,h;

	PImage red_tank_n = loadImage("data/red_tank_n.png");
	PImage blue_tank_n = loadImage("data/blue_tank_n.png");

	PImage red_tank_s = loadImage("data/red_tank_s.png");
	PImage blue_tank_s = loadImage("data/blue_tank_s.png");

	PImage red_tank_b = loadImage("data/red_tank_b.png");
	PImage blue_tank_b = loadImage("data/blue_tank_b.png");
	
	Player(float x, float y, String name, color col, int type){
		this.x = x; this.y = y;
		weapon_name="bouncer";	
		player_name = name;
		this.col = col;
		if(type==1){	//normal
			w = 90; h = 65;
			tank = new FBox(w,h);
			speed = 20.0;
			ang_vel_upd = 10;
			vel_upd = 10;
			health = 100;
			friction = 5.0;
			if(name.equals("player1")){
			tank.setGroupIndex(1);
			tank.attachImage(red_tank_n); 
			tank.setFill(col);
			tanks.add(0, tank);	}
			else {
			tank.setGroupIndex(2);
			tank.setFill(col);
			tank.attachImage(blue_tank_n); 
			tanks.add(1, tank);	}

		}
		else if(type==2){	//fast
			w = 80; h = 47; //change size to small
			tank = new FBox(w,h);
			speed = 35.0;
			ang_vel_upd = 15;
			ang_vel = 2.5;
			vel_upd = 15;
			health = 50;
			friction = 5.0;
			if(name.equals("player1")){
			tank.setGroupIndex(1);
			tank.attachImage(red_tank_s); 
			tank.setFill(col);
			tanks.add(0, tank);	}
			else {
			tank.setGroupIndex(2);
			tank.setFill(col);
			tank.attachImage(blue_tank_s); 
			tanks.add(1, tank);	}
		}
		else if(type==3){ //heavy
			w = 115; h = 75; //change size to big
			tank = new FBox(w,h);
			speed = 10.0;
			ang_vel_upd = 10;
			vel_upd = 10;
			health = 200;
			friction = 5.0;
			damping = 5.0;
			ang_damping = 5.5;
			if(name.equals("player1")){
			tank.setGroupIndex(1);
			tank.attachImage(red_tank_b); 
			tank.setFill(col);
			tanks.add(0, tank);	}
			else {
			tank.setGroupIndex(2);
			tank.setFill(col);
			tank.attachImage(blue_tank_b); 
			tanks.add(1, tank);	}
		}

		tank.setName(name);
		tank.setPosition(x,y);
		tank.setRotation(ang_pos);
		tank.setRestitution(restitution);
		tank.setGrabbable(true);
		tank.setDamping(damping);
		tank.setAngularDamping(ang_damping);
		tank.setFriction(friction);
		tanks.add(tank);
		world.add(tank);
	}

	void forward(){
		float xd = tank.getVelocityX();
		float yd = tank.getVelocityY();
		float rot= tank.getRotation();
		xd = xd += speed*cos(rot);
	    yd = yd += speed*sin(rot);
	    tank.setVelocity(xd,yd);
	}
	void backward(){
		float xd = tank.getVelocityX();
		float yd = tank.getVelocityY();
		float rot= tank.getRotation();
		xd = xd -= (speed/2)*cos(rot);
	    yd = yd -= (speed/2)*sin(rot);
	    tank.setVelocity(xd,yd);
	}
	void right(){
		tank.setAngularVelocity(ang_vel);
	}
	void left(){
		tank.setAngularVelocity(-ang_vel);
	}
	void adjustFront(){
		float rot= tank.getRotation();
		// println(tank.getVelocityX(),tank.getVelocityY());
		tank.adjustVelocity(vel_upd*cos(rot),vel_upd*sin(rot));
	}

	void adjustBack(){
		float rot= tank.getRotation();
		// println(tank.getVelocityX(),tank.getVelocityY());
		tank.adjustVelocity(-vel_upd*cos(rot),-vel_upd*sin(rot));
	}

	void adjustRight(){
		tank.adjustAngularVelocity(ang_vel_upd);
	}
	void adjustLeft(){
		tank.adjustAngularVelocity(-ang_vel_upd);
	}
	void shoot(){
		if (weapon_name.equals("bouncer")) weapon = new Weapon(tank,weapon_name);
		else if(weapon_name.equals("destroyer")) weapon = new Weapon(tank,weapon_name);
	}
	
	float getHealth() {return health;}

	void changeWeapon(){
		if(weapon_name.equals("bouncer")){weapon_name="destroyer";}
		else if(weapon_name.equals("destroyer")){weapon_name="bouncer";}
	}

	String getWeaponName(){ return weapon_name;}
	// void hitSuccess(){
	// 	weapon.destroyed();
	// }
	private PVector getPos(){
		return new PVector(tank.getX(), tank.getY());
	}

	private float getVel(){
		float xVel = tank.getVelocityX();
		float yVel = tank.getVelocityY();
		return (float)Math.sqrt(xVel*xVel + yVel*yVel);
	}

	private color getColor(){
		println(tank.getFillColor());
		return tank.getFillColor();
	}

	private PVector getBackPoint(){
		
		float rot= tank.getRotation();
		float xloc = tank.getX() -32.5*cos(rot);
		float yloc = tank.getY() -45*sin(rot);
		fill(100,100,100);
		ellipse(xloc,yloc,50,50);
		// println(xloc+" : " +yloc);
		return new PVector(xloc,yloc);
	}



	// void update(Player player){
	// 	if (player_name.equals("player1")) {health1-=(player.getWeapon()).getDamage();println(health1+" ::");}
	// 	if (player_name.equals("player2")) {health2-=(player.getWeapon()).getDamage();println(health2+" ::");}
	// }

	// void chooseWeapon(String weapon_name){
	// 	this.weapon_name = weapon_name;
	// 	// if(weapon.equals("bouncer")) this.weapon=new Weapon(tank,weapon);
	// 	// else if(weapon.equals("destroyer")) this.weapon=new Weapon(tank,weapon);
	// }

	// Weapon getWeapon(){ return weapon;}

	

	// FBox getTank(){return tank;}

}
