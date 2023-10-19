//
//  GameTableViewCell.swift
//  OhHellScoreKeepingApp
//
//  Created by Matt Kauper on 10/12/23.
//

import UIKit

class GameTableViewCell: UITableViewCell {
    
    @IBOutlet weak var avatarUIImageView: UIImageView!
    @IBOutlet weak var playerNameLabel: UILabel!
    @IBOutlet weak var bidTextField: UITextField!
    @IBOutlet weak var bidSegmentedControl: UISegmentedControl!
    @IBOutlet weak var pointsLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        avatarUIImageView.image = UIImage(systemName: "person.fill")
    }
}
