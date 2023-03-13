mainChar.stop();

var activeBackground: int = 1;
// 1 - Bathroom
// 2 - Stall
// 3 - Hallway
// 4 - Horse track
// 5 - Bet room
// 6 - Public

var keyLeftDown: Boolean = false;
var keyRightDown: Boolean = false;
var keyUpDown: Boolean = false;
var keyDownDown: Boolean = false;

var charXspeed: Number = 0;
var charYspeed: Number = 0;
var charBspeed: Number = 25; //actual speed
var charDirection: String = "left"; //left or right

var oldTime = 0;
var newTime = 0;

var catState: String = "super"; // super/dead/alive


function main(e: Event) {
	handleWalking();
	handleWaveDisplay();
	handleBackgroundMovement();
	handleQuirks();
}

stage.addEventListener(Event.ENTER_FRAME, main);

stage.addEventListener(KeyboardEvent.KEY_DOWN, pressMultipleKeys);
function pressMultipleKeys(evt0: KeyboardEvent) {
	if (evt0.keyCode == 87 || evt0.keyCode == 38) {
		keyUpDown = true;
	} else if (evt0.keyCode == 65 || evt0.keyCode == 37) {
		keyLeftDown = true;
	} else if (evt0.keyCode == 68 || evt0.keyCode == 39) {
		keyRightDown = true;
	} else if (evt0.keyCode == 83 || evt0.keyCode == 40) {
		keyDownDown = true;
	}
}

stage.addEventListener(KeyboardEvent.KEY_UP, pressTakeKeys);
function pressTakeKeys(evt00: KeyboardEvent) {
	if (evt00.keyCode == 87 || evt00.keyCode == 38) {
		keyUpDown = false;
	} else if (evt00.keyCode == 65 || evt00.keyCode == 37) {
		keyLeftDown = false;
	} else if (evt00.keyCode == 68 || evt00.keyCode == 39) {
		keyRightDown = false;
	} else if (evt00.keyCode == 83 || evt00.keyCode == 40) {
		keyDownDown = false;
	}
}

function handleWalking(){
	if (keyLeftDown && handleObstaclesX("left")){
		charXspeed = charBspeed * (-1);
		charDirection = "left";
	} else if (keyRightDown && handleObstaclesX("right")){
		charXspeed = charBspeed;
		charDirection = "right";
	} else {
		charXspeed = 0;
	}

	if (keyUpDown && handleObstaclesY("up")){
		charYspeed = charBspeed * (-1);
	} else if (keyDownDown && handleObstaclesY("down")){
		charYspeed = charBspeed;
	} else {
		charYspeed = 0;
	}

	if (charXspeed > 0){
		mainChar.gotoAndStop(4); // walk to right
	} else if (charXspeed < 0){
		mainChar.gotoAndStop(2); // walk to left
	} else {
		if (charDirection == "left"){
			if (charYspeed == 0) {
				mainChar.gotoAndStop(1);
			} else {
				mainChar.gotoAndStop(2);
			}
		} else {
			if (charYspeed == 0) {
				mainChar.gotoAndStop(3);
			} else {
				mainChar.gotoAndStop(4);
			}
		}
	}
}

function handleBackgroundMovement(){
	if (activeBackground == 1){
		bg01.x -= charXspeed;
		bg01.y -= charYspeed;
	}
}


function handleWaveDisplay(){
	// 1 - wave   |  2 - cat
	// 3 - human  |  4 - walkie
	// 5 - world  |  6 - horse
	if (activeBackground == 1){
		wavedisplay.waveobject01.gotoAndStop(3);
		wavedisplay.waveobject03.gotoAndStop(1);
		wavedisplay.waveobject04.gotoAndStop(1);
		if (catState == "super") {
			wavedisplay.waveobject02.gotoAndStop(1);
		} else {
			wavedisplay.waveobject02.gotoAndStop(2);
			if (catState == "alive"){
				wavedisplay.waveobject02.catobj.gotoAndStop(1);
			}
			if (catState == "dead"){
				wavedisplay.waveobject02.catobj.gotoAndStop(2);
			}
		}
	} else if (activeBackground == 2){
		1;
	} else {
		wavedisplay.waveobject01.gotoAndStop(1);
		wavedisplay.waveobject02.gotoAndStop(1);
		wavedisplay.waveobject03.gotoAndStop(1);
		wavedisplay.waveobject04.gotoAndStop(1);
	}
}

function handleObstaclesX(direction: String){
	if (activeBackground == 1){
		if (bg01.x + charBspeed >= 1200 && direction == "left"){
			return false;
		}
		if (bg01.x - charBspeed <= 800 && direction == "right"){
			return false;
		}
	}
	return true;
}
	
function handleObstaclesY(direction: String){
	if (activeBackground == 1){
		if (bg01.y + charBspeed >= 850 && direction == "up"){
			return false;
		}
		if (bg01.y - charBspeed <= 0 && direction == "down"){
			return false;
		}
	}
	return true;
}

function handleQuirks(){
	if (activeBackground == 1){
		try {
			quirksbg1();
		} catch (e: Error){
			trace("Error in quirk bg01: " + e);
		}
	}
}

function quirksbg1(){
	if (bg01.y < 575){
		catState = "super";
	} else {
		if (catState == "super"){ // then wave function collapses
			var randomState: int;
			randomState = Math.floor(Math.random() * 2);
			if (randomState){
				catState = "alive";
			} else {
				catState = "dead";
			}
		}
	}
	if (catState == "super"){
		bg01.thecat.visible = false;
	} else {
		bg01.thecat.visible = true;
	}
	if (catState == "alive"){
		bg01.thecat.gotoAndStop(1);
	}
	if (catState == "dead"){
		bg01.thecat.gotoAndStop(2);
	}
}

function traceFPS(){
	newTime = getTimer();
	if (newTime != oldTime){
		trace(1000 / (newTime - oldTime));
	}
	oldTime = newTime;
}