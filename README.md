# OhHellScoreKeepingApp

## Table of contents
1. [Overview](#Overview)
2. [Download and run](#Download-and-run)
3. [Start a new game](#Start-a-new-game)
   1. [Enter the number of players](#Enter-the-number-of-players)
   2. [Enter the player names](#Enter-the-player-names)
   3. [Enter the maximum number of cards](#Enter-the-maximum-number-of-cards)
   4. [Select the game order](#Select-the-game-order)
   5. [Start your new game](#Start-your-new-game)
4. [Play (...or just poke around the app...)](#Play-(...or-just-poke-around-the-app...))
   1. [Enter player bids](#Enter-player-bids)
   2. [View player points](#View-player-points)
   3. [View player scores](#View-player-scores)
   4. [Play the next round](#Play-the-next-round)
   5. [Restart a Round](#Restart-a-Round)
   6. [End game](#End-game)
5. [View your game history](#View-your-game-history)

## 1. <ins>Overview</ins>
I created this app as my final project to fulfill the Udacity iOS Nanodegree program. It's a companion app to the card game [Oh Hell](https://en.wikipedia.org/wiki/Oh_hell).

## 2. <ins>Download and run</ins>
* To just play around with this app, all you have to do is download, run, and follow the instructions below. 
* To use it as a companion app while you play Oh Hell, first gather your players and a deck of cards, then download, run, and follow the instructions below.

## 3. <ins>Start a new game</ins>
There's no need to create an account and log in. The first screen will have helper text to get you started. Tap the **+** icon in the top right corner.

The "New Game" screen will appear. 

### i. <ins>Enter the number of players</ins>
Use the segmented control to enter the number of players. You must have a minumum of 3 players and no more than 8 players. The control will become disabled accordingly.

### ii. <ins>Enter the player names</ins>
Next, enter your player names in to the text fields. 3 textfields will show by default. If you add more than 3 players per instructions above, then a new textfield will appear for the corresponding player. If you decide to play with fewer players than you originally entered, the number of textfields will update to reflect the new number of players.

### iii. <ins>Enter the maximum number of cards</ins>
Use the segmented control to enter the maximum number of cards you intend to play. You must play a minimum of two cards. The maximum number of cards will update according to the number of players. E.g., if you're playing with 3 players, the maximum number of cards will be capped out at 17; if you're playing with 5 players, the maximum number of cards will be capped out at 10. The segmented control will become disabled accordingly. 

### iv. <ins>Select the game order</ins>
Then select whether you want to play in descending or ascending order. Note: This app allows you to play as few or as many rounds as you want. You can end the game at any time and save the winner data to your game history. Once a game is ended, it's done: You can't select it and pick up playing that same game again. You have to start a new game from scratch.

* <ins>Descending order</ins> - Your first round will start with the maximum hand size, then descend incrementally down to two cards (first round: 17 cards; second round: 16 cards; third round: 15 cards, etc.), then work its way back up to the maximum hand size.
* <ins>Ascending order</ins> -  Your first round will start with two cards and ascend incrementally until you reach the maximum hand size, then descend incrementally to two cards.


### v. <ins>Start your new game</ins>
Click the **Start Game** button when you're done.

## 4. <ins>Play (...or just poke around the app...)</ins>
The "Game" screen will appear. The round number, dealer name, and hand size will appear at the top of the screen to help you keep track.

Each player is assigned an avatar generated from the [DiceBear API](https://www.dicebear.com/styles/identicon/). The player names themselves are used to retrieve the images. See the APIClient file for more detail.

### i. <ins>Enter player bids</ins>
Enter the bid for each player. Only integers are accepted, with a max of 2 digits. The total number of bids cannot equal the hand size. E.g., if the hand size is 5, the sum of the bids cannot equal 5. In this scenario, an alert will appear and will instruct you to enter a different bid number in the last bid field.

After you finish playing a round, use the segmented control to indicate who won their bid.

### ii. <ins>View player points</ins>
The "+" column shows the number of points each player received. This logic depends on whether a player won their bid. 

### iii. <ins>View player scores</ins>
Likewise, the "Score" column will update accordingly with the total points per player, carried over from each round. 

### iv. <ins>Play the next round</ins>
To play the next round, tap the **Next Round** button.

### v. <ins>Restart a round</ins>
Sometimes you play a round and realize someone made a mistake (misdealt the cards, etc.). If you want to restart the round, tap the **ellipsis** icon in the top right of the screen, then select **Restart Round**. The round data will reset. 

### vi. <ins>End game</ins>
As noted above, this app is designed to allow you to play as few or as many rounds as you want. When you're ready to end the game, tap the **ellipsis** icon in the top right of the screen, then select **End Game**. An alert will appear asking you to confirm whether you want to end the game. Tap **End Game**.

The "Winner" screen will appear.

If you have a tied game, the winner names will be displayed. Tap the **Done** button.

If you have a single winner, the winner name will be displayed along with a textfield where the winner can provide a "victory quote". You must enter a victory quote in order to proceed. Then tap the **Done** button.

## 5. <ins>View your game history</ins>
The "Game History" screen will appear. Your game will appear at the top of the table. Each game displays the following data:

* Winner avatar (note for ties: a 3-person image displays for all tied games)
* Winner name(s)
* Date of game
* Score
* Victory quote (note for ties: "Tied victory" displays for all tied games)

Games are listed in descending order by date (e.g., most recent games are shown at the top).



