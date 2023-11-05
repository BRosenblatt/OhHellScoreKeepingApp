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
    private(set) var players: [String] = [] // also keeps track of the player order per round
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
        players = playerNames // also sets starting order of the players
        playerNames.forEach({ playerName in
            scores[playerName] = 0
        })
    }
    
    // start new round; players can play as many rounds as they want
    func startNewRound() {
        var handSize: Int = startingHandSize
        
        if let round = rounds.last {
            handSize = nextRoundHandSize(previousRound: round, maxHandSize: maxHandSize)
        }
               
        let newRoundOrderedPlayers = orderedPlayers(for: currentRound?.orderedPlayerList)
        let newRound = Round(roundNumber: rounds.count + 1, handSize: handSize, orderedPlayerList: newRoundOrderedPlayers)
        
        rounds.append(newRound)
    }
    
    private func orderedPlayers(for previousRound: [String]?) -> [String] {
        guard let previousRound else {
            return players
        }
        
        // start by copying the previous round
        var nextRoundOrderedPlayers = previousRound
        
        // make the first player the dealer
        let newDealer = nextRoundOrderedPlayers.remove(at: 0)
        nextRoundOrderedPlayers.append(newDealer)

        return nextRoundOrderedPlayers
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
    func updateRoundPoints(for playerName: String, didWinBid: Bool) -> Int {
        currentRound?.didWinBid[playerName] = didWinBid

        guard didWinBid else {
            currentRound?.points[playerName] = 0
            return 0
        }
        
        guard let currentRound, let bid = currentRound.playerBids[playerName] else {
            fatalError()
        }
        
        let pointsWon = bid == 0 ? 5 + currentRound.handSize : 10 + bid
        currentRound.points[playerName] = pointsWon
        
        return pointsWon
    }
    
    func updateScore() {
        guard let currentRound else {
            return
        }
        
        for player in players {
            let points = currentRound.points[player] ?? 0
            let newScore = scores[player] ?? 0
            scores[player] = points + newScore
        }
    }
        
    // calculate maximum handSize: 3 players -> 17 cards; 4 players -> 12 cards; 5 players -> 10 cards; 6 players -> 8 cards; 7 players -> 7 cards; 8 players -> 6 cards
    func maximumCardCount(numberOfPlayers: Int) -> Int {
        51 / numberOfPlayers
    }
    
    // Calculate bids to make sure the round is over or under bid
    
    // Ending Game determines winner. The winner is the player with the highest score
    
}
