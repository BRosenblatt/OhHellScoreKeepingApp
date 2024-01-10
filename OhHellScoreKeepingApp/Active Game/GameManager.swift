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
    private(set) var currentGameIdentifierString: String = ""

    let dateFormatter: DateFormatter
    
    var currentRound: Round? {
        rounds.last
    }
    
    static let shared: GameManager = GameManager()
    
    private init() {
        self.dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
    }

    // start a game with these players
    func createGame(playerNames: [String], gameOrder: GameOrder, maxHandSize: Int) {
        currentGameIdentifierString = UUID().uuidString
        
        if gameOrder == .descending {
            startingHandSize = maxHandSize
        } else {
            startingHandSize = 1
        }
        
        self.gameOrder = gameOrder
        self.maxHandSize = maxHandSize
        
        players = playerNames // also sets starting order of the players
        playerNames.forEach({ playerName in
            scores[playerName] = 0
        })
    }
    
    // start new round; players can play as many rounds as they want
    func startNewRound() {
        var handSize: Int = startingHandSize
        
        if let round = rounds.last {
            handSize = nextRoundHandSize(previousRound: round)
        }
        
        let newRoundOrderedPlayers = orderedPlayers(for: currentRound?.orderedPlayerList)
        let newRound = Round(roundNumber: rounds.count + 1, handSize: handSize, orderedPlayerList: newRoundOrderedPlayers)
        
        rounds.append(newRound)
    }
    
    private func orderedPlayers(for previousRound: [String]?) -> [String] {
        guard let previousRound else {
            return players
        }
        
        // get the previous round
        var nextRoundOrderedPlayers = previousRound
        
        // make the last player the new dealer
        let newDealer = nextRoundOrderedPlayers.remove(at: 0)
        nextRoundOrderedPlayers.append(newDealer)
        
        return nextRoundOrderedPlayers
    }
    
    func nextRoundHandSize(previousRound: Round) -> Int {
        var newHandSize: Int
        
        if previousRound.handSize == maxHandSize {
            newHandSize = maxHandSize - 1
            gameOrder = .descending
        } else if previousRound.handSize == 1 {
            newHandSize = previousRound.handSize + 1
            gameOrder = .ascending
        } else {
            newHandSize = gameOrder == .ascending ? previousRound.handSize + 1 : previousRound.handSize - 1
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
    
    func restartRound() {
        guard let currentRound else {
            return
        }
        // revert bid entries
        currentRound.playerBids = [:]
        // revert didWinBid
        currentRound.didWinBid = [:]
        // revert points
        currentRound.points = [:]
    }
    
    // Ending Game determines winner. The winner is the player with the highest score. What happens with a tie?

    func determineWinnerName() -> String {
        let winnerScore = scores.values.max()
        let winnerName = scores.first(where: { $0.value == winnerScore})?.key ?? ""
        
        return winnerName
    }
    
    func determineWinnerScore() -> String {
        let score: String = "\(scores.values.max() ?? 0)"
        return score
    }
    
    func determineWinnerImageName() -> String {
        return ""
    }
    
    func getGameResult() -> GameResult {
        let gameDate = dateFormatter.string(from: Date())
        return GameResult(winnerName: determineWinnerName(),
                          winnerScore: determineWinnerScore(),
                          winnerImageName: determineWinnerImageName(),
                          gameDate: gameDate,
                          gameIdentifier: currentGameIdentifierString)
    }
}
