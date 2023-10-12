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
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var removePlayerButton: UIButton!
    @IBOutlet weak var addPlayerButton: UIButton!
    @IBOutlet weak var playerName1: UITextField!
    @IBOutlet weak var playerName2: UITextField!
    @IBOutlet weak var playerName3: UITextField!
    @IBOutlet weak var startGameButton: UIButton!
    
    var playerCount = 3
    
    var allTextfields: [UITextField] {
        parentStackView.arrangedSubviews.compactMap { $0 as? UITextField }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playerName1.delegate = self
        playerName2.delegate = self
        playerName3.delegate = self
        startGameButton.isEnabled = false
        
        updateUI()
        addDefaultPlayersForTesting()
    }
    
    func addDefaultPlayersForTesting() {
        playerName1.text = "Matt"
        playerName2.text = "Becca"
        playerName3.text = "Jesse"
    }
    
    // Disable start game button if user is editing textfield
    func textFieldDidBeginEditing(_ textField: UITextField) {
        startGameButton.isEnabled = false
    }
    
    // enable start game button when all textfields contain text
    func textFieldDidEndEditing(_ textField: UITextField) {
        for textField in allTextfields {
            guard textField.hasText else {
                return
            }
        }
        startGameButton.isEnabled = textField.hasText
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    @IBAction func addPlayerButtonWasTapped(_ sender: Any) {
        playerCount += 1
        updateUI()
        addNewTextField()
    }
    
    
    @IBAction func removeButtonWasTapped(_ sender: Any) {
        playerCount -= 1
        updateUI()
        removeTextField()
    }
    
    func updateUI() {
        addPlayerButton.isEnabled = playerCount < 8
        removePlayerButton.isEnabled = playerCount > 3
        numberLabel.text = "\(playerCount)"
    }
    
    // Programmatically add text field when add button is tapped
    func addNewTextField() {
        let newTextField = UITextField()
        newTextField.delegate = self
        newTextField.placeholder = "Enter player's name"
        newTextField.font = .systemFont(ofSize: 14)
        newTextField.borderStyle = .roundedRect
        parentStackView.addArrangedSubview(newTextField)
    }
    
    // Programmatically remove text field when remove button is tapped
    func removeTextField() {
        guard let lastTextField = parentStackView.arrangedSubviews.last else {
            return
        }
        parentStackView.removeArrangedSubview(lastTextField)
        lastTextField.removeFromSuperview()
    }
    
    @IBAction func startGameButtonWasTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "ActiveGame", bundle: nil)
        let activeGameViewController = storyboard.instantiateViewController(withIdentifier: "ActiveGameViewController") as! ActiveGameViewController
        
        let navigationController = UINavigationController(rootViewController: activeGameViewController)
        navigationController.modalPresentationStyle = .fullScreen
        navigationController.navigationBar.prefersLargeTitles = true
        
        present(navigationController, animated: true)
    }
    
    // Dismiss new game view when cancel button is tapped
    @IBAction func cancellButtonWasTapped(_ sender: Any) {
        self.dismiss(animated: true)
    }
}
