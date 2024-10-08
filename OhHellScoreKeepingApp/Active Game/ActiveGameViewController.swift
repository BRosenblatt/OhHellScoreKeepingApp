//
//  ActiveGameViewController.swift
//  OhHellScoreKeepingApp
//
//  Created by Becca Kauper on 10/9/23.
//

import UIKit

class ActiveGameViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, InvalidBidAlertDelegate, EnableNextRoundButton {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var moreOptionsButton: UIButton!
    @IBOutlet weak var handSizeLabel: UILabel! //tracks card count
    @IBOutlet weak var dealerNameLabel: UILabel!
    @IBOutlet weak var nextRoundButton: UIButton!
    
    let gameManager: GameManager = .shared
    var dataController: DataController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        setUpButtonMenu()
        dismissKeyboard()
        updateUI()
        
        let cellNib = UINib(nibName: "GameTableViewCell", bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: "GameTableViewCell")
        
        let headerNib = UINib(nibName: "GameTableViewHeaderCell", bundle: nil)
        tableView.register(headerNib, forCellReuseIdentifier: "GameTableViewHeaderCell")
    }
    
    // MARK: More Options Menu
    func setUpButtonMenu() {
        let restartRoundAction = UIAction(title: "Restart Round") { action in
            self.gameManager.restartRound()
            self.tableView.reloadData()
        }
        
        let endGameAction = UIAction(title: "End Game") { action in
            self.showEndGameAlert()
        }
        
        moreOptionsButton.showsMenuAsPrimaryAction = true
        moreOptionsButton.menu = UIMenu(title: "", children: [restartRoundAction, endGameAction])
    }
    
    @IBAction func nextRoundButtonWasTapped(_ sender: Any) {
        gameManager.updateScore()
        updateUI()
        tableView.reloadData()
    }
    
    func updateUI() {
        gameManager.startNewRound()
        let roundNumber = gameManager.currentRound?.roundNumber ?? 0
        title = "Round: \(roundNumber)"
        let handSize = gameManager.currentRound?.handSize ?? 0
        handSizeLabel.text = "Hand size: \(handSize)"
        let dealerName = gameManager.currentRound?.orderedPlayerList.last ?? ""
        dealerNameLabel.text = "Dealer: \(dealerName)"
        nextRoundButton.isEnabled = false
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
    
    func showEndGameAlert() {
        let alertController = UIAlertController(title: "Are you ready to end this game?", message: "The winner with the highest score will be announced and the game results will be saved to your game history.", preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        alertController.addAction(UIAlertAction(title: "End Game", style: .default, handler: { [weak self] action in
            guard let self else {
                return
            }
            self.gameManager.updateScore()
            self.saveWinnerData()
            self.gameManager.restartRound()
            
            let storyboard = UIStoryboard(name: "Winner", bundle: nil)
            let winnerViewController = storyboard.instantiateViewController(withIdentifier: "WinnerViewController") as! WinnerViewController
            winnerViewController.isModalInPresentation = true
            
            let navigationController = UINavigationController(rootViewController: winnerViewController)
            self.navigationController?.modalPresentationStyle = .fullScreen
            winnerViewController.dataController = self.dataController
            self.present(navigationController, animated: true)
        }))
        
        present(alertController, animated: true)
    }
    
    func saveWinnerData() {
        let gameResult = gameManager.getGameResult()
        let endGame = CompletedGame(context: self.dataController.viewContext)
        endGame.date = gameResult.gameDate
        endGame.winnerImageName = gameResult.winnerImageName
        endGame.winnerName = gameResult.winnerNames.joined(separator: ", ")
        endGame.isATie = gameResult.isATie
        endGame.winnerScore = gameResult.winnerScore
        endGame.winnerImageName = gameResult.winnerImageName
        endGame.identifier = gameResult.gameIdentifier
        try? dataController.viewContext.save()
    }
}

// MARK: - Table view

extension ActiveGameViewController {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        gameManager.players.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GameTableViewCell", for: indexPath) as! GameTableViewCell
        cell.invalidBidAlertDelegate = self
        cell.enableNextRoundButtonDelegate = self

        let playerName = gameManager.currentRound?.orderedPlayerList[indexPath.row] ?? ""
        cell.playerNameLabel.text = playerName
        
        APIClient.getIdenticonFromAPI(playerName: playerName, completion: { image, error in
            if let image = image {
                cell.identiconUIImageView.image = image
            } else { // if retrieving data from API fails, show placeholder system image
                cell.identiconUIImageView.image = UIImage(systemName: "person.crop.circle.badge.exclamationmark.fill")
            } 
            cell.activityIndicator.stopAnimating()
        })
        
        if gameManager.currentRound?.playerBids[playerName] == nil {
            cell.bidTextField.text = ""
            cell.bidSegmentedControl.selectedSegmentIndex = 0
            cell.bidSegmentedControl.isEnabled = false
            print("\(playerName) no bid entered")
        } else if let existingBid = gameManager.currentRound?.playerBids[playerName], gameManager.currentRound?.didWinBid[playerName] == nil {
            cell.bidTextField.text = "\(existingBid)"
            cell.bidSegmentedControl.selectedSegmentIndex = 0
            cell.bidSegmentedControl.isEnabled = true
            print("\(playerName) bit entered")
        } else if let existingBid = gameManager.currentRound?.playerBids[playerName], let didWinBid = gameManager.currentRound?.didWinBid[playerName] {
            cell.bidTextField.text = "\(existingBid)"
            cell.bidSegmentedControl.selectedSegmentIndex = didWinBid ? 1 : 0
            cell.bidSegmentedControl.isEnabled = true
            print("\(playerName) bid and didWinBid entered")
        } else {
            print("this should never happen")
        }
        
        let score = gameManager.scores[playerName] ?? 0
        let points = gameManager.currentRound?.points[playerName] ?? 0
        cell.scoreLabel.text = "\(score + points)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        53
    }
    
    func enableNextRoundButtonIfNeeded() {
        let playersCount = gameManager.players.count
        if gameManager.currentRound?.playerBids.count == playersCount {
            nextRoundButton.isEnabled = true
        } else {
            nextRoundButton.isEnabled = false
        }
    }
    
    func disableNextRoundButton() {
        nextRoundButton.isEnabled = false
    }
    
    func showInvalidBidAlert() {
        let alertController = UIAlertController(title: "Oh Hell!",
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
