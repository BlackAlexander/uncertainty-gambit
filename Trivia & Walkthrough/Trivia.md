## Trivia
- The background color of the betting menu, `#BE3455`, is Pantone's [color of the year](https://www.pantone.com/color-of-the-year/2023), _Viva Magenta_.
- The top part of the racetrack is non-Euclidean. You can walk upwards for hours. However, going back would only take a few steps. Implementing this feature was rather painful.
- 'The Doctor' is voiced by Bryan Cranston. Or, to be more accurate, by an AI trained on the actor's voice. The advertiser's voice is from The Narrator from The Stanley Parable.
- Put together, more than 1500 lines of code were written for the game.
- At the end of the notes explaining quantum concepts, there is a stupid joke I wrote, based on the pun on _stable_ quantum states and horse _stables_.
- The cat in the bathroom is a (quite literal) reference to [Schrödinger's cat](https://en.wikipedia.org/wiki/Schr%C3%B6dinger%27s_cat). This is probably the most widely known concept in quantum physics. Until the cat is observed (seen), even at a code level, the cat is in [superposition](https://en.wikipedia.org/wiki/Quantum_superposition). That is, the cat is _both_ dead and alive at the same time. When observed, the wave function collapses and the cat is seen in only one state. The experiment can be repeated - the cat can be seen both dead and alive.
- The cat feature is also an opportunity for the player to get a better grasp on what the graph on the bottom of the screen represents. When seeing the cat, a cat will appear on the graph. This shows how the player (represented as a human on the graph, always present) gets entangled with another quantum object.
- The sinusoidal appearance of the function is calling to a resemblance to the [wave function](https://en.wikipedia.org/wiki/Wave_function); each pixel of the animation (and the graphics connected to it) was hand-drawn. That was also painful.
- The watch time, the collision system, the environment and room changes, the player's movements and animations, the story itself and every other feature, were all implemented from scratch. No external library, framework, or game engine was used. The movement of _any pixel_ on the screen goes under code written by me, with hardcoded trigonometry formulas, optimised algorithms, and much more.
- Just the same, apart from the background textures, _any pixel_ displayed on the screen, may it be a button, a background, or a whole animation, went under my fingers, hand-drawn on my tablet.
- The intro scenes were also made from scratch. The pictures from the ad were actually stock illustrations that looked so good I had to apply filters to them in Lightroom, and add a Sepia effect, for a vintage commercial vibe.
- The odds on the winning horse are programmed to always be 80:1, no matter _which_ the winning horse is. This is a reference to 2022's [Kentucky Derby](https://www.bbc.com/news/world-us-canada-61367800), one of, if not _the most_, prestigious horse race events. In 2022, history was written when [the longet shot](https://en.wikipedia.org/wiki/Longshot) won the derby.
- If you arrive at the race track between 12:10:05 and 12:12:00, you will see the winning horse passing the finish line.
- There's a [bibelou cu pește](https://www.realitatea.net/stiri/actual/mai-ai-pe-acasa-acest-bibelou-iata-cat-valoreaza-acum-pestele-de-sticla-de-pus-pe-televizor_5dcc9258406af85273d630d2) on the TV in the intro scene.
- Walking from one side of the hallway to the other takes 20 seconds.
- When leaving the building, or being seen by the spectators, the entanglement graph won't show _the human_ anymore, it will show the whole world. The screen also gets white, instead of black like in the other endings, to better reflect the event.
- The library of the main file has 182 objects. Such an object could be a shadow or a piece of text, but most of them are hand-drawn assets or frame-by-frame animations.
- After standing still for 4 seconds, the detective will hide in his coat.
- The current record for the quickest speedrun to any ending is 3 seconds - the time it takes to get to the "you left" ending, by pressing the exit button.
- About 300 lines of AS code were generated by 23 lines of Python code. This was for programming the buttons in the betting panel. Other objects in the panel, such as the horse graphics, were handled procedurally. However, programming buttons is not something that is regularly done in bulk, as buttons are meant to be programmed manually. Tying functions to them could be done wth reference arrays; however, procedurally hardcoding each function by generating the code as text was much quicker and actually more efficient for the game.
- The current record for the quickest speedrun to winning is 148 seconds.
- The only reason why the mission happens on a Friday is because a remix of the song with the same name, from Nightcrawlers, came in my playlist while coding that part.