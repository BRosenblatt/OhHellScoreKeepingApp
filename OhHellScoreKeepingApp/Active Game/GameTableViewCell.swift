//
//  GameTableViewCell.swift
//  OhHellScoreKeepingApp
//
//  Created by Becca Kauper on 10/12/23.
//

import UIKit

protocol EnableNextRoundButton: UIViewController {
    func enableNextRoundButtonIfNeeded()
    func disableNextRoundButton()
}

protocol InvalidBidAlertDelegate: UIViewController {
    func showInvalidBidAlert()
}

class GameTableViewCell: UITableViewCell, UITextFieldDelegate {
    
    @IBOutlet weak var identiconUIImageView: UIImageView!
    @IBOutlet weak var playerNameLabel: UILabel!
    @IBOutlet weak var bidTextField: UITextField!
    @IBOutlet weak var bidSegmentedControl: UISegmentedControl!
    @IBOutlet weak var pointsLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    let gameManager: GameManager = .shared
    weak var invalidBidAlertDelegate: InvalidBidAlertDelegate?
    weak var enableNextRoundButtonDelegate: EnableNextRoundButton?
    
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
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        bidSegmentedControl.isEnabled = false
        enableNextRoundButtonDelegate?.disableNextRoundButton()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let bid = Int(bidText) else {
            return
        }
     
        gameManager.addBidForPlayer(bid: bid, playerName: playerName)
        
        if gameManager.currentRound?.hasInvalidBids == true {
            invalidBidAlertDelegate?.showInvalidBidAlert()
        } else {
            bidSegmentedControl.isEnabled = true
            enableNextRoundButtonDelegate?.enableNextRoundButtonIfNeeded()
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
