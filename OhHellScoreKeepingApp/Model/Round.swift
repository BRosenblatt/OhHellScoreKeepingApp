//
//  Round.swift
//  OhHellScoreKeepingApp
//
//  Created by Becca Kauper on 10/16/23.
//

import Foundation

class Round {
    let handSize: Int
    var roundNumber: Int
    var playerBids: [String: Int] = [:]
    var didWinBid: [String: Bool] = [:]
    var points: [String: Int] = [:]
    
    init(roundNumber: Int, handSize: Int) {
        self.roundNumber = roundNumber
        self.handSize = handSize
    }
}
