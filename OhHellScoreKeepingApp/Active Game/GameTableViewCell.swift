//
//  GameTableViewCell.swift
//  OhHellScoreKeepingApp
//
//  Created by Matt Kauper on 10/10/23.
//

import Foundation
import UIKit

class GameTableViewCell: UITableViewCell {
    @IBOutlet weak var playerNameLabel: UILabel!
    @IBOutlet weak var bidTextField: UITextField!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var scoreLabel: UILabel!
}
