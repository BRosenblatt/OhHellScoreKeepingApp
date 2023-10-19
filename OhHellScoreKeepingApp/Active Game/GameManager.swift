//
//  GameManager.swift
//  OhHellScoreKeepingApp
//
//  Created by Becca Kauper on 10/6/23.
//

import Foundation
import UIKit

//enum StartingHandType {
//    case one
//    case maximum
//}

class GameManager {
    
    // properties for players, rounds, currentRound, scores, or whatever
    var players: [String] = []
    var rounds: [Round] = []
    var scores: [String: Int] = [:]
    var handSize: Int = 1
    
    var currentRound: Round? {
        rounds.last
    }
        
// functions to...
    
    // start a game with these players
    func createGame(playerNames: [String], startingHandSize: Int) {
        handSize = startingHandSize
        players = playerNames
    }
    
    // start new round; players can play as many rounds as they want
    func startNewRound() {
        let newRound = Round(roundNumber: rounds.count + 1, handSize: handSize )
        rounds.append(newRound)
    }
    
    // enter bids
    
    func addBidForPlayer(bid: Int, playerName: String) {
        currentRound?.playerBids[playerName] = bid
    }
    
    // calculate points.
      // if player bids >= 1: 10 + bidNumber
      // if player bids 0: 5 + handSize
      // if player doesnt get bid: 0
    func calculatePointsForPlayer(bid: Int, playerName: String, didWinBid: Bool) {
        var wonPoints = bid + 10
        let noPoints = 0
        
        if didWinBid {
            currentRound?.didWinBid[playerName] = true
            currentRound?.points[playerName] = wonPoints
        } else {
            currentRound?.didWinBid[playerName] = false
            currentRound?.points[playerName] = noPoints
        }
    }
    
    // calculate total scores
    
    // finish round
    
    
    
    
    
    // Take number + name of players to determine table row count and player names (in correct order?)
    
    // Number of players determines maximum number of cards dealt
    // (add label that tracks dealer number of cards?)
    
    // Calculate bids to make sure the round is over or under bid
    
    // Calculate score based on whether players got their bid
    
    // Ending Game determines winner. The winner is the player with the highest score
    
}
