## Special Code References for [FiiCode 2023](https://fiicode.asii.ro/gamedev/)

### Enter racetrack:

```
function changeBackgroundTo(newBackground: int){
	var oldBackground: int = activeBackground;
	thebg.gotoAndStop(newBackground);
	activeBackground = newBackground;
	actionbubble.gotoAndStop(1);
	mainChar.guyinside.gotoAndPlay(1); // briefly pause the character if he is moving
	[...]
		if (thebg.currentFrame == 5){ // enter the racetrack
			var time: int = localTime;
			if (time < 125000){ // enter before race starts, nothing happens
				thebg.bg05.gotoAndStop(1);
			} else if (time < 240000){ // enter during race, see the horse passing the finish line
				thebg.bg05.gotoAndPlay(2);
				if (winnerHorse == 0){ // handle horse superposition
					winnerHorse = Math.floor(Math.random() * 14) + 1;
				} else {
					thebg.bg05.gotoAndStop(120);
				}
				thebg.bg05.thehorse.horsepanel.winnernumber.text = String(winnerHorse);
			} else if (time < 420000){ // enter after race, see horse finished
				thebg.bg05.gotoAndStop(120);
				if (winnerHorse == 0) winnerHorse = Math.floor(Math.random() * 14) + 1;
				thebg.bg05.thehorse.horsepanel.winnernumber.text = String(winnerHorse);
			} else {
				happenEnding(6); //lose for being seen on the track by everyone, after race is over
			}
		}
	[...]
```
### Watch Time Display:

```
localTime = getTimer() - gameStartTime;
function handleTimeDisplay(){
	if (currentFrame != 3 || thewatch.visible == false){
		return; // don't keep track of time if not playing
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
```

### Python Code to generate AS3 code (see [Trivia](https://github.com/BlackAlexander/uncertainty-gambit/blob/main/Trivia%20%26%20Walkthrough/Trivia.md) point 21):

```
f = open("input.txt", "r")
baseString = f.read()
odds = ["0:0", "6:5", "7:9", "1:3", "3:7", "2:1", "1:19", "2:3", "1:2", "3:2", "5:7", "4:3", "8:3", "3:7", "2:11"]
for i in range(1, 15):
    finalString = ""
    for character in baseString:
        if character == "P":
            finalString += str(i)
        elif character == "O":
            finalString += odds[i]
        else:
            finalString += character
    print(finalString + "\n")
    ```
