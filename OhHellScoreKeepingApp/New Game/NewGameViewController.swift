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
    var cardCount = 2
    let gameManager: GameManager = .shared
    var dataController: DataController!
    
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
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        startGameButton.isEnabled = false
    }
    
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
        calculatemaxHandSize()
    }
    
    func calculatemaxHandSize() {
        let maxHandSize = gameManager.maximumCardCount(numberOfPlayers: playerCount)
        increaseCardCountButton.isEnabled = cardCount < maxHandSize
        decreaseCardCountButton.isEnabled = cardCount > 2
        
        if cardCount > maxHandSize {
            cardCount = maxHandSize
        }
        
        numberOfCardsLabel.text = "\(cardCount)"
    }
    
    func addNewTextField() {
        let newTextField = UITextField()
        newTextField.delegate = self
        newTextField.placeholder = "Enter player's name"
        newTextField.font = .systemFont(ofSize: 14)
        newTextField.borderStyle = .roundedRect
        textFieldStackView.addArrangedSubview(newTextField)
    }
    
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
        
        gameManager.createGame(playerNames: playerNames, gameOrder: gameOrder, maxHandSize: cardCount)
        
        let storyboard = UIStoryboard(name: "ActiveGame", bundle: nil)
        let activeGameViewController = storyboard.instantiateViewController(withIdentifier: "ActiveGameViewController") as! ActiveGameViewController
        
        let navigationController = UINavigationController(rootViewController: activeGameViewController)
        navigationController.modalPresentationStyle = .fullScreen
        navigationController.navigationBar.prefersLargeTitles = true
        activeGameViewController.dataController = dataController
        let presentingController = presentingViewController
        
        dismiss(animated: true) {
            presentingController?.present(navigationController, animated: true)
        }
    }
    
    func getPlayerNames() -> [String] {
        return allTextfields.compactMap { (textField) -> String? in
            textField.text
        }
    }
    
    @IBAction func cancellButtonWasTapped(_ sender: Any) {
        dismiss(animated: true)
    }
}
