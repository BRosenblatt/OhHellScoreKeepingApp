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
    @IBOutlet weak var winnerLabel: UILabel!
    @IBOutlet weak var victoryQuoteStackView: UIStackView!
    
    let gameManager: GameManager = .shared
    var dataController: DataController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        victoryQuoteTextField.delegate = self
        updateUIForTies()
        winnerName.text = gameManager.determineWinnerNames().joined(separator: ", ")
    }
    
    func updateUIForTies() {
        if gameManager.determineTie() {
            winnerLabel.text = "Winners"
            victoryQuoteStackView.isHidden = true
            submitButton.isEnabled = true
        } else {
            submitButton.isEnabled = false
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        submitButton.isEnabled = false
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        var newText = textField.text! as NSString
        newText = newText.replacingCharacters(in: range, with: string) as NSString
                    
        return newText.length <= 20
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
        
        // fetch the completed game that you want (i.e. whose identifier matches currentGameResult)
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
