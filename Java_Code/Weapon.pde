//class for creating a weapon, by using an object of class FCircle.
//BulletFactory
public class Weapon{
	private FCircle bullet;
	private float x,y;

	private float damage; 

	private float speed = 700.0;
	private float ang_vel;
	private float ang_vel_upd;
	private float ang_pos;
	private float damping = 0.2;
	private float ang_damping = 0.1;
	private float friction = .1;

	Weapon(FBox tank, String name){

		this.x = tank.getX(); this.y = tank.getY();
		this.ang_pos=tank.getRotation();

		bullet = new FCircle(12);
		bullet.setStrokeWeight(4);

		if((tank.getName()).equals("player1")) {
			bullet.setFill(255,41,42); bullet.setStroke(200,19,19);   }	//red bullet
		else{ 							
			bullet.setFill(13,149,235);bullet.setStroke(17,104,158); }	//blue bullet

		bullet.setName(name);
		bullet.setDamping(damping);
		// bullet.setGroupIndex(-1);
		bullet.setAngularDamping(ang_damping);
		bullet.setGrabbable(false);
		bullet.setFriction(friction);
		bullet.setBullet(true);

		if(name.equals("bouncer")){
			bullet.setSize(12);
			// bullet.setStrokeWeight(4);
			damage=10;
			if((tank.getName()).equals("player1")) {bullet.setGroupIndex(-1);}
			bullet.setGroupIndex(-2);
			bullet.setRestitution(1);
			bullet.setPosition(x+(65*cos(ang_pos)),y+(65*sin(ang_pos)));
		}
		else if(name.equals("destroyer")){
			bullet.setSize(32);
			// bullet.setStrokeWeight(4);
			damage=50;
			if((tank.getName()).equals("player1")) {bullet.setGroupIndex(-3);}
			bullet.setGroupIndex(-4);
			bullet.setRestitution(0);
			bullet.setFriction(friction*4);
			bullet.setPosition(x+(75*cos(ang_pos)),y+(75*sin(ang_pos)));
		}
		// bullet.setPosition(x+(55*cos(ang_pos)),y+(55*sin(ang_pos)));
		bullet.setVelocity(speed*cos(ang_pos),speed*sin(ang_pos));

	 	if((tank.getName()).equals("player1")){
	 		bullets1.add(bullet);
		}else{	
			bullets2.add(bullet);	
		}world.add(bullet);
	}

	// public float getDamage(){return damage;}

	// public void destroyed(){
	// 	world.remove(bullet);
	// }
	
	// public float getAbsVelocity(){
	// 	return (float)Math.sqrt((bullet.getVelocityX()*bullet.getVelocityX())+(bullet.getVelocityY()*bullet.getVelocityY()));
	// }

}

