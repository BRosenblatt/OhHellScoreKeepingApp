//
//  WinnerViewController.swift
//  OhHellScoreKeepingApp
//
//  Created by Matt Kauper on 12/5/23.
//

import Foundation
import UIKit

class WinnerViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var winnerName: UILabel!
    @IBOutlet weak var victoryQuoteTextField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    
    let gameManager: GameManager = .shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        victoryQuoteTextField.delegate = self
        submitButton.isEnabled = false
        winnerName.text = gameManager.determineWinner()
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        submitButton.isEnabled = false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        submitButton.isEnabled = true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    @IBAction func submitButtonWasTapped(_ sender: Any) {
        // save victory quote
    }
}
