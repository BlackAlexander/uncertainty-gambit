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
// 8 - Easter Egg

var keyLeftDown: Boolean = false;
var keyRightDown: Boolean = false;
var keyUpDown: Boolean = false;
var keyDownDown: Boolean = false;
var keyTurnLeft: Boolean = false;
var keyTurnRight: Boolean = false;

var charXspeed: Number = 0;
var charYspeed: Number = 0;
var charBspeed: Number = 25; //actual speed
var charDirection: String = "left"; //left or right

var oldTime = 0;
var newTime = 0;
var localTime: int = 0;
var gameStartTime: int = getTimer();

var powerIsOn: Boolean = false;
var notesStolen: Boolean = false;
var walkieStolen: Boolean = false;
var walkieConnected: Boolean = false;
var systemsHacked: Boolean = false;

changeBackgroundTo(8); // starts in stall (2)

var catState: String = "super"; // super/dead/alive
var winnerHorse: int = 0; // 0 means we don't know who won
var endState: int = 0;
var keyPosition: int = 0;
// 0 - nothing yet
// 1 - pressed exit
// 2 - left building
// 3 - rightfully won
// 4 - won but didn't disable security
// 5 - lost, bet on wrong horse
// 6 - race track uncovered with player on it
// 7 - didn't place bet on time

actionbubble.gotoAndStop(1);
aidnotesquantum.visible = false;
aidnotesdoctor.visible = false;
aidnotesstolen.visible = false;
aidbtnstolen.visible = false;
thewatch.visible = false;
watchshowbtn.visible = true;
theentrypanel.visible = false;
thewalkie.visible = false;
walkiebtn.visible = false;
betpanel.visible = false;
theendtween.gotoAndStop(1);
theendtween.visible = false;
theendbox.visible = false;
thehelpmenu.visible = false;
fullitemlock.visible = false;

function main(e: Event) {
	if (currentFrame != 3) return;
	localTime = getTimer() - gameStartTime;
	handleWalking();
	handleWaveDisplay();
	handleBackgroundMovement();
	handleQuirks();
	handleActionBubble();
	handleTimeDisplay();
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
	} else if (evt0.keyCode == 81) {
		toggleFullScreen();
	} else if (evt0.keyCode == 27) {
		executeExit();
		evt0.preventDefault();
	} else if (evt0.keyCode == 82) {
		keyTurnLeft = true;
	} else if (evt0.keyCode == 84) {
		keyTurnRight = true;
	} else if (evt0.keyCode == 75) {
		spinTheLock();
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
	} else if (evt00.keyCode == 82) {
		keyTurnLeft = false;
	} else if (evt00.keyCode == 84) {
		keyTurnRight = false;
	}
}

function toggleFullScreen(){
	if (stage.displayState == StageDisplayState.NORMAL){
		stage.displayState = StageDisplayState.FULL_SCREEN_INTERACTIVE;
	} else if (stage.displayState == StageDisplayState.FULL_SCREEN_INTERACTIVE){
		stage.displayState = StageDisplayState.NORMAL;
	}
}

function executeExit(){
	if (currentFrame == 4){
		proceed();
	} else if (currentFrame == 5){
		gotoAndStop(1);
	}
}

function handleWalking(){
	if (currentFrame != 3) return;
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
	if (currentFrame != 3) return;
	thebg.x -= charXspeed;
	thebg.y -= charYspeed;
}


function handleWaveDisplay(){
	if (currentFrame != 3) return;
	// 1 - wave   |  2 - cat
	// 3 - human  |  4 - walkie
	// 5 - world  |  6 - horse
	if (endState == 2 || endState == 6){
		wavedisplay.waveobject01.gotoAndStop(5);
		wavedisplay.waveobject02.gotoAndStop(1);
		wavedisplay.waveobject03.gotoAndStop(1);
		wavedisplay.waveobject04.gotoAndStop(1);
		return;
	}
	wavedisplay.waveobject01.gotoAndStop(3);
	if (activeBackground == 1){
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
		if (walkieConnected){
			wavedisplay.waveobject03.gotoAndStop(4);
			wavedisplay.waveobject04.gotoAndStop(6);
			wavedisplay.waveobject04.insidehorse.gotoAndStop(winnerHorse);
			if (winnerHorse == 0) wavedisplay.waveobject04.insidehorse.gotoAndStop(15);
		} else {
			wavedisplay.waveobject03.gotoAndStop(1);
			wavedisplay.waveobject04.gotoAndStop(1);
		}
	} else if (activeBackground == 2){
		wavedisplay.waveobject02.gotoAndStop(1);
		if (walkieConnected){
			wavedisplay.waveobject03.gotoAndStop(4);
			wavedisplay.waveobject04.gotoAndStop(6);
			wavedisplay.waveobject04.insidehorse.gotoAndStop(winnerHorse);
			if (winnerHorse == 0) wavedisplay.waveobject04.insidehorse.gotoAndStop(15);
		} else {
			wavedisplay.waveobject03.gotoAndStop(1);
			wavedisplay.waveobject04.gotoAndStop(1);
		}
	} else if (activeBackground == 3){
		wavedisplay.waveobject02.gotoAndStop(1);
		if (walkieConnected){
			wavedisplay.waveobject03.gotoAndStop(4);
			wavedisplay.waveobject04.gotoAndStop(6);
			wavedisplay.waveobject04.insidehorse.gotoAndStop(winnerHorse);
			if (winnerHorse == 0) wavedisplay.waveobject04.insidehorse.gotoAndStop(15);
		} else {
			wavedisplay.waveobject03.gotoAndStop(1);
			wavedisplay.waveobject04.gotoAndStop(1);
		}
	} else if (activeBackground == 4){
		wavedisplay.waveobject02.gotoAndStop(1);
		if (walkieConnected){
			wavedisplay.waveobject03.gotoAndStop(4);
			wavedisplay.waveobject04.gotoAndStop(6);
			wavedisplay.waveobject04.insidehorse.gotoAndStop(winnerHorse);
			if (winnerHorse == 0) wavedisplay.waveobject04.insidehorse.gotoAndStop(15);
		} else {
			wavedisplay.waveobject03.gotoAndStop(1);
			wavedisplay.waveobject04.gotoAndStop(1);
		}
	} else if (activeBackground == 5){
		wavedisplay.waveobject02.gotoAndStop(1);
		if (walkieConnected) {
			wavedisplay.waveobject03.gotoAndStop(4);
		} else {
			wavedisplay.waveobject03.gotoAndStop(1);
		}
		wavedisplay.waveobject04.gotoAndStop(6);
		wavedisplay.waveobject04.insidehorse.gotoAndStop(winnerHorse);
		if (winnerHorse == 0) wavedisplay.waveobject04.insidehorse.gotoAndStop(15);
		if (walkieConnected) {
			wavedisplay.waveobject03.gotoAndStop(4);
		} else {
			wavedisplay.waveobject03.gotoAndStop(1);
		}
	} else if (activeBackground == 6 || activeBackground == 8){
		wavedisplay.waveobject02.gotoAndStop(1);
		if (walkieConnected){
			wavedisplay.waveobject03.gotoAndStop(4);
			wavedisplay.waveobject04.gotoAndStop(6);
			wavedisplay.waveobject04.insidehorse.gotoAndStop(winnerHorse);
			if (winnerHorse == 0) wavedisplay.waveobject04.insidehorse.gotoAndStop(15);
		} else {
			wavedisplay.waveobject03.gotoAndStop(1);
			wavedisplay.waveobject04.gotoAndStop(1);
		}
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
	if (activeBackground == 5){
		if (thebg.x + charBspeed >= 1200 && direction == "left"){
			return false;
		}
		if (thebg.x - charBspeed <= 1000 && direction == "right" && thebg.y >= 610){
			return false;
		}
		if (thebg.x - charBspeed <= 965 && direction == "right" && thebg.y < 610){
			return false;
		}
		if (thebg.x - charBspeed >= 1000 && direction == "left" && thebg.y <= 502){
			return false;
		}
	}
	if (activeBackground == 6){
		if (thebg.x + charBspeed >= 2000 && direction == "left"){
			return false;
		}
		if (thebg.x - charBspeed <= 595 && direction == "right"){
			return false;
		}
	}
	if (activeBackground == 8){
		if (thebg.x + charBspeed >= 1200 && direction == "left"){
			return false;
		}
		if (thebg.x - charBspeed <= 800 && direction == "right"){
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
	if (activeBackground == 5){
		if (thebg.y + charBspeed >= 2950 && direction == "up"){
			return false;
		}
		if (thebg.y + charBspeed >= 610 && direction == "up" && thebg.x <= 990){
			return false;
		}
		if (thebg.y - charBspeed <= 124 && direction == "down"){
			return false;
		}
		if (thebg.y - charBspeed <= 502 && direction == "down" && thebg.x >= 1030){
			return false;
		}
	}
	if (activeBackground == 6){
		if (thebg.y + charBspeed >= 535 && direction == "up"){
			return false;
		}
		if (thebg.y - charBspeed <= 300 && direction == "down"){
			return false;
		}
	}
	if (activeBackground == 8){
		if (thebg.y + charBspeed >= 850 && direction == "up"){
			return false;
		}
		if (thebg.y - charBspeed <= 0 && direction == "down"){
			return false;
		}
	}
	return true;
}

function handleQuirks(){
	if (currentFrame != 3) return;
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
	if (activeBackground == 5){
		try {
			quirksbg5();
		} catch (e: Error){
			trace("Error in quirk bg05: " + e);
		}
	}
	if (activeBackground == 6){
		try {
			quirksbg6();
		} catch (e: Error){
			trace("Error in quirk bg06: " + e);
		}
	}
	if (activeBackground == 8){
		try {
			quirksbg8();
		} catch (e: Error){
			trace("Error in quirk bg08: " + e);
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
	if (thebg.x < 4200){
		theentrypanel.visible = false;
	}
}

function quirksbg5(){
	if (thebg.currentFrame != 5){
		return;
	}
	if (thebg.y >= 2600){
		thebg.y = thebg.y - 900;
	}

	var time: int = localTime;
	if (time > 420000 && endState != 6){ // 420000
		happenEnding(6);
	} else if (time > 125000 && thebg.bg05.currentFrame == 1){ // 125000
		winnerHorse = Math.floor(Math.random() * 14) + 1;
		thebg.bg05.gotoAndPlay(2);
		thebg.bg05.thehorse.horsepanel.winnernumber.text = String(winnerHorse);
	}
}

function quirksbg6(){
	if (thebg.currentFrame != 6){
		return;
	}
	if (thebg.x > 900){
		betpanel.visible = false;
	}
}

function quirksbg8(){
	if (thebg.currentFrame != 8){
		return;
	}
	if (thebg.y <= 150){
		fullitemlock.visible = false;
	}
	if (fullitemlock.visible){
		if(keyTurnLeft){
			if (fullitemlock.picktoolitem.currentFrame > 1){
				fullitemlock.picktoolitem.gotoAndStop(fullitemlock.picktoolitem.currentFrame - 1);
				if (fullitemlock.picktoolitem.currentFrame == keyPosition){
					fullitemlock.spininside.gotoAndPlay(51);
				}
			}
		}
		if(keyTurnRight){
			if (fullitemlock.picktoolitem.currentFrame < 30){
				fullitemlock.picktoolitem.gotoAndStop(fullitemlock.picktoolitem.currentFrame + 1);
				if (fullitemlock.picktoolitem.currentFrame == keyPosition){
					fullitemlock.spininside.gotoAndPlay(51);
				}
			}
		}
	}
}

function spinTheLock(){
	if (thebg.currentFrame != 8){
		return;
	}
	if (fullitemlock.visible == false){
		return;
	}
	if (fullitemlock.picktoolitem.currentFrame == keyPosition){
		fullitemlock.spininside.gotoAndPlay(20);
	} else {
		fullitemlock.spininside.gotoAndPlay(2);
	}
}

function traceFPS(){
	newTime = localTime;
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
	if (thewatch.visible){
		thewatch.visible = false;
		watchshowbtn.visible = true;
	}
	if (thehelpmenu.visible){
		thehelpmenu.visible = false;
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
	if (thewatch.visible){
		thewatch.visible = false;
		watchshowbtn.visible = true;
	}
	if (thehelpmenu.visible){
		thehelpmenu.visible = false;
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
	if (thewatch.visible){
		thewatch.visible = false;
		watchshowbtn.visible = true;
	}
	if (thehelpmenu.visible){
		thehelpmenu.visible = false;
	}
	if (thehelpmenu.visible){
		thehelpmenu.visible = false;
	}
}

thehelpbtn.addEventListener(MouseEvent.CLICK, showHelpMenu);
function showHelpMenu(event: MouseEvent){
	thehelpmenu.visible = true;
	thehelpmenu.gotoAndStop(1);
	thehelpmenu.hintstext.text = "";
	if (aidnotesdoctor.visible){
		aidnotesdoctor.visible = false;
	}
	if (aidnotesquantum.visible){
		aidnotesquantum.visible = false;
	}
	if (aidnotesstolen.visible){
		aidnotesstolen.visible = false;
	}
	if (thewatch.visible){
		thewatch.visible = false;
		watchshowbtn.visible = true;
	}
}

watchshowbtn.addEventListener(MouseEvent.CLICK, showthewatch);
function showthewatch(event: MouseEvent){
	thewatch.visible = true;
	watchshowbtn.visible = false;
	if (aidnotesdoctor.visible){
		aidnotesdoctor.visible = false;
	}
	if (aidnotesquantum.visible){
		aidnotesquantum.visible = false;
	}
	if (aidnotesstolen.visible){
		aidnotesstolen.visible = false;
	}
	if (thehelpmenu.visible){
		thehelpmenu.visible = false;
	}
}
walkiebtn.addEventListener(MouseEvent.CLICK, enablewalkie);
function enablewalkie(event: MouseEvent){
	thewalkie.visible = true;
	thewalkie.gotoAndPlay(1);
	thewalkie.walkiewaves.visible = walkieConnected;
}
thewalkie.buttonMode = true;
thewalkie.addEventListener(MouseEvent.CLICK, enablewalkie);
function endWalkiePressed(){
	thewalkie.gotoAndStop(1);
	thewalkie.visible = false;
	walkieConnected = false;
	if (activeBackground != 5){
		winnerHorse = 0;
	}
}

function changeBackgroundTo(newBackground: int){
	var oldBackground: int = activeBackground;
	thebg.gotoAndStop(newBackground);
	activeBackground = newBackground;
	actionbubble.gotoAndStop(1);
	mainChar.gotoAndStop(1);
	mainChar.guyinside.gotoAndPlay(1);
	mainChar.x = 980;
	mainChar.y = 550;
	if (thehelpmenu.visible){
		thehelpmenu.visible = false;
	}
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
		thebg.bg03.stealableWalkie.visible = !walkieStolen;
	}
	if (newBackground == 4){
		thebg.width = 11000;
		thebg.height = 11000;
		mainChar.width = 80;
		mainChar.height = 160;
		charBspeed = 22;
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
		if (!walkieConnected){
			winnerHorse = 0;
		}
	}
	if (newBackground == 5){
		thebg.x = 1074;
		thebg.y = 538;
		thebg.width = 6000;
		thebg.height = 6000;
		mainChar.width = 100;
		mainChar.height = 200;
		mainChar.x = 1480;
		mainChar.y = 550;
		charBspeed = 18;
		if (thebg.currentFrame == 5){
			var time: int = localTime;
			if (time < 125000){ // enter before race, nothing
				thebg.bg05.gotoAndStop(1);
			} else if (time < 240000){ // enter during race, see horse run
				thebg.bg05.gotoAndPlay(2);
				if (winnerHorse == 0){
					winnerHorse = Math.floor(Math.random() * 14) + 1;
				} else {
					thebg.bg05.gotoAndStop(120);
				}
				thebg.bg05.thehorse.horsepanel.winnernumber.text = String(winnerHorse);
			} else if (time < 420000){ // enter after race, see horse stay
				thebg.bg05.gotoAndStop(120);
				if (winnerHorse == 0) winnerHorse = Math.floor(Math.random() * 14) + 1;
				thebg.bg05.thehorse.horsepanel.winnernumber.text = String(winnerHorse);
			} else {
				//lose because u entered track uncovered
			}
		}
	}
	if (newBackground == 6){
		thebg.x = 1315;
		thebg.y = 355;
		thebg.width = 6000;
		thebg.height = 6000;
		mainChar.width = 250;
		mainChar.height = 500;
		charBspeed = 20;
	}
	if (newBackground == 8){
		thebg.x = 1000;
		thebg.y = 500;
		thebg.width = 5000;
		thebg.height = 5000;
		mainChar.width = 250;
		mainChar.height = 500;
		charBspeed = 25;
	}
}

function handleActionBubble(){
	if (currentFrame != 3) return;
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
		if (thebg.x >= 1025 && thebg.y <= 450 && walkieStolen == false){
			actionbubble.gotoAndStop(9);
		}
		if (thebg.x <= 1025 && thebg.x >= 900 && thebg.y >= 725 && powerIsOn && !systemsHacked){
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
	if (activeBackground == 5){
		actionbubble.gotoAndStop(1);
		if (thebg.x <= 1038 && thebg.y <= 934 && thebg.y >= 664){
			actionbubble.gotoAndStop(15);
		}
		if (thebg.y <= 400 && walkieStolen && !walkieConnected){
			actionbubble.gotoAndStop(16);
		}
	}
	if (activeBackground == 6){
		actionbubble.gotoAndStop(1);
		if(thebg.x >= 1200 && thebg.x <= 1650 && thebg.y >= 480){
			actionbubble.gotoAndStop(17);
		}
		if (thebg.x <= 800 && thebg.y <= 600){
			actionbubble.gotoAndStop(18);
		}
		if (thebg.x >= 1800){
			actionbubble.gotoAndStop(19);
		}
	}
	if (activeBackground == 8){
		actionbubble.gotoAndStop(1);
		if(thebg.y >= 575){
			actionbubble.gotoAndStop(20);
		}
	}
}

function executeActionBubble(){
	if (currentFrame != 3) return;
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
	if (actionbubble.currentFrame == 9 && walkieStolen == false){
		walkieStolen = true;
		walkiebtn.visible = true;
		if (thebg.currentFrame == 3){
			thebg.bg03.stealableWalkie.visible = false;
		}
	}
	if (actionbubble.currentFrame == 10 && !systemsHacked){
		systemsHacked = true;
	}
	if (actionbubble.currentFrame == 11){
		powerIsOn = false;
	}
	if (actionbubble.currentFrame == 12){
		powerIsOn = true;
	}
	if (actionbubble.currentFrame == 13){
		theentrypanel.visible = true;
	}
	if (actionbubble.currentFrame == 14){
		changeBackgroundTo(6);
	}
	if (actionbubble.currentFrame == 15){
		changeBackgroundTo(4);
	}
	if (actionbubble.currentFrame == 16){
		walkieConnected = true;
		thewalkie.visible = true;
		thewalkie.gotoAndPlay(1);
		thewalkie.walkiewaves.visible = walkieConnected;
	}
	if (actionbubble.currentFrame == 17){
		changeBackgroundTo(4);
	}
	if (actionbubble.currentFrame == 18){
		if (localTime > 420000){ //420000
			happenEnding(7);
		} else {
			betpanel.visible = true;
			betpanel.setOdds();
		}
	}
	if (actionbubble.currentFrame == 19){
		happenEnding(2);
	}
	if (actionbubble.currentFrame == 20){
		fullitemlock.visible = true;
		fullitemlock.picktoolitem.gotoAndStop(1);
		fullitemlock.spininside.gotoAndStop(1);
		keyPosition = Math.floor(Math.random() * 20) + 5
	}
}

function handleHelpMenu(){
	thehelpmenu.hintstext.text = "";
	thehelpmenu.gotoAndStop(1);
	if (activeBackground == 1){ // bathroom
		thehelpmenu.gotoAndStop(3);
		thehelpmenu.hintstext.text = "The bathroom you're in is a good place to isolate yourself from the world at a quantum level. However, there's nothing much to do here. You should leave, the exit door is down.";
	}
	if (activeBackground == 2){ // stall
		thehelpmenu.gotoAndStop(2);
		thehelpmenu.hintstext.text = "You are in an enclosed bathroom stall. There's nothing to do here. You should exit.";
	}
	if (activeBackground == 3){ // office
		thehelpmenu.gotoAndStop(4);
		var hintStringOffice: String = "";
		var allDone: Boolean = true;
		if (notesStolen == false){
			hintStringOffice += "- Steal the guard's notes from the upper right part.\n";
			allDone = false;
		}
		if (walkieStolen == false){
			hintStringOffice += "- Steal the walkie talkie from the desk on the left.\n";
			allDone = false;
		}
		if (systemsHacked == false && powerIsOn == false){
			hintStringOffice += "- Turn on the power from the hallway and come back to hack the CCTV from the laptop.\n";
			allDone = false;
		}
		if (systemsHacked == false && powerIsOn == true){
			hintStringOffice += "- Hack the systems and disable the CCTV. Do this from the laptop on the upper side.";
		}
		if (allDone){
			hintStringOffice = "There's nothing left to do here. Good job. Now go to the race track.";
		}
		thehelpmenu.hintstext.text = hintStringOffice;
	}
	if (activeBackground == 4){ // hallway
		thehelpmenu.gotoAndStop(5);
		var hintStringHallway: String = "";
		if (powerIsOn == false){
			hintStringHallway += "Go to the left and turn on the power. The switch is on the upper part. A green light should appear.\n";
		} else {
			if (!systemsHacked || !walkieStolen || !notesStolen){
				hintStringHallway += "Go to the office. You can find it on the lower side, vis-a-vis the bathroom entrance, around the middle of the hallway.\n";
				if (!systemsHacked){
					hintStringHallway += "You still have to hack the systems and disable the CCTV.\n";
				}
				if (!walkieStolen){
					hintStringHallway += "You still have to steal the walkie talkie.\n";
				}
				if (!notesStolen){
					hintStringHallway += "You still have to steal the notes.\n";
				}
			} else {
				if (winnerHorse == 0){
					hintStringHallway += "Go to the race track to see which horse won.\n";
					hintStringHallway += "The entrance is on the left.\n";
					hintStringHallway += "The colors from the password can be found on the first page of the stolen notes, in the lower right part.\n";
					hintStringHallway += "The code is red, blue, green, red, purple, yellow.\n";
				} else {
					hintStringHallway += "Keep the radio station connected by clicking it!\n";
					hintStringHallway += "Don't stop! Otherwise, the horse will fall into superposition again.\n";
					hintStringHallway += "Go to the betting room. The door is on the right side of the hallway.\n";
				}
			}
		}
		thehelpmenu.hintstext.text = hintStringHallway;
	}
	if (activeBackground == 5){ // track
		thehelpmenu.gotoAndStop(6);
		var hintStringTrack: String = "";
		if (winnerHorse == 0){
			hintStringTrack += "Wait to see which horse wins. The race starts at 12:10.\n";
		} else {
			if (!walkieStolen){
				hintStringTrack += "Go to the office and steal the radio.\n";
			} else {
				hintStringTrack += "See which horse won.\n";
				hintStringTrack += "Go to the desk from the lower part. Connect the radio with the one you stole.\n";
				hintStringTrack += "Keep clicking on the radio station. Don't stop. \n";
				hintStringTrack += "Leave the track and go to the betting room. \n";
				hintStringTrack += "The betting room is on the rightmost part of the hallway.\n";
				hintStringTrack += "Don't stop clicking on the station.\n"
			}
		}
		hintStringTrack += "Leave the track before 12:15\n";
		thehelpmenu.hintstext.text = hintStringTrack;
	}
	if (activeBackground == 6){ // betroom
		var hintStringBet: String = "";
		if (winnerHorse == 0){
			hintStringBet += "Find out which horse won. Go back.\n";
		} else {
			if (!systemsHacked){
				hintStringBet += "You didn't disable the CCTV. Proceed with caution.\n";
			} else {
				hintStringBet += "Place a bet on the winning horse.\n";
			}
		}
		thehelpmenu.hintstext.text = hintStringBet;
		thehelpmenu.gotoAndStop(7);
	}
	if (activeBackground == 8){ // easter egg
		thehelpmenu.gotoAndStop(9);
		thehelpmenu.hintstext.text = "Congratulations on finding the secret room! Enjoy.\n";
	}
}

function handleTimeDisplay(){
	if (currentFrame != 3 || thewatch.visible == false){
		return;
	}
	var currentTime: int = localTime;
	var numberOfSeconds: int;
	var numberOfMinutes: int;
	numberOfSeconds = currentTime / 1000;
	numberOfMinutes = numberOfSeconds / 60;
	numberOfMinutes += 8;
	numberOfSeconds = numberOfSeconds % 60;
	thewatch.watchtimehour.text = "12:" + String(numberOfMinutes);
	thewatch.watchtimeseconds.text = String(numberOfSeconds);
	if (numberOfMinutes < 10){
		thewatch.watchtimehour.text = "12:0" + String(numberOfMinutes);
	}
	if (numberOfSeconds < 10){
		thewatch.watchtimeseconds.text = "0" + String(numberOfSeconds);
	}
}

leavegamebtn.addEventListener(MouseEvent.CLICK, showleavebox);
function showleavebox(event:MouseEvent){
	theendbox.visible = true;
}

function betwasplaced(chosenHorse: int){
	if (chosenHorse == 0){
		return;
	}
	if (chosenHorse == winnerHorse && systemsHacked){
		happenEnding(3);
		return;
	}
	if (chosenHorse == winnerHorse && !systemsHacked){
		happenEnding(4);
		return;
	}
	if (chosenHorse != winnerHorse){
		happenEnding(5);
		return;
	}
}

function happenEnding(thecase: int){
	endState = thecase;
	theendtween.gotoAndStop(1);
	theendtween.visible = true;
	if (thecase == 2 || thecase == 6){
		theendtween.gotoAndPlay(92);
	} else {
		theendtween.gotoAndPlay(2);
	}
}

function triggerEnding(){
	gotoAndStop(4);
}





