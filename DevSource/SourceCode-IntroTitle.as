skipbtn.addEventListener(MouseEvent.CLICK, skipIntro);
function skipIntro(event:MouseEvent){
	gotoAndStop(3);
}

intromovie.gotoAndStop(1);
intromovie.visible = false;

playintrobtn.addEventListener(MouseEvent.CLICK, playIntro);
function playIntro(event:MouseEvent){
	intromovie.visible = true;
	intromovie.gotoAndPlay(2);
	playintrobtn.visible = false;
}