//
//  ActiveGameViewController.swift
//  OhHellScoreKeepingApp
//
//  Created by Becca Kauper on 10/9/23.
//

import UIKit

class ActiveGameViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, InvalidBidAlertDelegate {
    
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var moreOptionsBarButtonItem: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var handSizeLabel: UILabel! //tracks card count
    @IBOutlet weak var dealerNameLabel: UILabel!
    
    let gameManager: GameManager = .shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        dismissKeyboard()
        updateUI()
        
        let cellNib = UINib(nibName: "GameTableViewCell", bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: "GameTableViewCell")
        
        let headerNib = UINib(nibName: "GameTableViewHeaderCell", bundle: nil)
        tableView.register(headerNib, forCellReuseIdentifier: "GameTableViewHeaderCell")
    }
    
// MARK: More Options Menu
    
    // Restart Round clears bids, segmented control, and resets score
        
    // End Game ends the entire game. Shows winner! Adds to game history. Cannot restart or edit game.
    
    @IBAction func nextRoundButtonWasTapped(_ sender: Any) {
        gameManager.updateScore()
        updateUI()
        tableView.reloadData()
        // clear textFields and reset segmented control, points
    }
    
    func updateUI() {
        gameManager.startNewRound()
        let roundNumber = gameManager.currentRound?.roundNumber ?? 0
        title = "Round: \(roundNumber)"
        let handSize = gameManager.currentRound?.handSize ?? 0
        handSizeLabel.text = "Hand size: \(handSize)"
        let dealerName = gameManager.currentRound?.orderedPlayerList.last ?? ""
        dealerNameLabel.text = "Dealer: \(dealerName)"
    }
    
    // Source credit for the following code: https://medium.com/@vvishwakarma/dismiss-hide-keyboard-when-touching-outside-of-uitextfield-swift-166d9d1efb68
    func dismissKeyboard() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(keyboardWasDismissedOnTap))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    // Source credit for the following code: https://medium.com/@vvishwakarma/dismiss-hide-keyboard-when-touching-outside-of-uitextfield-swift-166d9d1efb68
    @objc private func keyboardWasDismissedOnTap() {
        view.endEditing(true)
    }
}

// MARK: - Table view

extension ActiveGameViewController {
    
    // MARK: - Set up table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        gameManager.players.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GameTableViewCell", for: indexPath) as! GameTableViewCell
        cell.delegate = self
        let playerName = gameManager.currentRound?.orderedPlayerList[indexPath.row] ?? ""
        cell.playerNameLabel.text = playerName
        
        let score = gameManager.scores[playerName] ?? 0
        let points = gameManager.currentRound?.points[playerName] ?? 0
        cell.scoreLabel.text = "\(score + points)"
        
        return cell
    }
    
    func showInvalidBidAlert() {
        let alertController = UIAlertController(title: nil,
                                                message: "The total bid entries cannot equal the number of cards in the hand. Please adjust the last bid to be over or under the card count.",
                                                preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default))
        
        present(alertController, animated: true)
    }
    
    // MARK: - Set up table header
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let tableHeaderCell = tableView.dequeueReusableCell(withIdentifier: "GameTableViewHeaderCell") as! GameTableViewHeaderCell
        
        return tableHeaderCell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 46
    }
}
