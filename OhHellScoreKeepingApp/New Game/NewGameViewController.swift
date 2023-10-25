//
//  NewGameViewController.swift
//  OhHellScoreKeepingApp
//
//  Created by Becca Kauper on 7/2/23.
//

import UIKit

class NewGameViewController: UIViewController, UITextFieldDelegate {
        
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var parentStackView: UIStackView!
    @IBOutlet weak var numberofPlayersLabel: UILabel!
    @IBOutlet weak var removePlayerButton: UIButton!
    @IBOutlet weak var addPlayerButton: UIButton!
    @IBOutlet weak var textFieldStackView: UIStackView!
    @IBOutlet weak var playerName1: UITextField!
    @IBOutlet weak var playerName2: UITextField!
    @IBOutlet weak var playerName3: UITextField!
    @IBOutlet weak var numberOfCardsLabel: UILabel!
    @IBOutlet weak var decreaseCardCountButton: UIButton!
    @IBOutlet weak var increaseCardCountButton: UIButton!
    @IBOutlet weak var gameOrderSegmentedControl: UISegmentedControl!
    @IBOutlet weak var startGameButton: UIButton!
    
    var playerCount = 3
    var cardCount = 1
    let gameManager: GameManager = .shared
    
    var allTextfields: [UITextField] {
        textFieldStackView.arrangedSubviews.compactMap { $0 as? UITextField }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playerName1.delegate = self
        playerName2.delegate = self
        playerName3.delegate = self
        startGameButton.isEnabled = false
        
        updateUI()
    }
    
    // Disable start game button if user is editing textfield
    func textFieldDidBeginEditing(_ textField: UITextField) {
        startGameButton.isEnabled = false
    }
    
    // enable start game button when all textfields contain text
    func textFieldDidEndEditing(_ textField: UITextField) {
        for textField in allTextfields {
            guard textField.hasText else {
                startGameButton.isEnabled = false
                return
            }
        }
        startGameButton.isEnabled = true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func addPlayerButtonWasTapped(_ sender: Any) {
        playerCount += 1
        addNewTextField()
        updateUI()
    }
    
    @IBAction func removeButtonWasTapped(_ sender: Any) {
        playerCount -= 1
        removeTextField()
        updateUI()
    }
    
    func updateUI() {
        addPlayerButton.isEnabled = playerCount < 8
        removePlayerButton.isEnabled = playerCount > 3
        numberofPlayersLabel.text = "\(playerCount)"
        calculateMaxCardCount()
    }
    
    func calculateMaxCardCount() {
        let maxCardCount = gameManager.maximumCardCount(numberOfPlayers: playerCount)
        increaseCardCountButton.isEnabled = cardCount < maxCardCount
        decreaseCardCountButton.isEnabled = cardCount > 1
        
        if cardCount > maxCardCount {
            cardCount = maxCardCount
        }
        
        numberOfCardsLabel.text = "\(cardCount)"
    }
    
    // Programmatically add text field when add button is tapped
    func addNewTextField() {
        let newTextField = UITextField()
        newTextField.delegate = self
        newTextField.placeholder = "Enter player's name"
        newTextField.font = .systemFont(ofSize: 14)
        newTextField.borderStyle = .roundedRect
        textFieldStackView.addArrangedSubview(newTextField)
    }
    
    // Programmatically remove text field when remove button is tapped
    func removeTextField() {
        guard let lastTextField = textFieldStackView.arrangedSubviews.last else {
            return
        }
        textFieldStackView.removeArrangedSubview(lastTextField)
        lastTextField.removeFromSuperview()
    }
    
    
    @IBAction func increaseCardCountButtonWasTapped(_ sender: Any) {
        cardCount += 1
        updateUI()
    }
    
    @IBAction func decreaseCardCountButtonWasTapped(_ sender: Any) {
        cardCount -= 1
        updateUI()
    }
    
    @IBAction func startGameButtonWasTapped(_ sender: Any) {
        let playerNames = getPlayerNames()
        let gameOrder: GameOrder = gameOrderSegmentedControl.selectedSegmentIndex == .zero ? .descending : .ascending
        
        gameManager.createGame(playerNames: playerNames, gameOrder: gameOrder, maxCardCount: cardCount)
        
        let storyboard = UIStoryboard(name: "ActiveGame", bundle: nil)
        let activeGameViewController = storyboard.instantiateViewController(withIdentifier: "ActiveGameViewController") as! ActiveGameViewController
        
        let navigationController = UINavigationController(rootViewController: activeGameViewController)
        navigationController.modalPresentationStyle = .fullScreen
        navigationController.navigationBar.prefersLargeTitles = true
                
        present(navigationController, animated: true)
    }
    
    func getPlayerNames() -> [String] {
        return allTextfields.compactMap { (textField) -> String? in
            textField.text
        }
    }
    
    // Dismiss new game view when cancel button is tapped
    @IBAction func cancellButtonWasTapped(_ sender: Any) {
        self.dismiss(animated: true)
    }
}
