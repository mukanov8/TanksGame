/*
	Project 2
	Name of Project:  TanksGame
	Author:	Ayan Mukanov
	Date:	June 2020
*/

var gameMap = 
{
  cells: [[],[]],
  rows: 24,
  cols: 16,
  active: 0,
  brickSize: 80,
  brickSizeList: [25,40,50,80,100,200],

  brickColorSolid: [194,112,57],
  brickStrokeSolid: [22,10,11],

  brickColorSoft: [255,237,184],
  brickStrokeSoft: [240,208,127],

  brickColorMove: [156,156,156],
  brickStrokeMove: [102,102,102],

  brickSelectionStroke: [255,247,232],

//   backgroundColor: [230, 217, 193]
  backgroundColor: [255, 230, 204]
}

let editmode= false;

let brush = 0;

let divs= {
	 btnSave:0,
	 brickSlider:0,
	 brickSliderName:0,
	 brickSliderLabel:0,
	 saveLabel:0,
	 clearLabel:0,
	 selectorLabel:0,
	 addLabel:0,
	 typeLabel:0,
	 typeSelect:0,
	 redTankLabel:0,
	 redTank:0
};
// the gui object
// let gui;
let cnv;
let mapCnt;
let retJson;

function setup (){
  cnv = createCanvas(1200, 800);   
  cnv.position(230, 10);

  mapCnt=1;
  divs.brickSlider = createSlider(1, 6, 1);
  divs.brickSlider.style('margin-top','50px');
  divs.brickSlider.style('width', '190px');
  divs.brickSlider.position(15, 30);
  divs.brickSlider.input(mapInit);
  divs.brickSlider.value(4);

  divs.brickSliderName = createP("Adjust the size of bricks");
  divs.brickSliderName.position(20,20);
  divs.brickSliderName.style('padding','10px');
  divs.brickSliderName.style('font-weight','bold');
  divs.brickSliderName.style('color','#FF292A');
 
  divs.brickSliderLabel = createSpan(divs.brickSlider.value());
  divs.brickSliderLabel.position(100,90);
  divs.brickSliderLabel.style('padding','10px');

  divs.saveLabel = createP( "Press 'e' - start/stop edit the map");
  divs.saveLabel.position(10,460);
  divs.saveLabel.style('padding','10px');
  divs.saveLabel.style('font-size','small');

  divs.clearLabel = createP( "Press 'c' - clear map from bricks");
  divs.clearLabel.position(10,500);
  divs.clearLabel.style('padding','10px');
  divs.clearLabel.style('font-size','small');

  divs.selectorLabel = createP( "Press 1/2/3 - switch brick type");
  divs.selectorLabel.position(10,540);
  divs.selectorLabel.style('padding','10px');
  divs.selectorLabel.style('font-size','small');

  divs.addLabel = createP( "Click/drag on map to add brick");
  divs.addLabel.position(10,580);
  divs.addLabel.style('padding','10px');
  divs.addLabel.style('font-size','small');
  
  divs.typeLabel = createP("Choose brick type to add");
  divs.typeLabel.style('padding','10px');
  divs.typeLabel.position(10,200);
  divs.typeLabel.style('color','#FF292A');

  divs.typeSelect = createSelect();
  divs.typeSelect.position(20,250);
  divs.typeSelect.style('border-radius', '6px');
  divs.typeSelect.style('width', '190px');
  divs.typeSelect.style('padding','5px');
  divs.typeSelect.option('solid brick');
  divs.typeSelect.option('soft brick');
  divs.typeSelect.option('moveable brick');

  divs.btnSave = createButton("Save");
  divs.btnSave.style('padding','5px');
  divs.btnSave.position(20,400);
  divs.btnSave.style('width', '190px');
  divs.btnSave.style('border-radius', '6px');
  divs.btnSave.hide();
  divs.btnSave.style('border', '1px solid black');
  divs.btnSave.mousePressed(savePressed);
  
  divs.redTankLabel = createP("*Tank for reference");
  divs.redTankLabel.style('font-size','small');
  divs.redTankLabel.position(20,670);

  divs.redTank = createImg(
	'assets/red_tank_n.png',
	'Tank'
  );
  divs.redTank.position(10,700);
  divs.redTank.style('padding','10px');

  mapInit(gameMap);
  editmode = true;

}

function draw(){
  textFont('Georgia');
  background(...gameMap.backgroundColor);
  makeFrame();
  mapDisplay();
  
  noStroke();
  if(editmode){
  fill(200, 19, 19);
  textSize(40);
  text('Map Creator', 440, 57);
  fill(255, 41, 41);
  textSize(40);
  text('Map Creator', 438, 57);
  }
}


function makeFrame(){
	strokeWeight(4);
	stroke(...gameMap.brickStrokeSolid);
	line(0,0,1200,0);
	line(0,0,0,800);
	line(0,800,1200,800);
	line(1200,0,1200,800);
}

function mapInit(){
	gameMap.brickSize  = gameMap.brickSizeList[divs.brickSlider.value()-1];
	gameMap.cols = height / gameMap.brickSize;
	gameMap.rows = width / gameMap.brickSize;
	gameMap.cells = new Array(gameMap.rows);
	for (let i = 0; i<gameMap.rows; i++){
	  gameMap.cells[i] = new Array(gameMap.cols);
	  for (let j=0;j<gameMap.cols;j++){
		gameMap.cells[i][j] = 0;
	  }
	} 
	divs.brickSliderLabel.html(divs.brickSlider.value());
}


function mapDisplay(){
	for (let i =0;i<gameMap.rows;i++){
		for (let j = 0;j<gameMap.cols;j++){
			if(editmode){ strokeWeight(2.5); stroke(...gameMap.brickSelectionStroke);	}
			else{
				strokeWeight(5); 
				if(gameMap.cells[i][j]==0){ noStroke();}
				else if(gameMap.cells[i][j]==1) {stroke(...gameMap.brickStrokeSolid);}
				else if(gameMap.cells[i][j]==2) {stroke(...gameMap.brickStrokeSoft);}
				else if(gameMap.cells[i][j]==3) {stroke(...gameMap.brickStrokeMove);}		
			}
			if(gameMap.cells[i][j]==0)		{fill(...gameMap.backgroundColor)}
			else if (gameMap.cells[i][j]==1){fill(...gameMap.brickColorSolid); }
			else if (gameMap.cells[i][j]==2){fill(...gameMap.brickColorSoft);}
			else if (gameMap.cells[i][j]==3){fill(...gameMap.brickColorMove);}
			if(editmode){ rect(i*gameMap.brickSize,j*gameMap.brickSize,gameMap.brickSize,gameMap.brickSize);}
			rect(i*gameMap.brickSize,j*gameMap.brickSize,gameMap.brickSize-2.5,gameMap.brickSize-2.5);
		}
	}makeFrame();
}

function mousePressed()
{
  if (!editmode) return;
  if (cellAlive(mouseX,mouseY)){brush = 0;}
  else{
	if(divs.typeSelect.value() ==='solid brick'){brush = 1; console.log(brush);}
	else if(divs.typeSelect.value() ==='soft brick'){brush = 2;console.log(brush);}
	else if(divs.typeSelect.value() ==='moveable brick'){brush = 3; console.log(brush);}
  }
  brickAdd(mouseX,mouseY,brush);
}

function mouseDragged()
{
  if (!editmode) return;
  brickAdd(mouseX,mouseY,brush);
}

function brickAdd(x,  y, b ){
	let xloc = Math.floor(x/gameMap.brickSize); 
	let yloc = Math.floor(y/gameMap.brickSize);
	gameMap.cells[xloc][yloc] = b;
}

function cellAlive(x,y){
	let xloc = Math.floor(x/gameMap.brickSize); 
	let yloc = Math.floor(y/gameMap.brickSize);
	return gameMap.cells[xloc][yloc] >0;
}

function savePressed(){
	js = {"bricks": []};
	js.bricks.push(mapCnt);
	js.bricks.push(gameMap.brickSize);
	for (let i =0;i<gameMap.rows;i++){
		for (let j = 0;j<gameMap.cols;j++){
			let x = gameMap.brickSize/2 + i*gameMap.brickSize;
			let y = gameMap.brickSize/2 + j*gameMap.brickSize;
			if(gameMap.cells[i][j] ==0){ continue;}
			else if(gameMap.cells[i][j] ==1) {pt = {"x" : x, "y" : y, "b": 1}; js.bricks.push(pt);}//add 1 to json
			else if(gameMap.cells[i][j] ==2) {pt = {"x" : x, "y" : y, "b": 2}; js.bricks.push(pt);}//add 2 to json
			else if(gameMap.cells[i][j] ==3) {pt = {"x" : x, "y" : y, "b": 3}; js.bricks.push(pt);}//add 3 to json
		}
	}
	console.log(js);
	ws.send(JSON.stringify(js));
	confirmNext();
}
function restart(){
	mapCnt++;
	editmode=true;
	divs.brickSlider.show();
	divs.brickSliderName.show();
	divs.brickSliderLabel.show();
	divs.typeLabel.show();
	divs.typeSelect.show();
	divs.btnSave.hide();
}
function confirmClear() {
	if (confirm("Map under edit will be cleared. Proceed?")) {
	  mapInit();
	} else {
	}
  }
function confirmNext() {
	if (confirm("Map was saved as \"Map"+ mapCnt+"\""+". " + "\n" + "Press 'OK' if you want to finish. "+ "\n" + "Press 'Cancel' if you want to create another map.")) {
		window.location.href = "index.html";
	} else {
		restart();
	}
}
function keyPressed() {
	if (key=='e' || key=='E')  {
		editmode=!editmode; 
		if(!editmode){
			alert("Editing done. Press 'Save' if you want to proceed. Press 'e' again if you want to edit.");
			divs.brickSlider.hide();
			divs.brickSliderName.hide();
			divs.brickSliderLabel.hide();
			divs.typeLabel.hide();
			divs.typeSelect.hide();
			divs.btnSave.show();
		}else{
			alert("Editing start. Press 'e' when you are done");
			divs.brickSlider.show();
			divs.brickSliderName.show();
			divs.brickSliderLabel.show();
			divs.typeLabel.show();
			divs.typeSelect.show();
			divs.btnSave.hide();
		} 
	}
	else if ((key=='C' || key == 'c') && editmode){ console.log("C was pressed");  confirmClear();}
	else if ((key=='s' || key == 'S') && !editmode){ console.log("S was pressed"); saveCanvas(cnv, 'myMap'+mapCnt, 'jpg'); alert("Screenshot of map will be saved");}
	else if(key==1 && editmode){divs.typeSelect.value('solid brick');}
	else if(key==2 && editmode){divs.typeSelect.value('soft brick');}
	else if(key==3 && editmode){divs.typeSelect.value('moveable brick');}
}



// called when loading the page
$(function () {
	ws = new WebSocket("ws://localhost:8025/test");
  
	ws.onopen = function () {
	  // Web Socket is connected, send data using send()
	  console.log("Ready...");
	};
  
	ws.onmessage = function (evt) {

	  var received_msg = evt.data;
	  retJson = JSON.parse(received_msg);
	  console.log(retJson);
	  console.log("Message is received..." + received_msg);
	};
  
	ws.onclose = function () {
	  // websocket is closed.
	  console.log("Connection is closed...");
	};
  });

  
