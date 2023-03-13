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

bg01.gotoAndStop(1);

function main(e: Event) {
	handleWalking();
	handleWaveDisplay();
	handleBackgroundMovement();
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

	trace(bg01.x, bg01.y);

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
	wavedisplay.waveobject01.gotoAndStop(3);
	wavedisplay.waveobject02.gotoAndStop(2);
	wavedisplay.waveobject03.gotoAndStop(6);
	wavedisplay.waveobject04.gotoAndStop(1);
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

function traceFPS(){
	newTime = getTimer();
	if (newTime != oldTime){
		trace(1000 / (newTime - oldTime));
	}
	oldTime = newTime;
}