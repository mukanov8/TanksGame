

// let tanks= {

// 	tankType: ['regular', 'heavy', 'fast'],
//     tankColor: ['red', 'blue'],
//     imgs:[]
// };

let tanks = {"tanks": []};
let player1 = true;
let selectState =false;

let idlefill = (224, 224, 224);
let block1 = idlefill;
let block2 = idlefill;
let block3 = idlefill;
let activefill = (191, 191, 191);

let text1,text2;
let imgBtn1, imgBtn2, imgBtn3,imgBtn4,imgBtn5,imgBtn6;
let btnNext,btnSave;

let checkbox1,checkbox2,checkbox3;
let state;

function preload() {
  imgBtn1 = createImg('assets/red_tank_n.png', 'My Clickable Image');
  imgBtn2 = createImg('assets/red_tank_s.png', 'My Clickable Image');
  imgBtn3 = createImg('assets/red_tank_b.png', 'My Clickable Image');
  imgBtn4 = createImg('assets/blue_tank_n.png', 'My Clickable Image');
  imgBtn5 = createImg('assets/blue_tank_s.png', 'My Clickable Image');
  imgBtn6 = createImg('assets/blue_tank_b.png', 'My Clickable Image');
  imgBtn4.hide(); imgBtn5.hide(); imgBtn6.hide(); 

}
function turn(){
    if(player1){
        imgBtn1.show();imgBtn2.show();imgBtn3.show();
        imgBtn4.hide(); imgBtn5.hide(); imgBtn6.hide(); 
        text1.show(); text2.hide();
        checkbox1.checked(false); checkbox2.checked(false); checkbox3.checked(false);
        block1 = idlefill; block2 = idlefill; block3 = idlefill;
    }else{
        imgBtn1.hide();imgBtn2.hide();imgBtn3.hide();
        imgBtn4.show(); imgBtn5.show(); imgBtn6.show(); 
        text2.show(); text1.hide();
        checkbox1.checked(false); checkbox2.checked(false); checkbox3.checked(false);
        block1 = idlefill; block2 = idlefill; block3 = idlefill;
    }
}
function setup() {
    createCanvas(1400,650);
    state=true;
    text1 = createP("Player#1 Tank");
    text1.position(670,60);
    text1.style('font-weight','bold');

    text2 = createP("Player#2 Tank");
    text2.position(670,60);
    text2.style('font-weight','bold');
    text2.hide();

    imgBtn1.position(230, 150);
    imgBtn2.position(670, 160);
    imgBtn3.position(1100, 140);
  
    imgBtn4.position(230, 150);
    imgBtn5.position(670, 160);
    imgBtn6.position(1100, 140);

    checkbox1 = createCheckbox('', false);
    checkbox1.position(260,650);
    checkbox1.style('-webkit-transform', 'scale(2.5)');
    checkbox1.changed(checkd1);

    checkbox2 = createCheckbox('', false);
    checkbox2.position(700,650);
    checkbox2.style('-webkit-transform', 'scale(2.5)');
    checkbox2.changed(checkd2);

    checkbox3 = createCheckbox('', false);
    checkbox3.position(1140,650);
    checkbox3.style('-webkit-transform', 'scale(2.5)');
    checkbox3.changed(checkd3);

    btnNext = createButton("next");
    btnNext.style('padding','5px');
    btnNext.position(615,730);
    btnNext.style('width', '190px');
    btnNext.style('border-radius', '6px');
    btnNext.mousePressed(nextPressed);

    btnSave = createButton("save");
    btnSave.style('padding','5px');
    btnSave.position(615,730);
    btnSave.style('width', '190px');
    btnSave.style('border-radius', '6px');
    btnSave.hide();
    btnSave.mousePressed(savePressed);
}

function draw(){
    textFont('Georgia');
    background(255);
    noStroke();
    fill(block1);
    rect(80,25,360,500,6);
    fill(block2);
    rect(520,25,360,500,6);
    fill(block3);
    rect(960,25,360,500,6);
    mouseIsOver();
    drawSpecs(80,25,player1,75,70,75,"Mark I");
    drawSpecs(520,25,player1,140,105, 50, "Flash");
    drawSpecs(960,25,player1,35,40,150,"Panzer" );

}

function drawSpecs(x,y,player1,sp,ag,hl,name){
    
    textSize(18);
    fill(56, 56, 56);
    text('Speed:', x+60, y+250);
    text('Agility:', x+60, y+300);
    text('Health:', x+60, y+350);
    fill(181, 181, 181);
    rect(x+150,y+234,150,20);
    rect(x+150,y+284,150,20);
    rect(x+150,y+334,150,20);
    if(player1){ fill(236,66,56); }
    else{ fill(61,149,228); }
    rect(x+150,y+234,sp,20);
    rect(x+150,y+284,ag,20);
    rect(x+150,y+334,hl,20);
    textSize(24);
    text(name, x+145, y+160);
    
    
}
function mouseIsOver(){
    if(!selectState){
    if((mouseX>80&&mouseX<440)&&(mouseY>25&&mouseY<525)){
        block1 = activefill;
    }
    else if((mouseX>520&&mouseX<880)&&(mouseY>25&&mouseY<525)){
        block2 = activefill;
    }
    else if((mouseX>960&&mouseX<1320)&&(mouseY>25&&mouseY<525)){
        block3 = activefill;
    }
    else{block1 = idlefill;block2=idlefill; block3=idlefill;}
    }
}

function mouseClicked() {
    
    if((mouseX>80&&mouseX<440)&&(mouseY>25&&mouseY<525)){
        selected(1);
    }
    else if((mouseX>520&&mouseX<880)&&(mouseY>25&&mouseY<525)){
        selected(2);
    }
    else if((mouseX>960&&mouseX<1320)&&(mouseY>25&&mouseY<525)){
        selected(3);
    }

  }

function checkd1(){
    block1 = activefill; selectState=!selectState;
}
function checkd2(){
    block2 = activefill; selectState=!selectState;
}
function checkd3(){
    block3 = activefill; selectState=!selectState;
}
function selected(ind){
    if(ind==1){
        block1 = activefill; selectState=!selectState;
        checkbox1.checked(false);
        checkbox2.checked(false);
        checkbox3.checked(false);
        if(state){
        checkbox1.checked(true);
        checkbox2.checked(false);
        checkbox3.checked(false);
        } 
        state = !state;
    }
    else if(ind==2){
        block2 = activefill; selectState=!selectState;
        checkbox1.checked(false);
        checkbox2.checked(false);
        checkbox3.checked(false);
        if(state){
        checkbox2.checked(true);
        checkbox1.checked(false);
        checkbox3.checked(false);
        }
        state = !state;
    }
    else if(ind==3){
        block3 = activefill; selectState=!selectState;
        checkbox1.checked(false);
        checkbox2.checked(false);
        checkbox3.checked(false);
        if(state){
        checkbox3.checked(true);
        checkbox1.checked(false);
        checkbox2.checked(false);
        }
        state = !state;
    }
}

function nextPressed(){
    player1=false;
    if(checkbox1.checked()){ tanks.tanks.push(1);}
    else if(checkbox2.checked()){ tanks.tanks.push(2);}
    else if(checkbox3.checked()){ tanks.tanks.push(3);}
    alert("Tank for player1 was selected.");
    turn();
    btnNext.hide();
    btnSave.show();
}

function savePressed(){
    if(checkbox1.checked()){ tanks.tanks.push(1);}
    else if(checkbox2.checked()){ tanks.tanks.push(2);}
    else if(checkbox3.checked()){ tanks.tanks.push(3);}
    alert("Tanks were selected." + "\n" + "Go to your Java app to start playing");
    ws.send(JSON.stringify(tanks));
    window.location.href = "index.html";

}

$(function () {
	ws = new WebSocket("ws://localhost:8025/test");
  
	ws.onopen = function () {
	  // Web Socket is connected, send data using send()
	  console.log("Ready...");
    };
	ws.onclose = function () {
	  // websocket is closed.
	  console.log("Connection is closed...");
	};
  });

  