mainChar.stop();

var keyLeftDown: Boolean = false;
var keyRightDown: Boolean = false;
var keyUpDown: Boolean = false;
var keyDownDown: Boolean = false;

function main(e: Event) {
	handleWalkAnimation();
}

stage.addEventListener(Event.ENTER_FRAME, main);

stage.addEventListener(KeyboardEvent.KEY_DOWN, pressMultipleKeys);
function pressMultipleKeys(evt0: KeyboardEvent) {
	if (evt0.keyCode == 87 || evt0.keyCode == 38) {
		keyUpDown = true;
	} else if (evt0.keyCode == 65 || evt0.keyCode == 37) {
		keyLeftDown = true;
	} else if (evt0.keyCode == 68 || evt0.keyCode == 39) {
		keyUpDown = true;
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
		keyUpDown = false;
	} else if (evt00.keyCode == 83 || evt00.keyCode == 40) {
		keyDownDown = false;
	}
}

function handleWalkAnimation(){
	if (keyLeftDown){
		mainChar.gotoAndStop(2);
	} else {
		mainChar.gotoAndStop(1);
	}
}