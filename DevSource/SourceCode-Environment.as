import flash.events.MouseEvent;

mainChar.stop();

var activeBackground: int = 1;
// 1 - Bathroom
// 2 - Stall
// 3 - Office
// 4 - Hallway
// 5 - Horse track
// 6 - Bet room
// 7 - Public

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

var powerIsOn: Boolean = false;
var notesStolen: Boolean = false;

changeBackgroundTo(2); // starts in stall (2)

var catState: String = "super"; // super/dead/alive

actionbubble.gotoAndStop(1);
aidnotesquantum.visible = false;
aidnotesdoctor.visible = false;
aidnotesstolen.visible = false;
aidbtnstolen.visible = false;

function main(e: Event) {
	if (currentFrame != 3){
		return;
	}
	handleWalking();
	handleWaveDisplay();
	handleBackgroundMovement();
	handleQuirks();
	handleActionBubble();
	trace(thebg.x, thebg.y);
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
	} else if (evt0.keyCode == 70) {
		executeActionBubble();
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
	thebg.x -= charXspeed;
	thebg.y -= charYspeed;
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
		wavedisplay.waveobject01.gotoAndStop(3);
		wavedisplay.waveobject02.gotoAndStop(1);
		wavedisplay.waveobject03.gotoAndStop(1);
		wavedisplay.waveobject04.gotoAndStop(1);
	} else if (activeBackground == 3){
		wavedisplay.waveobject01.gotoAndStop(3);
		wavedisplay.waveobject02.gotoAndStop(1);
		wavedisplay.waveobject03.gotoAndStop(1);
		wavedisplay.waveobject04.gotoAndStop(1);
	} else if (activeBackground == 4){
		wavedisplay.waveobject01.gotoAndStop(3);
		wavedisplay.waveobject02.gotoAndStop(1);
		wavedisplay.waveobject03.gotoAndStop(1);
		wavedisplay.waveobject04.gotoAndStop(1);
	} else {
		wavedisplay.waveobject01.gotoAndStop(1);
		wavedisplay.waveobject02.gotoAndStop(1);
		wavedisplay.waveobject03.gotoAndStop(1);
		wavedisplay.waveobject04.gotoAndStop(1);
	}
}

function handleObstaclesX(direction: String){
	if (activeBackground == 1){
		if (thebg.x + charBspeed >= 1200 && direction == "left"){
			return false;
		}
		if (thebg.x - charBspeed <= 800 && direction == "right"){
			return false;
		}
	}
	if (activeBackground == 2){
		if (thebg.x + charBspeed >= 1200 && direction == "left"){
			return false;
		}
		if (thebg.x - charBspeed <= 1100 && direction == "right"){
			return false;
		}
	}
	if (activeBackground == 3){
		if (thebg.x + charBspeed >= 1075 && direction == "left"){
			return false;
		}
		if (thebg.x - charBspeed <= 600 && direction == "right"){
			return false;
		}
	}
	if (activeBackground == 4){
		if (thebg.x + charBspeed >= 4318 && direction == "left"){
			return false;
		}
		if (thebg.x - charBspeed <= -2380 && direction == "right"){
			return false;
		}
	}
	return true;
}
	
function handleObstaclesY(direction: String){
	if (activeBackground == 1){
		if (thebg.y + charBspeed >= 850 && direction == "up"){
			return false;
		}
		if (thebg.y - charBspeed <= 0 && direction == "down"){
			return false;
		}
	}
	if (activeBackground == 2){
		if (thebg.y + charBspeed >= 700 && direction == "up"){
			return false;
		}
		if (thebg.y - charBspeed <= 400 && direction == "down"){
			return false;
		}
	}
	if (activeBackground == 3){
		if (thebg.y + charBspeed >= 750 && direction == "up"){
			return false;
		}
		if (thebg.y - charBspeed <= 300 && direction == "down"){
			return false;
		}
	}
	if (activeBackground == 4){
		if (thebg.y + charBspeed >= 727 && direction == "up"){
			return false;
		}
		if (thebg.y - charBspeed <= 386 && direction == "down"){
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
	if (activeBackground == 4){
		try {
			quirksbg4();
		} catch (e: Error){
			trace("Error in quirk bg04: " + e);
		}
	}
}

function quirksbg1(){
	if (thebg.currentFrame != 1){
		return;
	}
	if (thebg.y < 575){
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
		thebg.bg01.thecat.visible = false;
	} else {
		thebg.bg01.thecat.visible = true;
	}
	if (catState == "alive"){
		thebg.bg01.thecat.gotoAndStop(1);
	}
	if (catState == "dead"){
		thebg.bg01.thecat.gotoAndStop(2);
	}
}

function quirksbg4(){
	if (thebg.currentFrame != 4){
		return;
	}
	if (powerIsOn){
		thebg.bg04.electricpanel.gotoAndStop(1);
	} else {
		thebg.bg04.electricpanel.gotoAndStop(2);
	}
}

function traceFPS(){
	newTime = getTimer();
	if (newTime != oldTime){
		trace(1000 / (newTime - oldTime));
	}
	oldTime = newTime;
}

aidbtndoctor.addEventListener(MouseEvent.CLICK, showAidDoctor);
function showAidDoctor(event: MouseEvent){
	aidnotesdoctor.visible = true;
	if (aidnotesquantum.visible){
		aidnotesquantum.visible = false;
	}
	if (aidnotesstolen.visible){
		aidnotesstolen.visible = false;
	}
}

aidbtnquantum.addEventListener(MouseEvent.CLICK, showAidQuantum);
function showAidQuantum(event: MouseEvent){
	aidnotesquantum.visible = true;
	if (aidnotesdoctor.visible){
		aidnotesdoctor.visible = false;
	}
	if (aidnotesstolen.visible){
		aidnotesstolen.visible = false;
	}
}

aidbtnstolen.addEventListener(MouseEvent.CLICK, showAidStolen);
function showAidStolen(event: MouseEvent){
	aidnotesstolen.visible = true;
	if (aidnotesdoctor.visible){
		aidnotesdoctor.visible = false;
	}
	if (aidnotesquantum.visible){
		aidnotesquantum.visible = false;
	}
}

function changeBackgroundTo(newBackground: int){
	var oldBackground: int = activeBackground;
	thebg.gotoAndStop(newBackground);
	activeBackground = newBackground;
	actionbubble.gotoAndStop(1);
	mainChar.gotoAndStop(1);
	mainChar.guyinside.gotoAndPlay(1);
	if (newBackground == 1){
		thebg.x = 1000;
		thebg.y = 500;
		thebg.width = 5000;
		thebg.height = 5000;
		mainChar.width = 250;
		mainChar.height = 500;
		charBspeed = 25;
	}
	if (newBackground == 2){
		thebg.x = 1175;
		thebg.y = 550;
		mainChar.width = 300;
		mainChar.height = 600;
		thebg.width = 2800;
		thebg.height = 2800;
		charBspeed = 25;
	}
	if (newBackground == 3){
		thebg.x = 775;
		thebg.y = 375;
		thebg.width = 3000;
		thebg.height = 3000;
		mainChar.width = 200;
		mainChar.height = 400;
		charBspeed = 20;
		thebg.bg03.stealableNotes.visible = !notesStolen;
	}
	if (newBackground == 4){
		thebg.width = 11000;
		thebg.height = 11000;
		mainChar.width = 80;
		mainChar.height = 160;
		charBspeed = 11;
		if (oldBackground == 1){ // from bathroom
			thebg.x = 2250;
			thebg.y = 650;
		}
		if (oldBackground == 3){ // from office
			thebg.x = 952;
			thebg.y = 551;
		}
		if (oldBackground == 5){ // from racetrack
			thebg.x = 4153;
			thebg.y = 573;
		}
		if (oldBackground == 6){ // from bet room
			thebg.x = -2205;
			thebg.y = 573;
		}
	}
}

function handleActionBubble(){
	if (activeBackground == 1){
		actionbubble.gotoAndStop(1);
		if (thebg.x >= 825 && thebg.x <= 925 && thebg.y >= 475 && thebg.y <= 750){
			actionbubble.gotoAndStop(2);
		}
		if (thebg.y <= 150){
			actionbubble.gotoAndStop(4);
		}
	}
	if (activeBackground == 2){
		actionbubble.gotoAndStop(3);
	}
	if (activeBackground == 3){
		actionbubble.gotoAndStop(1);
		if (thebg.x <= 675 && thebg.y <= 600){
			actionbubble.gotoAndStop(7);
		}
		if (thebg.x <= 750 && thebg.y >= 675 && notesStolen == false){
			actionbubble.gotoAndStop(8);
		}
		if (thebg.x >= 1025 && thebg.y <= 450){
			actionbubble.gotoAndStop(9);
		}
		if (thebg.x <= 1025 && thebg.x >= 900 && thebg.y >= 725 && powerIsOn){
			actionbubble.gotoAndStop(10);
		}
	}
	if (activeBackground == 4){
		actionbubble.gotoAndStop(1);
		if (thebg.x >= 2129 && thebg.x <= 2360 && thebg.y >= 670){
			actionbubble.gotoAndStop(5);
		}
		if (thebg.x >= 864 && thebg.x <= 1062 && thebg.y <= 485){
			actionbubble.gotoAndStop(6);
		}
		if (thebg.x <= -2238){
			actionbubble.gotoAndStop(14);
		}
		if (thebg.x >= 4200 && powerIsOn){
			actionbubble.gotoAndStop(13);
		}
		if (thebg.x >= 3955 && thebg.x <= 4040 && thebg.y >= 628){
			if (powerIsOn){
				actionbubble.gotoAndStop(11);
			} else {
				actionbubble.gotoAndStop(12);
			}
		}
	}
}

function executeActionBubble(){
	if (currentFrame != 3){
		return;
	}
	if (actionbubble.currentFrame == 1){
		1;
	}
	if (actionbubble.currentFrame == 2){
		changeBackgroundTo(2);
	}
	if (actionbubble.currentFrame == 3){
		changeBackgroundTo(1);
	}
	if (actionbubble.currentFrame == 4){
		changeBackgroundTo(4);
	}
	if (actionbubble.currentFrame == 5){
		changeBackgroundTo(1);
	}
	if (actionbubble.currentFrame == 6){
		changeBackgroundTo(3);
	}
	if (actionbubble.currentFrame == 7){
		changeBackgroundTo(4);
	}
	if (actionbubble.currentFrame == 8 && notesStolen == false){
		notesStolen = true;
		aidbtnstolen.visible = true;
		if (thebg.currentFrame == 3){
			thebg.bg03.stealableNotes.visible = false;
		}
	}
	if (actionbubble.currentFrame == 11){
		powerIsOn = false;
	}
	if (actionbubble.currentFrame == 12){
		powerIsOn = true;
	}
}