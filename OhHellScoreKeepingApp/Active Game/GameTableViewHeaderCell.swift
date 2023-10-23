//
//  GameTableViewHeaderCell.swift
//  OhHellScoreKeepingApp
//
//  Created by Matt Kauper on 10/12/23.
//

import UIKit

class GameTableViewHeaderCell: UITableViewCell {
    
    @IBOutlet weak var playerNameLabel: UILabel!
    @IBOutlet weak var bidLabel: UILabel!
    @IBOutlet weak var wonBidLabel: UILabel!
    @IBOutlet weak var pointsEarnedLabel: UILabel!
    @IBOutlet weak var score: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
