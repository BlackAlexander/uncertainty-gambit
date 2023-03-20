// doctor Notes
import flash.events.MouseEvent;

doctornotes.gotoAndStop(1);
drnotesbtnback.visible = false;

drnotesbtnback.addEventListener(MouseEvent.CLICK, gobackdrnote);
function gobackdrnote(event: MouseEvent) {
	doctornotes.gotoAndStop(doctornotes.currentFrame - 1);
	if (doctornotes.currentFrame == 1) {
		drnotesbtnback.visible = false;
	}
	drnotesbtnforward.visible = true;
}

drnotesbtnforward.addEventListener(MouseEvent.CLICK, gonextdrnote);
function gonextdrnote(event: MouseEvent) {
	doctornotes.gotoAndStop(doctornotes.currentFrame + 1);
	if (doctornotes.currentFrame == 3) {
		drnotesbtnforward.visible = false;
	}
	drnotesbtnback.visible = true;
}

exitdrnotebtn.addEventListener(MouseEvent.CLICK, exitdrnote);
function exitdrnote(event: MouseEvent) {
	MovieClip(root).aidnotesdoctor.visible = false;
}



// quantum Notes
import flash.events.MouseEvent;

quantumnotes.gotoAndStop(1);
qnotesbtnback.visible = false;

qnotesbtnback.addEventListener(MouseEvent.CLICK, gobackdrnote);
function gobackdrnote(event: MouseEvent) {
	quantumnotes.gotoAndStop(quantumnotes.currentFrame - 1);
	if (quantumnotes.currentFrame == 1) {
		qnotesbtnback.visible = false;
	}
	qnotesbtnforward.visible = true;
}

qnotesbtnforward.addEventListener(MouseEvent.CLICK, gonextdrnote);
function gonextdrnote(event: MouseEvent) {
	quantumnotes.gotoAndStop(quantumnotes.currentFrame + 1);
	if (quantumnotes.currentFrame == 8) {
		qnotesbtnforward.visible = false;
	}
	qnotesbtnback.visible = true;
}

exitqnotebtn.addEventListener(MouseEvent.CLICK, exitqnote);
function exitqnote(event: MouseEvent) {
	MovieClip(root).aidnotesquantum.visible = false;
}



// stolen Notes
import flash.events.MouseEvent;

stolennotes.gotoAndStop(1);
snotesbtnback.visible = false;

snotesbtnback.addEventListener(MouseEvent.CLICK, gobacksnote);
function gobacksnote(event: MouseEvent) {
	stolennotes.gotoAndStop(stolennotes.currentFrame - 1);
	if (stolennotes.currentFrame == 1) {
		snotesbtnback.visible = false;
	}
	snotesbtnforward.visible = true;
}

snotesbtnforward.addEventListener(MouseEvent.CLICK, gonextsnote);
function gonextsnote(event: MouseEvent) {
	stolennotes.gotoAndStop(stolennotes.currentFrame + 1);
	if (stolennotes.currentFrame == 7) {
		snotesbtnforward.visible = false;
	}
	snotesbtnback.visible = true;
}

exitsnotebtn.addEventListener(MouseEvent.CLICK, exitsnote);
function exitsnote(event: MouseEvent) {
	MovieClip(root).aidnotesstolen.visible = false;
}



// track entry panel
tentrypart1.gotoAndStop(1);
tentrypart2.gotoAndStop(1);
tentrypart3.gotoAndStop(1);
tentrypart4.gotoAndStop(1);
tentrypart5.gotoAndStop(1);
tentrypart6.gotoAndStop(1);

tentrypart1.tentrybtn.addEventListener(MouseEvent.CLICK, nextfuse1);
function nextfuse1(event: MouseEvent){
	if (tentrypart1.currentFrame == 6){
		tentrypart1.gotoAndStop(1);
	} else {
		tentrypart1.gotoAndStop(tentrypart1.currentFrame + 1);
	}
}

tentrypart2.tentrybtn.addEventListener(MouseEvent.CLICK, nextfuse2);
function nextfuse2(event: MouseEvent){
	if (tentrypart2.currentFrame == 6){
		tentrypart2.gotoAndStop(1);
	} else {
		tentrypart2.gotoAndStop(tentrypart2.currentFrame + 1);
	}
}

tentrypart3.tentrybtn.addEventListener(MouseEvent.CLICK, nextfuse3);
function nextfuse3(event: MouseEvent){
	if (tentrypart3.currentFrame == 6){
		tentrypart3.gotoAndStop(1);
	} else {
		tentrypart3.gotoAndStop(tentrypart3.currentFrame + 1);
	}
}

tentrypart4.tentrybtn.addEventListener(MouseEvent.CLICK, nextfuse4);
function nextfuse4(event: MouseEvent){
	if (tentrypart4.currentFrame == 6){
		tentrypart4.gotoAndStop(1);
	} else {
		tentrypart4.gotoAndStop(tentrypart4.currentFrame + 1);
	}
}

tentrypart5.tentrybtn.addEventListener(MouseEvent.CLICK, nextfuse5);
function nextfuse5(event: MouseEvent){
	if (tentrypart5.currentFrame == 6){
		tentrypart5.gotoAndStop(1);
	} else {
		tentrypart5.gotoAndStop(tentrypart5.currentFrame + 1);
	}
}

tentrypart6.tentrybtn.addEventListener(MouseEvent.CLICK, nextfuse6);
function nextfuse6(event: MouseEvent){
	if (tentrypart6.currentFrame == 6){
		tentrypart6.gotoAndStop(1);
	} else {
		tentrypart6.gotoAndStop(tentrypart6.currentFrame + 1);
	}
}

tentryexit.addEventListener(MouseEvent.CLICK, exittentry);
function exittentry(event: MouseEvent){
	MovieClip(root).theentrypanel.visible = false;
}

tentryenter.addEventListener(MouseEvent.CLICK, checksolutionentry);
function checksolutionentry(event: MouseEvent){
	var entryok: Boolean = true;
	if (tentrypart1.currentFrame != 2)entryok = false;
	if (tentrypart2.currentFrame != 5)entryok = false;
	if (tentrypart3.currentFrame != 4)entryok = false;
	if (tentrypart4.currentFrame != 2)entryok = false;
	if (tentrypart5.currentFrame != 6)entryok = false;
	if (tentrypart6.currentFrame != 3)entryok = false;
	if (entryok){
		MovieClip(root).theentrypanel.visible = false;
		MovieClip(root).changeBackgroundTo(5);
	}
}



// bet placing panel
import flash.events.MouseEvent;

var choosenHorse: int = 0;

for(var i: int = 1; i <= 14; i++){
	var thisTicket = getChildByName("horseticket" + String(i));
	thisTicket.gotoAndStop(1);
	thisTicket.horsebetnumber.text = String(i);
}

placedbet.text = "";

paybetbtn.addEventListener(MouseEvent.CLICK, choosebethorse);
function choosebethorse(event:MouseEvent){
	if (choosenHorse == 0){
		return;
	}
	for(var i: int = 1; i <= 14; i++){
		var thisButton = getChildByName("btnhorseticket" + String(i));
		thisButton.visible = false;
	}
	MovieClip(root).betwasplaced(choosenHorse);
}
paybetbtn.visible = false;

function setWinnerHorseOdds(){
	if (MovieClip(root).winnerHorse != 0){
		var winnerTicket = getChildByName("horseticket" + String(MovieClip(root).winnerHorse));
		winnerTicket.horsebetodds.text = "80:1";
	}
}

function setOdds(){
	horseticket1.horsebetodds.text = "6:5";
	horseticket2.horsebetodds.text = "7:9";
	horseticket3.horsebetodds.text = "1:3";
	horseticket4.horsebetodds.text = "3:7";
	horseticket5.horsebetodds.text = "2:1";
	horseticket6.horsebetodds.text = "1:19";
	horseticket7.horsebetodds.text = "2:3";
	horseticket8.horsebetodds.text = "1:2";
	horseticket9.horsebetodds.text = "3:2";
	horseticket10.horsebetodds.text = "5:7";
	horseticket11.horsebetodds.text = "4:3";
	horseticket12.horsebetodds.text = "8:3";
	horseticket13.horsebetodds.text = "3:7";
	horseticket14.horsebetodds.text = "2:11";
	setWinnerHorseOdds();
}

setOdds();

btnhorseticket1.addEventListener(MouseEvent.CLICK, pressHorse1);
function pressHorse1(event: MouseEvent){
	choosenHorse = 1;
	for(var i: int = 1; i <= 14; i++){
		var thisTicket = getChildByName("horseticket" + String(i));
		thisTicket.gotoAndStop(1);
		thisTicket.horsebetnumber.text = String(i);
		var thisButton = getChildByName("btnhorseticket" + String(i));
		thisButton.visible = true;
	}
	setOdds();
	btnhorseticket1.visible = false;
	horseticket1.gotoAndStop(2);
	horseticket1.horsebetnumber.text = String(choosenHorse);
    horseticket1.horsebetodds.text = "6:5";
    if (MovieClip(root).winnerHorse == 1){
        horseticket1.horsebetodds.text = "80:1";
    }
	placedbet.text = "1";
	paybetbtn.visible = true;
}
horseticket1.horsebetodds.text = "6:5";
if (MovieClip(root).winnerHorse == 1){
    horseticket1.horsebetodds.text = "80:1";
}

btnhorseticket2.addEventListener(MouseEvent.CLICK, pressHorse2);
function pressHorse2(event: MouseEvent){
	choosenHorse = 2;
	for(var i: int = 1; i <= 14; i++){
		var thisTicket = getChildByName("horseticket" + String(i));
		thisTicket.gotoAndStop(1);
		thisTicket.horsebetnumber.text = String(i);
		var thisButton = getChildByName("btnhorseticket" + String(i));
		thisButton.visible = true;
	}
	setOdds();
	btnhorseticket2.visible = false;
	horseticket2.gotoAndStop(2);
	horseticket2.horsebetnumber.text = String(choosenHorse);
    horseticket2.horsebetodds.text = "7:9";
    if (MovieClip(root).winnerHorse == 2){
        horseticket2.horsebetodds.text = "80:1";
    }
	placedbet.text = "2";
	paybetbtn.visible = true;
}
horseticket2.horsebetodds.text = "7:9";
if (MovieClip(root).winnerHorse == 2){
    horseticket2.horsebetodds.text = "80:1";
}

btnhorseticket3.addEventListener(MouseEvent.CLICK, pressHorse3);
function pressHorse3(event: MouseEvent){
	choosenHorse = 3;
	for(var i: int = 1; i <= 14; i++){
		var thisTicket = getChildByName("horseticket" + String(i));
		thisTicket.gotoAndStop(1);
		thisTicket.horsebetnumber.text = String(i);
		var thisButton = getChildByName("btnhorseticket" + String(i));
		thisButton.visible = true;
	}
	setOdds();
	btnhorseticket3.visible = false;
	horseticket3.gotoAndStop(2);
	horseticket3.horsebetnumber.text = String(choosenHorse);
    horseticket3.horsebetodds.text = "1:3";
    if (MovieClip(root).winnerHorse == 3){
        horseticket3.horsebetodds.text = "80:1";
    }
	placedbet.text = "3";
	paybetbtn.visible = true;
}
horseticket3.horsebetodds.text = "1:3";
if (MovieClip(root).winnerHorse == 3){
    horseticket3.horsebetodds.text = "80:1";
}

btnhorseticket4.addEventListener(MouseEvent.CLICK, pressHorse4);
function pressHorse4(event: MouseEvent){
	choosenHorse = 4;
	for(var i: int = 1; i <= 14; i++){
		var thisTicket = getChildByName("horseticket" + String(i));
		thisTicket.gotoAndStop(1);
		thisTicket.horsebetnumber.text = String(i);
		var thisButton = getChildByName("btnhorseticket" + String(i));
		thisButton.visible = true;
	}
	setOdds();
	btnhorseticket4.visible = false;
	horseticket4.gotoAndStop(2);
	horseticket4.horsebetnumber.text = String(choosenHorse);
    horseticket4.horsebetodds.text = "3:7";
    if (MovieClip(root).winnerHorse == 4){
        horseticket4.horsebetodds.text = "80:1";
    }
	placedbet.text = "4";
	paybetbtn.visible = true;
}
horseticket4.horsebetodds.text = "3:7";
if (MovieClip(root).winnerHorse == 4){
    horseticket4.horsebetodds.text = "80:1";
}

btnhorseticket5.addEventListener(MouseEvent.CLICK, pressHorse5);
function pressHorse5(event: MouseEvent){
	choosenHorse = 5;
	for(var i: int = 1; i <= 14; i++){
		var thisTicket = getChildByName("horseticket" + String(i));
		thisTicket.gotoAndStop(1);
		thisTicket.horsebetnumber.text = String(i);
		var thisButton = getChildByName("btnhorseticket" + String(i));
		thisButton.visible = true;
	}
	setOdds();
	btnhorseticket5.visible = false;
	horseticket5.gotoAndStop(2);
	horseticket5.horsebetnumber.text = String(choosenHorse);
    horseticket5.horsebetodds.text = "2:1";
    if (MovieClip(root).winnerHorse == 5){
        horseticket5.horsebetodds.text = "80:1";
    }
	placedbet.text = "5";
	paybetbtn.visible = true;
}
horseticket5.horsebetodds.text = "2:1";
if (MovieClip(root).winnerHorse == 5){
    horseticket5.horsebetodds.text = "80:1";
}

btnhorseticket6.addEventListener(MouseEvent.CLICK, pressHorse6);
function pressHorse6(event: MouseEvent){
	choosenHorse = 6;
	for(var i: int = 1; i <= 14; i++){
		var thisTicket = getChildByName("horseticket" + String(i));
		thisTicket.gotoAndStop(1);
		thisTicket.horsebetnumber.text = String(i);
		var thisButton = getChildByName("btnhorseticket" + String(i));
		thisButton.visible = true;
	}
	setOdds();
	btnhorseticket6.visible = false;
	horseticket6.gotoAndStop(2);
	horseticket6.horsebetnumber.text = String(choosenHorse);
    horseticket6.horsebetodds.text = "1:19";
    if (MovieClip(root).winnerHorse == 6){
        horseticket6.horsebetodds.text = "80:1";
    }
	placedbet.text = "6";
	paybetbtn.visible = true;
}
horseticket6.horsebetodds.text = "1:19";
if (MovieClip(root).winnerHorse == 6){
    horseticket6.horsebetodds.text = "80:1";
}

btnhorseticket7.addEventListener(MouseEvent.CLICK, pressHorse7);
function pressHorse7(event: MouseEvent){
	choosenHorse = 7;
	for(var i: int = 1; i <= 14; i++){
		var thisTicket = getChildByName("horseticket" + String(i));
		thisTicket.gotoAndStop(1);
		thisTicket.horsebetnumber.text = String(i);
		var thisButton = getChildByName("btnhorseticket" + String(i));
		thisButton.visible = true;
	}
	setOdds();
	btnhorseticket7.visible = false;
	horseticket7.gotoAndStop(2);
	horseticket7.horsebetnumber.text = String(choosenHorse);
    horseticket7.horsebetodds.text = "2:3";
    if (MovieClip(root).winnerHorse == 7){
        horseticket7.horsebetodds.text = "80:1";
    }
	placedbet.text = "7";
	paybetbtn.visible = true;
}
horseticket7.horsebetodds.text = "2:3";
if (MovieClip(root).winnerHorse == 7){
    horseticket7.horsebetodds.text = "80:1";
}

btnhorseticket8.addEventListener(MouseEvent.CLICK, pressHorse8);
function pressHorse8(event: MouseEvent){
	choosenHorse = 8;
	for(var i: int = 1; i <= 14; i++){
		var thisTicket = getChildByName("horseticket" + String(i));
		thisTicket.gotoAndStop(1);
		thisTicket.horsebetnumber.text = String(i);
		var thisButton = getChildByName("btnhorseticket" + String(i));
		thisButton.visible = true;
	}
	setOdds();
	btnhorseticket8.visible = false;
	horseticket8.gotoAndStop(2);
	horseticket8.horsebetnumber.text = String(choosenHorse);
    horseticket8.horsebetodds.text = "1:2";
    if (MovieClip(root).winnerHorse == 8){
        horseticket8.horsebetodds.text = "80:1";
    }
	placedbet.text = "8";
	paybetbtn.visible = true;
}
horseticket8.horsebetodds.text = "1:2";
if (MovieClip(root).winnerHorse == 8){
    horseticket8.horsebetodds.text = "80:1";
}

btnhorseticket9.addEventListener(MouseEvent.CLICK, pressHorse9);
function pressHorse9(event: MouseEvent){
	choosenHorse = 9;
	for(var i: int = 1; i <= 14; i++){
		var thisTicket = getChildByName("horseticket" + String(i));
		thisTicket.gotoAndStop(1);
		thisTicket.horsebetnumber.text = String(i);
		var thisButton = getChildByName("btnhorseticket" + String(i));
		thisButton.visible = true;
	}
	setOdds();
	btnhorseticket9.visible = false;
	horseticket9.gotoAndStop(2);
	horseticket9.horsebetnumber.text = String(choosenHorse);
    horseticket9.horsebetodds.text = "3:2";
    if (MovieClip(root).winnerHorse == 9){
        horseticket9.horsebetodds.text = "80:1";
    }
	placedbet.text = "9";
	paybetbtn.visible = true;
}
horseticket9.horsebetodds.text = "3:2";
if (MovieClip(root).winnerHorse == 9){
    horseticket9.horsebetodds.text = "80:1";
}

btnhorseticket10.addEventListener(MouseEvent.CLICK, pressHorse10);
function pressHorse10(event: MouseEvent){
	choosenHorse = 10;
	for(var i: int = 1; i <= 14; i++){
		var thisTicket = getChildByName("horseticket" + String(i));
		thisTicket.gotoAndStop(1);
		thisTicket.horsebetnumber.text = String(i);
		var thisButton = getChildByName("btnhorseticket" + String(i));
		thisButton.visible = true;
	}
	setOdds();
	btnhorseticket10.visible = false;
	horseticket10.gotoAndStop(2);
	horseticket10.horsebetnumber.text = String(choosenHorse);
    horseticket10.horsebetodds.text = "5:7";
    if (MovieClip(root).winnerHorse == 10){
        horseticket10.horsebetodds.text = "80:1";
    }
	placedbet.text = "10";
	paybetbtn.visible = true;
}
horseticket10.horsebetodds.text = "5:7";
if (MovieClip(root).winnerHorse == 10){
    horseticket10.horsebetodds.text = "80:1";
}

btnhorseticket11.addEventListener(MouseEvent.CLICK, pressHorse11);
function pressHorse11(event: MouseEvent){
	choosenHorse = 11;
	for(var i: int = 1; i <= 14; i++){
		var thisTicket = getChildByName("horseticket" + String(i));
		thisTicket.gotoAndStop(1);
		thisTicket.horsebetnumber.text = String(i);
		var thisButton = getChildByName("btnhorseticket" + String(i));
		thisButton.visible = true;
	}
	setOdds();
	btnhorseticket11.visible = false;
	horseticket11.gotoAndStop(2);
	horseticket11.horsebetnumber.text = String(choosenHorse);
    horseticket11.horsebetodds.text = "4:3";
    if (MovieClip(root).winnerHorse == 11){
        horseticket11.horsebetodds.text = "80:1";
    }
	placedbet.text = "11";
	paybetbtn.visible = true;
}
horseticket11.horsebetodds.text = "4:3";
if (MovieClip(root).winnerHorse == 11){
    horseticket11.horsebetodds.text = "80:1";
}

btnhorseticket12.addEventListener(MouseEvent.CLICK, pressHorse12);
function pressHorse12(event: MouseEvent){
	choosenHorse = 12;
	for(var i: int = 1; i <= 14; i++){
		var thisTicket = getChildByName("horseticket" + String(i));
		thisTicket.gotoAndStop(1);
		thisTicket.horsebetnumber.text = String(i);
		var thisButton = getChildByName("btnhorseticket" + String(i));
		thisButton.visible = true;
	}
	setOdds();
	btnhorseticket12.visible = false;
	horseticket12.gotoAndStop(2);
	horseticket12.horsebetnumber.text = String(choosenHorse);
    horseticket12.horsebetodds.text = "8:3";
    if (MovieClip(root).winnerHorse == 12){
        horseticket12.horsebetodds.text = "80:1";
    }
	placedbet.text = "12";
	paybetbtn.visible = true;
}
horseticket12.horsebetodds.text = "8:3";
if (MovieClip(root).winnerHorse == 12){
    horseticket12.horsebetodds.text = "80:1";
}

btnhorseticket13.addEventListener(MouseEvent.CLICK, pressHorse13);
function pressHorse13(event: MouseEvent){
	choosenHorse = 13;
	for(var i: int = 1; i <= 14; i++){
		var thisTicket = getChildByName("horseticket" + String(i));
		thisTicket.gotoAndStop(1);
		thisTicket.horsebetnumber.text = String(i);
		var thisButton = getChildByName("btnhorseticket" + String(i));
		thisButton.visible = true;
	}
	setOdds();
	btnhorseticket13.visible = false;
	horseticket13.gotoAndStop(2);
	horseticket13.horsebetnumber.text = String(choosenHorse);
    horseticket13.horsebetodds.text = "3:7";
    if (MovieClip(root).winnerHorse == 13){
        horseticket13.horsebetodds.text = "80:1";
    }
	placedbet.text = "13";
	paybetbtn.visible = true;
}
horseticket13.horsebetodds.text = "3:7";
if (MovieClip(root).winnerHorse == 13){
    horseticket13.horsebetodds.text = "80:1";
}

btnhorseticket14.addEventListener(MouseEvent.CLICK, pressHorse14);
function pressHorse14(event: MouseEvent){
	choosenHorse = 14;
	for(var i: int = 1; i <= 14; i++){
		var thisTicket = getChildByName("horseticket" + String(i));
		thisTicket.gotoAndStop(1);
		thisTicket.horsebetnumber.text = String(i);
		var thisButton = getChildByName("btnhorseticket" + String(i));
		thisButton.visible = true;
	}
	setOdds();
	btnhorseticket14.visible = false;
	horseticket14.gotoAndStop(2);
	horseticket14.horsebetnumber.text = String(choosenHorse);
    horseticket14.horsebetodds.text = "2:11";
    if (MovieClip(root).winnerHorse == 14){
        horseticket14.horsebetodds.text = "80:1";
    }
	placedbet.text = "14";
	paybetbtn.visible = true;
}
horseticket14.horsebetodds.text = "2:11";
if (MovieClip(root).winnerHorse == 14){
    horseticket14.horsebetodds.text = "80:1";
}
setOdds();



// and a few other library items with one or two lines of code