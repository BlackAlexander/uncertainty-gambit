import flash.events.MouseEvent;

stop();
stage.displayState = StageDisplayState.FULL_SCREEN_INTERACTIVE;

maingobtn.addEventListener(MouseEvent.CLICK, startGame);
function startGame(event:MouseEvent){
	gotoAndStop(2);
}

mainexitbtn.addEventListener(MouseEvent.CLICK, exitGame);
function exitGame(event:MouseEvent){
	NativeApplication.nativeApplication.exit();
}