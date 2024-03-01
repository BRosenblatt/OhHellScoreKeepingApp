# OhHellScoreKeepingApp

## Overview
I created this app as my final project to fulfill the Udacity iOS Nanodegree program. It's a companion app to the card game [Oh Hell](https://en.wikipedia.org/wiki/Oh_hell).

## How to Use

### Download and Run
* To just play around with this app, all you have to do is download, run, and follow the instructions below. 
* To use it as a companion app while you play Oh Hell, first gather your players and a deck of cards, then download, run, and follow the instructions below.

### Start a New Game
There's no need to create an account and log in. The first screen will have helper text to get you started. Tap the '+' icon in the top right corner.

The New Game screen will appear. Use the segmented control to enter the number of players. You must have a minumum of 3 players and no more than 8 players. The control will become disabled accordingly.

Then enter your player names in to the text fields. 3 textfields will show by default. If you add more than 3 players per instructions above, then a new textfield will appear for the corresponding player. If you decide to play with fewer players than you originally entered, the number of textfields will update to reflect the new number of players.

Next, use the segmented control to enter the maximum number of cards you intend to play in a round. You must play a minimum of two cards. The maximum number of cards will update according to the number of players. E.g., if you're playing with 3 players, the maximum number of cards will be capped out at 17; if you're playing with 5 players, the maximum number of cards will be capped out at 10. The segmented control will become disabled accordingly. 

Then select whether you want to play in descending or ascending order. Note: This app allows you to play as few or as many rounds as you want. You can end the game at any time and save the winner data to your game history. Once a game is ended, it's done: You can't select it and pick up playing that same again. You have to start a new game from scratch.

* Descending order - Your first round will start with the maximum hand size, then descend incrementally down to two cards (first round: 17 cards; second round: 16 cards; third round: 15 cards, etc.), then work its way back up to the maximum hand size.
* Ascending order -  Your first round will start with two cards and ascend incrementally until you reach the max card size, then descend incrementally to two cards. 
