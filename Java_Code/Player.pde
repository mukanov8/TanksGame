//class for creating a player, by using an object of class FBox.
public class Player {
	private FBox tank;
	public Weapon weapon;
	private String weapon_name;
	private float x =0;
	private float y =0;
	private float speed = 20.0;
	private float ang_vel = 2;
	private float ang_vel_upd = 10;
	private float ang_pos= 4.71239;
	private float damping = 5.0;
	private float ang_damping = 5.0;
	private float friction = 5.0;
	private float restitution = 0.0;
	private int health;
	private String player_name;
	PImage red_tank_img = loadImage("data/red_tank.png");
	PImage blue_tank_img = loadImage("data/blue_tank.png");

	Player(float x, float y, String name){
		this.x = x; this.y = y;
		tank = new FBox(90,65);
		weapon_name="bouncer";		//need to implement a feature with 2 weapons. Currently only 1 weapon(bouncer) is available.
		health=100;
		player_name = name;

		tank.setName(name);
		tank.setPosition(x,y);
		tank.setRotation(ang_pos);
		tank.setRestitution(restitution);
		tank.setGrabbable(true);
		tank.setDamping(damping);
		tank.setAngularDamping(ang_damping);
		tank.setFriction(friction);

		if(name.equals("player1")){
			tank.setGroupIndex(1);
			tank.attachImage(red_tank_img); 
			tanks.add(0, tank);	}
		else {
			tank.setGroupIndex(2);
			tank.attachImage(blue_tank_img); 
			tanks.add(1, tank);	}
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

	//not used yet
	// void changeWeapon(String weapon){
	// 	weapon_name=weapon;
	// }

	void changeWeapon(){
		if(weapon_name.equals("bouncer")){weapon_name="destroyer";}
		else if(weapon_name.equals("destroyer")){weapon_name="bouncer";}
	}
	// void hitSuccess(){
	// 	weapon.destroyed();
	// }

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

	String getWeaponName(){ return weapon_name;}

	// FBox getTank(){return tank;}

}
