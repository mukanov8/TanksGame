//class for displaying all pages (containing buttons and text) on the screen.
public class MenuPages{
	

	//is used in the beginning, i.e. starting page
	void start(){
		translate(centerX, centerY);	//Shift things to center for home screen
		fill(#C81313);
		textSize(80);
		text("TanksGame", 53, 67);
		fill(#FF292A);
		textSize(80);
		text("TanksGame", 50, 65);

		fill(#C81313);
		textSize(16);
		text("By Ayan", 240, 110);
		if ((mouseX > 240 + centerX && mouseX < 300 + centerX) && (mouseY > 90 + centerY && mouseY < 110 + centerY)){
			fill(#FF292A);
			textSize(16);
			text("By Ayan", 240, 110);
			if(mousePressed){link("https://github.com/mukanov8"); delay(1000);}
		}
		noStroke();
		fill(#CCC1AB);
		rect(150, 145, 250, 60,8);
		textSize(30);
		fill(#C81313);
		text("Play Game", 198, 185);
		if ((mouseX > 150 + centerX && mouseX < 400 + centerX) && (mouseY > 145 + centerY && mouseY < 205 + centerY)){
			fill(#FFF1D6);
			rect(150, 145, 250, 60,8);
			fill(#FF292A);
			text("Play Game", 198, 185);
		}
	}

	// void intro(){
	// 	println("introoo");
	// 	translate(centerX, centerY);//Shift things to center
	// 	fill(#C81313);
	// 	textSize(80);
	// 	text("Instructions", 3, -150);
	// 	// imageMode(CORNERS); image(intro, 0, 0, width, height); 
	// }

	//page where you choose the map
	void maps(){	
		translate(centerX, centerY);//Shift things to center
		fill(#C81313);
		textSize(60);
		text("Choose a map", 63, -150);
		fill(#FF292A);
		textSize(60);
		text("Choose a map", 60, -153);
		noStroke();
		fill(#CCC1AB);
		rect(-125,0, 200, 200,16);
		textSize(30);
		fill(#C81313);
		text("Map#1", -75, 100);
		if ((mouseX > centerX-125 && mouseX < 75 + centerX) && (mouseY > centerY && mouseY < 200 + centerY)){
			imageMode(CORNER); image(mapShot1, -125, 0, 200, 200); 
			// fill(#FFF1D6);
			// rect(-125,0, 200, 200,16);
			// fill(#FF292A);
			// text("Map#1", -75, 100);
			// textSize(15);
			// fill(#CCC1AB);
			// text("map#1", -55, 180);

			// if(map1.size()>0){
			// 	textSize(15);
			// 	fill(#CCC1AB);
			// 	text("map#1", -55, 180);
			// }else{
			// 	textSize(15);
			// 	fill(#CCC1AB);
			// 	text("no data", -55, 180);
			// }
		}

		noStroke();
		fill(#CCC1AB);
		rect(175, 0, 200, 200,16);
		textSize(30);
		fill(#C81313);
		text("Map#2", 225, 100);
		if ((mouseX > centerX+175 && mouseX < 375 + centerX) && (mouseY > centerY && mouseY < 200 + centerY)){
			imageMode(CORNER); image(mapShot2, 175, 0, 200, 200); 

			// 	fill(#FFF1D6);
			// 	rect(175, 0, 200, 200,16);
			// fill(#FF292A);
			// text("Map#2", 225, 100);
			// textSize(15);
			// fill(#CCC1AB);
			// text("map#2", 250, 180);

			// if(map2.size()>0){
			// 	textSize(15);
			// 	fill(#CCC1AB);
			// 	text("map#2", 225, 180);
			// }else{
			// 	textSize(15);
			// 	fill(#CCC1AB);
			// 	text("no data", 245, 180);
			// }
		}

		noStroke();
		fill(#CCC1AB);
		rect(475, 0, 200, 200,16);
		textSize(30);
		fill(#C81313);
		text("Map#3", 525, 100);
		if ((mouseX > centerX+475 && mouseX < 675 + centerX) && (mouseY > centerY && mouseY < 200 + centerY)){
			fill(#FFF1D6);
			rect(475, 0, 200, 200,16);
			fill(#FF292A);
			text("Map#3", 525, 100);

			textSize(15);
			fill(#CCC1AB);
			text("last saved map", 525, 180);
			// if(map3.size()>0){
			// 	textSize(15);
			// 	fill(#CCC1AB);
			// 	text("last saved map", 525, 180);
			// }
			//else{
			// 	textSize(15);
			// 	fill(#CCC1AB);
			// 	text("no data", 545, 180);
			// }
		}

		noStroke();
		fill(#CCC1AB);
		rect(150, 260, 250, 60,8);
		textSize(30);
		fill(#C81313);
		text("create map", 190, 300);
		if ((mouseX > centerX+150 && mouseX < 400 + centerX) && (mouseY > centerY+260 && mouseY < 320 + centerY)){
			fill(#FFF1D6);
			rect(150, 260, 250, 60,8);
			fill(#FF292A);
			text("create map", 190, 300);
		}

		noStroke();
		fill(#CCC1AB);
		rect(150, 360, 250, 60,8);
		textSize(30);
		fill(#C81313);
		text("choose tanks", 176, 400);
		if ((mouseX > centerX+150 && mouseX < 400 + centerX) && (mouseY > centerY+360 && mouseY < 420 + centerY)){
			fill(#FFF1D6);
			rect(150, 360, 250, 60,8);
			fill(#FF292A);
			text("choose tanks", 176, 400);
		}
	}

	void loadingMap(){
		translate(centerX, centerY);//Shift things to center
		fill(#C81313);
		textSize(40);
		text("loading the map...", 93, 0);
		fill(#FF292A);
		textSize(40);
		text("loading the map...", 90, 0);
	}

	//page where you create your own map, which is then saved
	//under the slot of 'map3'
	// void mapcustom(){
	// 	// translate(centerX, centerY);//Shift things to center
	// 	fill(#C81313);
	// 	textSize(20);
	// 	text("Click to add brick", centerX+183, 300);

	// 	fill(#C81313);
	// 	textSize(18);
	// 	text("Right-click to remove brick", centerX+143, 540);
	// 	fill(#C81313);
	// 	textSize(18);
	// 	text("Drag to move brick", centerX+173, 580);

	// 	noStroke();
	// 	fill(#CCC1AB);
	// 	rect(550, 400, 50, 30,4);
	// 	textSize(18);
	// 	fill(#C81313);
	// 	text("done", 553, 420);
	// 	if ((mouseX > 550 && mouseX < 600) && (mouseY > 400 && mouseY < 430)){
	// 		fill(#FFF1D6);
	// 		rect(550, 400, 50, 30,4);
	// 		fill(#FF292A);
	// 		text("done", 553, 420);
	// 	}
	// }

	void loadingTanks(){
		translate(centerX, centerY);//Shift things to center
		fill(#C81313);
		textSize(40);
		text("loading the tanks...", 93, 0);
		fill(#FF292A);
		textSize(40);
		text("loading the tanks...", 90, 0);
	}


	// page where you add a tank/player on screen. Only 2 tanks.
	void tankput(){
		fill(#C81313);
		textSize(20);
		text("Place two tanks on the map", centerX+125, 300);
		noStroke();
		fill(#CCC1AB);
		rect(550, 400, 50, 30,4);
		textSize(18);
		fill(#C81313);
		text("start", 555, 420);
		if ((mouseX > 550 && mouseX < 600) && (mouseY > 400 && mouseY < 430)){
			fill(#FFF1D6);
			rect(550, 400, 50, 30,4);
			fill(#FF292A);
			text("start", 555, 420);
		}	
	}

	//page where gameplay elements(healthbar,scores) are displayed 
	void gameplay(){
		// displays the health bars of player#1
		int padding = 20;
		int len;
		len = player1.health;
		
		noStroke();
		fill(#CCC1AB);
		rect(padding,padding,len,20);
		textSize(12);
		fill(#C81313);
		text("player1", padding+24, 55);

		if(health1>=0){
			noStroke();
			fill(#C81313);
			rect(padding+3,padding+3,health1 -6,20-6);
			// else if(player1.health ==50)
		}
		//score for player#1
		textSize(12);
		fill(#C81313);
		text("score: "+ score1, padding+24, 75);

		//weapon selection for player#1
		noStroke();
		fill(#CCC1AB);
		rect(padding,height-60,80,20);
		textSize(12);
		fill(#C81313);
		text(player1.getWeaponName(), padding+14, height- 45);
		if ((mouseX > padding && mouseX < 80) && (mouseY > height-60 && mouseY < height-40)){
			fill(#FFF1D6);
			rect(padding,height-60,80,20);
			fill(#C81313);
			text(player1.getWeaponName(), padding+14, height- 45);
		}

		//health bar for player#2
		len = player2.health;
		noStroke();
		fill(#CCC1AB);
		rect(width-len-padding,padding,len,20);
		textSize(12);
		fill(#11689E);
		text("player2", width-padding-70, 55);

		if(health2>=0){
			noStroke();
			fill(#11689E);
			rect(width-len-padding+3,padding+3,health2 -6,20-6);
		}

		//score for player#2
		textSize(12);
		fill(#11689E);
		text("score: "+score2, width-padding-70, 75);

		//weapon selection for player#2
		noStroke();
		fill(#CCC1AB);
		rect(width-padding-80,height-60,80,20);
		textSize(12);
		fill(#C81313);
		text(player2.getWeaponName(), width-padding-65, height- 45);
		if ((mouseX > width-padding-80 && mouseX < width-padding) && (mouseY > height-60 && mouseY < height-40)){
			fill(#FFF1D6);
			rect(width-padding-80,height-60,80,20);
			fill(#C81313);
			text(player2.getWeaponName(), width-padding-65, height- 45);
		}
	}

	//page when 1 match is over
	void matchover(){
		String str1 = String.valueOf(score1);
		String str2 = String.valueOf(score2);
		translate(centerX, centerY);	//Shift things to center
		fill(#C81313);
		textSize(80);
		text("Match Over", 60, -150);
		fill(#FF292A);
		textSize(80);
		text("Match Over", 57, -153);

		fill(#C81313);
		textSize(50);
		text("Score is  "+str1+" : "+str2, 115, 40);

		noStroke();
		fill(#CCC1AB);
		rect(150, 300, 250, 60,8);
		textSize(30);
		fill(#C81313);
		text("Continue?", 200, 340);
		if ((mouseX > centerX+150 && mouseX < 400 + centerX) && (mouseY > centerY+300 && mouseY < 360 + centerY)){
			fill(#FFF1D6);
			rect(150, 300, 250, 60,8);
			fill(#FF292A);
			text("Continue?", 200, 340);
		}
	}

	//page when one player looses 5 games, i.e. gameover
	void gameover(){
		String str1 = String.valueOf(score1);
		String str2 = String.valueOf(score2);
		translate(centerX, centerY);	//Shift things to center 
		fill(#C81313);
		textSize(80);
		text("Game Over", 60, -150);
		fill(#FF292A);
		textSize(80);
		text("Game Over", 57, -153);

		fill(#C81313);
		textSize(50);
		text("Score is  "+str1+" : "+str2, 115, 40);
		
		noStroke();
		fill(#CCC1AB);
		rect(150, 300, 250, 60,8);
		textSize(30);
		fill(#C81313);
		text("Play again?", 195, 340);
		if ((mouseX > centerX+150 && mouseX < 400 + centerX) && (mouseY > centerY+300 && mouseY < 360 + centerY)){
			fill(#FFF1D6);
			rect(150, 300, 250, 60,8);
			fill(#FF292A);
			text("Play again?", 195, 340);
		}
	}

}