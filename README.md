<img src="https://github.com/perispectus/stackdoku/blob/main/icon.png?raw=true" align="left" width="80" height="80">

# Stackdoku
A 3D Sudoku-like puzzle game

* Author: *Ryan Lelache (aka 'perispectus')*
* Version: *v0.4.0*
* Latest Update: *8 Feb 2022*
* Initial Release: *19 Jan 2022*

## What is Stackdoku?
*Stackdoku* is a casual Sudoku-like puzzle game developed in Godot 3.4. It was developed as an initial game project to test out the features of Godot's 3D engine and learn somewhat more advanced concepts for game development after building mostly in Twine.

## Okay, so how does it play?
Great question; have you done this before? Anyway -- this game currently works with touch or mouse input only, as well as keyboard input for numbers on PC. As of v0.4.0 the game supports the following features:
* Procedural generation of 9x9 sudoku game boards
* HUD for inputting single digits (1-9) into a game board space and a responsive game board that changes space z-height based on input
* Verifies 'win state' upon successfully inputting the puzzle solution.
* Tracks your best high scores based on number of moves and elapsed game time (visible from the Settings menu)
* Settings menu framework enabled
* Ability to toggle between Easy, Normal and Difficult modes with background color coding
    * Easy (Green): Color coding to tell you when an input is right(green) or wrong(orange), and disables using right answer inputs via the HUD
    * Normal (Blue): No color-coding on right/wrong inputs, able to use the same number multiple times incorrectly without fail state, no disabling of the HUD
    * Difficult (Purple): No color-coding on inputs, able to use the same number multiple times, and if you guess _over_ the space's correct value, the game is lost
* Addition of Android platform support

## What else are you working on?
Another good question, you must be a professional! This game is now effectively in a full release state; it's playable with all core functionality and planned features. Apart from bug fixes, there were a few "maybes" on the feature list that aren't yet added in, but don't seem super high priority at this stage. Leaving them here more for transparency. 
* Allow sharing of high scores via messaging/social media, all that junk :P
* Visual upgrades and branding

## Where can I find this game to play?
The official landing page for this game is https://perispectus.itch.io/stackdoku and you can check it out on the Google Play Store at https://play.google.com/store/apps/details?id=com.myComp.Stackdoku

## Privacy Policy
Please find the privacy policy for this game linked here: https://github.com/perispectus/Stackdoku/blob/main/Privacy-Policy.md
