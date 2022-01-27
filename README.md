<img src="https://github.com/perispectus/stackdoku/blob/main/icon.png?raw=true" align="left" width="80" height="80">

# Stackdoku
A 3D Sudoku-like puzzle game

* Author: *Ryan Lelache (aka 'perispectus')*
* Version: *v0.3.1*
* Latest Update: *27 Jan 2022*
* Initial Release: *19 Jan 2022*

## What is Stackdoku?
*Stackdoku* is a casual Sudoku-like puzzle game developed in Godot 3.4. It was developed as an initial game project to test out the features of Godot's 3D engine and learn somewhat more advanced concepts for game development after building mostly in Twine.

## Okay, so how does it play?
Great question; have you done this before? Anyway -- this game currently works with touch or mouse input only, though I play to add keyboard shortcuts in a later version to help with accessibility. As of v0.3.0 the game supports the following features:
* Procedural generation of 9x9 sudoku game boards
* HUD for inputting single digits (1-9) into a game board space and a responsive game board that changes space z-height based on input
* Verifies 'win state' upon successfully inputting the puzzle solution.
* Tracks your best high scores based on number of moves and elapsed game time (visible from the Settings menu)
* Settings menu framework enabled
* Ability to toggle between Easy and Normal mode
    * Easy: Color coding to tell you when an input is right(green) or wrong(orange), and disables using right answer inputs via the HUD
    * Normal: No color-coding on right/wrong inputs, able to use the same number multiple times incorrectly without fail state, no disabling of the HUD
* Addition of Android platform support

## What else are you working on?
Another good question, you must be a professional! This game is still in a sort of 'alpha' state, in that it's playable but some core functionality is still WIP, and several long-pole features are still being framed out. Details on those listed below, and will update them into the feature list above on later updates.
* Enable 'Difficult' mode with varied gameplay rules
    * Difficult will preference the right 'first guess' and enable a fail state if you overshoot the valid number (e.g., if value is '3' and you put '2' it won't fail, but if you input '4' it will fail)
* Allow sharing of high scores via messaging/social media, all that junk :P
* Visual upgrades and branding

## Where can I find this game to play?
The official landing page for this game is https://perispectus.itch.io/stackdoku

## Privacy Policy
Please find the privacy policy for this game linked here: https://github.com/perispectus/Stackdoku/blob/main/Privacy-Policy.md
