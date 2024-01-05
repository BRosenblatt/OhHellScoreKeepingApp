//
//  GameHistoryTableViewCell.swift
//  OhHellScoreKeepingApp
//
//  Created by Becca Kauper on 1/3/24.
//

import UIKit

class GameHistoryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var winnerImageView: UIImageView!
    @IBOutlet weak var winnerNameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var winnerScoreLabel: UILabel!
    @IBOutlet weak var victoryQuoteLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
