//
//  ActiveGameViewController.swift
//  OhHellScoreKeepingApp
//
//  Created by Becca Kauper on 10/9/23.
//

import UIKit

class ActiveGameViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var moreOptionsBarButtonItem: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var handSizeLabel: UILabel! //tracks card count
    
    let gameManager: GameManager = .shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        gameManager.startNewRound()
        
        let cellNib = UINib(nibName: "GameTableViewCell", bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: "GameTableViewCell")
        
        let headerNib = UINib(nibName: "GameTableViewHeaderCell", bundle: nil)
        tableView.register(headerNib, forCellReuseIdentifier: "GameTableViewHeaderCell")
        
        let handSize = gameManager.currentRound?.handSize ?? 0
        handSizeLabel.text = "Hand size: \(handSize)"
        
        let roundNumber = gameManager.currentRound?.roundNumber ?? 0
        title = "Round: \(roundNumber)"
    }
    
// MARK: More Options Menu
    
    // Restart Round clears bids, segmented control, and resets score
        
    // End Game ends the entire game. Shows winner! Adds to game history. Cannot restart or edit game.
    
}

// MARK: - Table view

extension ActiveGameViewController {
    
    // MARK: - Set up table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        gameManager.players.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GameTableViewCell", for: indexPath) as! GameTableViewCell
        
        cell.playerNameLabel.text = gameManager.players[indexPath.row]
        cell.playerNameLabel.numberOfLines = .zero

        return cell
    }
    
    func showReCalculateBidsAlert() {
        let alertViewController = UIAlertController(title: nil, message: "The total bid entries cannot equal the number of cards in the hand. Please adjust the last bid to be over or under the card count.", preferredStyle: .alert)
        alertViewController.addAction(UIAlertAction(title: "OK", style: .default))
        
        present(alertViewController, animated: true)
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
