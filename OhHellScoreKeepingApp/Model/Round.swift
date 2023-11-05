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
    
    var hasInvalidBids: Bool {
        let bidsTotal = playerBids.values.reduce(0, +)
        let allBidsHaveBeenEntered = playerBids.count == orderedPlayerList.count
        
       return bidsTotal == handSize && allBidsHaveBeenEntered
    }
    
    init(roundNumber: Int, handSize: Int, orderedPlayerList: [String]) {
        self.roundNumber = roundNumber
        self.handSize = handSize
        self.orderedPlayerList = orderedPlayerList
    }
}
