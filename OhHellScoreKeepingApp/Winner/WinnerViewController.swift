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
    @IBOutlet weak var winnerLabel: UILabel!
    @IBOutlet weak var victoryQuoteStackView: UIStackView!
    @IBOutlet weak var doneButton: UIButton!
    
    let gameManager: GameManager = .shared
    var dataController: DataController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        victoryQuoteTextField.delegate = self
        updateUI()
        winnerName.text = gameManager.determineWinnerNames().joined(separator: ", ")
    }
    
    func updateUI() {
        if gameManager.determineTie() {
            winnerLabel.text = "Winners"
            victoryQuoteStackView.isHidden = true
            doneButton.isEnabled = true
        } else {
            doneButton.isEnabled = false
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        doneButton.isEnabled = false
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        var newText = textField.text! as NSString
        newText = newText.replacingCharacters(in: range, with: string) as NSString
                    
        return newText.length <= 20
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        doneButton.isEnabled = true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    @IBAction func submitButtonWasTapped(_ sender: Any) {
        saveVictoryQuote()
        let presenter = presentingViewController
        dismiss(animated: true) {
            presenter?.dismiss(animated: true)
            self.gameManager.resetGameData()
        }
    }
    
    func saveVictoryQuote() {
        guard victoryQuoteTextField.text != nil else {
            return print("User did not enter a victory quote")
        }

        let currentGameResult = gameManager.getGameResult()
        let fetchRequest = CompletedGame.fetchRequest()
        let predicate = NSPredicate(format: "identifier == %@", currentGameResult.gameIdentifier)
        fetchRequest.predicate = predicate
        
        do {
            let currentGame = try dataController.viewContext.fetch(fetchRequest).first
            currentGame?.winnerVictoryQuote = victoryQuoteTextField.text
            try? dataController.viewContext.save()
        } catch {
            print("Couldn't fetch current game; error: \(error)")
        }
    }
}
