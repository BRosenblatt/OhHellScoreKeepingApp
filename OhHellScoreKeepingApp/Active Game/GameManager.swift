//
//  GameManager.swift
//  OhHellScoreKeepingApp
//
//  Created by Becca Kauper on 10/6/23.
//

import Foundation
import UIKit


enum GameOrder {
    case descending
    case ascending
}

class GameManager {
    
    // properties for players, rounds, currentRound, scores
    private(set) var players: [String] = []
    private(set) var rounds: [Round] = []
    private(set) var scores: [String: Int] = [:]
    private(set) var startingHandSize = 0
    private(set) var maxHandSize = 0
    private(set) var gameOrder: GameOrder = .descending
    
    var currentRound: Round? {
        rounds.last
    }
    
    static let shared: GameManager = GameManager()
    
    private init() {}
        
// functions to...
    
    // start a game with these players
    func createGame(playerNames: [String], gameOrder: GameOrder, maxCardCount: Int) {
        if gameOrder == .descending {
            startingHandSize = maxCardCount
        } else {
            startingHandSize = 1
        }
        
        self.gameOrder = gameOrder
        players = playerNames
    }
    
    // start new round; players can play as many rounds as they want
    func startNewRound() {
        var handSize: Int = startingHandSize

        if let round = rounds.last {
            handSize = nextRoundHandSize(previousRound: round, maxHandSize: maxHandSize)
        }
               
        let newRound = Round(roundNumber: rounds.count + 1, handSize: handSize)
        rounds.append(newRound)
    }
    
    func nextRoundHandSize(previousRound: Round, maxHandSize: Int) -> Int {
        var newHandSize: Int
        
        if previousRound.handSize == maxHandSize {
            newHandSize = maxHandSize - 1
            gameOrder = .descending
        } else if previousRound.handSize == 1 {
            newHandSize = previousRound.handSize + 1
            gameOrder = .ascending
        } else if gameOrder == .descending {
            newHandSize = previousRound.handSize - 1
        } else {
            newHandSize = previousRound.handSize + 1
        }
        
        return newHandSize
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
        
        if didWinBid {
            currentRound?.didWinBid[playerName] = true
            currentRound?.points[playerName] = wonPoints
        }
        
        guard didWinBid else {
            currentRound?.points[playerName] = 0
            currentRound?.didWinBid[playerName] = false
            return
        }
    }
    
    // calculate total scores
       // prior round score + current round points
    func calculateScoreForPlayer(playerPoints: Int, playerName: String) {
        guard let priorRoundScore = scores[playerName] else {
            return  }
        let updatedScore = playerPoints + priorRoundScore
        
        //add player scores to dictionary
        scores[playerName] = updatedScore
    }
    
    // calculate maximum handSize
       // 3 players -> 17 cards; 4 players -> 12 cards; 5 players -> 10 cards; 6 players -> 8 cards; 7 players -> 7 cards; 8 players -> 6 cards
    func maximumCardCount(numberOfPlayers: Int) -> Int {
        51 / numberOfPlayers
    }
    
    // Calculate bids to make sure the round is over or under bid
        
    // Ending Game determines winner. The winner is the player with the highest score
    
}
