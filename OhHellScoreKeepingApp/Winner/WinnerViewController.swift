//
//  WinnerViewController.swift
//  OhHellScoreKeepingApp
//
//  Created by Becca Kauper on 12/5/23.
//

import Foundation
import UIKit

class WinnerViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var winnerName: UILabel!
    @IBOutlet weak var victoryQuoteTextField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    
    let gameManager: GameManager = .shared
    var dataController: DataController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        victoryQuoteTextField.delegate = self
        submitButton.isEnabled = false
        winnerName.text = gameManager.determineWinnerName()
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
        saveVictoryQuote()
        dismiss(animated: true)
    }
    
    func saveVictoryQuote() {
        guard victoryQuoteTextField.text != nil else {
            return print("User did not enter a victory quote")
        }
        
        let winnerVictory = CompletedGame(context: self.dataController.viewContext)
        winnerVictory.winnerVictoryQuote = victoryQuoteTextField.text
        
        try? dataController.viewContext.save()
        print("saving victory quote")
    }
}
