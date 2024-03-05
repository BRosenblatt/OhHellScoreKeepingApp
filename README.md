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
4. [Play- or just poke around the app](#Play--or-just-poke-around-the-app)
   1. [Enter player bids](#Enter-player-bids)
   2. [Select who won their bids](Select-who-won-their-bids)
   3. [View player points](#View-player-points)
   4. [View player scores](#View-player-scores)
   5. [Play the next round](#Play-the-next-round)
   6. [Restart a Round](#Restart-a-Round)
   7. [End game](#End-game)
5. [View your game history](#View-your-game-history)

## 1. <ins>Overview</ins>
I created this app as my final project to fulfill the [Udacity iOS Nanodegree program](https://www.udacity.com/course/ios-developer-nanodegree--nd003). It's a scorekeeping app for the card game [Oh Hell](https://en.wikipedia.org/wiki/Oh_hell).

## 2. <ins>Download and run</ins>
* To just play around with this app, all you have to do is download, run, and follow the instructions below. Enter test data for all inputs.
* To use it as a companion app while you play Oh Hell, first gather your players and a deck of cards, then download, run, and follow the instructions below.

## 3. <ins>Start a new game</ins>
The first screen will appear with helper text to get you started. Tap the **+** icon in the top right corner to start a game.

The "New Game" screen will appear. 

### *Enter the number of players*
Use the segmented control to choose the number of players. You must have a minumum of 3 players and no more than 8 players. The control will become disabled accordingly.

### *Enter the player names*
Next, enter your player names into the text fields. 3 textfields will show by default. If you add more than 3 players per instructions above, a new textfield will appear for each additional player. If you reduce the number of players, the number of textfields will update accordingly.

### *Enter the maximum number of cards*
Use the segmented control to choose the maximum number of cards you want to play at a time.

2 cards is the lowest you can select. The maximum number of cards will update based on the number of players. For example, if you're playing with 3 players, the maximum number of cards will be capped out at 17; if you're playing with 5 players, the maximum number of cards will be capped out at 10, etc. The segmented control will become disabled accordingly. 

### *Select the game order*
Then select whether you want to play in descending or ascending order.

* <ins>Descending order</ins> - Your first round will start with the maximum hand size, then descend incrementally down to 1 card (first round: 17 cards; second round: 16 cards; third round: 15 cards, etc.), then work its way back up to the maximum hand size.
* <ins>Ascending order</ins> -  Your first round will start with 1 card and ascend incrementally until you reach the maximum hand size, then descend incrementally again.


### *Start your new game*
Click the **Start Game** button when you're ready.

**Note**: *This app allows you to play as few or as many rounds as you want. You can end the game at any time and save the game results to your game history. Once a game is ended, it's done: You can't select it and pick up playing that same game again. You have to start a new game from scratch.*

## 4. <ins>Play- or just poke around the app</ins>
The "Game" screen will appear. The round number, dealer name, and hand size will appear at the top of the screen to help you keep track of each round.

Each player is assigned an avatar generated from the [DiceBear API](https://www.dicebear.com/styles/identicon/). The player names themselves are used to generate and retrieve the images.

### *Enter player bids*
Enter the bid for each player. Only integers are accepted, with a maximum of 2 digits. 

**Note**: *The total number of bids entered cannot equal the hand size. For example, if the hand size is 5, the sum of the bids cannot equal 5. In this scenario, an alert will appear to instruct you to enter a different bid in the last player/bid field. You cannot proceed until the bid has been updated.*

### *Select who won their bids*

After you finish playing a round, select the **checkmark** on the segmented controls for each player who won their bid.

### *View player points*
The "+" column calculates the number points each player received after a round is played. This logic is based on whether a player won their bid. 

### *View player scores*
The "Score" column tracks the total points per player as each round is played. 

### *Play the next round*
To play the next round, tap the **Next Round** button.

### *Restart a round*
If you realize someone made a mistake (misdealt the cards, etc.) in given round, you can restart the round. 

Tap the **ellipsis** icon in the top right of the screen, then select **Restart Round**. The round data will reset. 

### *End game*
As noted above, this app is designed to allow you to play as few or as many rounds as you want. When you're ready to end the game, tap the **ellipsis** icon in the top right of the screen, then select **End Game**. An alert will appear asking you to confirm whether you want to end the game. Tap **End Game**.

The "Winner" screen will appear.

If you have a tied game, the winner names will be displayed. Tap the **Done** button.

If you have a single winner, the winner name will be displayed along with a textfield where the winner can provide a "victory quote". You must enter a victory quote in order to proceed. Then tap the **Done** button.

## 5. <ins>View your game history</ins>
The "Game History" screen will appear. Your game will be listed at the top of the table. Each game displays the following data:

* Winner avatar (**Note for ties**: *a 3-person image displays for all tied games*)
* Winner name(s)
* Date of game
* Score
* Victory quote (**Note for ties**: *"Tied Victories!" displays for all tied games*)

Games are listed in descending order by date (e.g., most recent games are shown at the top).



