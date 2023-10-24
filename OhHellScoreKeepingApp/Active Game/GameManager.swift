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
    
    // properties for players, rounds, currentRound, scores
    private(set) var players: [String] = []
    private(set) var rounds: [Round] = []
    private(set) var scores: [String: Int] = [:]
    private(set) var handSize: Int = 1
    
    var currentRound: Round? {
        rounds.last
    }
    
    static let shared: GameManager = GameManager()
    
    private init() {}
        
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
        let wonPoints = bid + 10
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
       // prior round score + current round points

    // calculate handSize
       // 3 players -> 17 cards; 4 players -> 12 cards; 5 players -> 10 cards; 6 players -> 8 cards; 7 players -> 7 cards; 8 players -> 6 cards
    func maximumCardCount(numberOfPlayers: Int) -> Int {
        51 / numberOfPlayers
    }
    
    // Calculate bids to make sure the round is over or under bid
        
    // Ending Game determines winner. The winner is the player with the highest score
    
}
