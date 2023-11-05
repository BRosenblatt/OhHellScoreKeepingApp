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
    let orderedPlayerList: [String]
    var playerBids: [String: Int] = [:]
    var didWinBid: [String: Bool] = [:]
    var points: [String: Int] = [:]
        
    init(roundNumber: Int, handSize: Int, orderedPlayerList: [String]) {
        self.roundNumber = roundNumber
        self.handSize = handSize
        self.orderedPlayerList = orderedPlayerList
    }
}
