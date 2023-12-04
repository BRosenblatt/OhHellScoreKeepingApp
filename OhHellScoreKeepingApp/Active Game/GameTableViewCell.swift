//
//  GameTableViewCell.swift
//  OhHellScoreKeepingApp
//
//  Created by Becca Kauper on 10/12/23.
//

import UIKit

protocol InvalidBidAlertDelegate: UIViewController {
    func showInvalidBidAlert()
}

class GameTableViewCell: UITableViewCell, UITextFieldDelegate {
    
    @IBOutlet weak var avatarUIImageView: UIImageView!
    @IBOutlet weak var playerNameLabel: UILabel!
    @IBOutlet weak var bidTextField: UITextField!
    @IBOutlet weak var bidSegmentedControl: UISegmentedControl!
    @IBOutlet weak var pointsLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    let gameManager: GameManager = .shared
    weak var delegate: InvalidBidAlertDelegate?
    
    var playerName: String {
        playerNameLabel.text ?? ""
    }
    
    var bidText: String {
        bidTextField.text ?? ""
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        bidTextField.delegate = self
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        avatarUIImageView.image = UIImage(systemName: "person.fill")
        playerNameLabel.numberOfLines = .zero
        bidTextField.text = ""
        bidSegmentedControl.selectedSegmentIndex = 0
        pointsLabel.text = "0"
        scoreLabel.text = ""
    }
    
    // MARK: - Set up text field
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        var newText = textField.text! as NSString
        newText = newText.replacingCharacters(in: range, with: string) as NSString
                    
        return newText.length <= 2
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let bid = Int(bidText) else {
            print("something went wrong")
            return
        }
        
        gameManager.addBidForPlayer(bid: bid, playerName: playerName)
        
        if gameManager.currentRound?.hasInvalidBids == true {
            delegate?.showInvalidBidAlert()
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func bidSegmentedControlWasTapped(_ sender: Any) {
        let didWin = bidSegmentedControl.selectedSegmentIndex == 1
        
        let currentScore = gameManager.scores[playerName] ?? 0
        let points = gameManager.updateRoundPoints(for: playerName, didWinBid: didWin)
        pointsLabel.text = "\(points)"
        scoreLabel.text = "\(currentScore + points)"
    }
}
