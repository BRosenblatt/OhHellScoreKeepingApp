//
//  TieGameHistoryTableViewCell.swift
//  OhHellScoreKeepingApp
//
//  Created by Becca Kauper on 2/5/24.
//

import UIKit

class TiedGameHistoryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var tiedWinnerImageView: UIImageView!
    @IBOutlet weak var winnerNamesLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var tiedScoreLabel: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        tiedWinnerImageView.image = UIImage(systemName: "person.3.filled")
    }
}
