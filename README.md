<img src="https://github.com/perispectus/stackdoku/blob/main/icon_1.png?raw=true" align="left" width="80" height="80">

# Stackdoku
A 3D Sudoku-like puzzle game

* Author: *Ryan Lelache (aka 'perispectus')*
* Version: *v0.2.0*
* Release Date: *19 Jan 2022*

## What is Stackdoku?
*Stackdoku* is a casual Sudoku-like puzzle game developed in Godot 3.4. It was developed as an initial game project to test out the features of Godot's 3D engine and learn somewhat more advanced concepts for game development after building mostly in Twine.

## Okay, so how does it play?
Great question; have you done this before? Anyway -- this game currently works with touch or mouse input only, though I play to add keyboard shortcuts in a later version to help with accessibility. As of v0.2.0 the game supports the following features:
* Procedural generation of 9x9 sudoku game boards
* HUD for inputting single digits (1-9) into a game board space and a responsive game board that changes space z-height based on input
* Verifies 'win state' upon successfully inputting the puzzle solution.
* Tracks number of moves and elapsed game time to keep track of high scores
* Settings menu framework enabled (WIP)

## What else are you working on?
Another good question, you must be a professional! This game is still in a sort of 'alpha' state, in that it's playable but some core functionality is still WIP, and several long-pole features are still being framed out. Details on those listed below, and will update them into the feature list above on later updates.
* Display locally-saved high scores in the Settings menu (save/load is already enabled)
* Enable 'Easy' and 'Difficult' modes with varied gameplay rules
** Easy will restrict you to only entering numbers that haven't been used yet and likely involve some sort of visual indication when you guess right (TBD)
** Difficult will preference the right 'first guess' and enable a fail state if you overshoot the valid number (e.g., if value is '3' and you put '2' it won't fail, but if you input '4' it will)
* Allow sharing of high scores via messaging/social media, all that junk :P
* Visual upgrades and branding

## Where can I find this game to play?
The official landing page for this game is https://perispectus.itch.io/stackdoku

I will update this document at a later date if this game ends up coming to any other platform(s) or storefronts (e.g., mobile, Steam, etc.)
