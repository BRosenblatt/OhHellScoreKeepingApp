//
//  GameHistoryViewController.swift
//  OhHellScoreKeepingApp
//
//  Created by Becca Kauper on 7/2/23.
//

import UIKit

class GameHistoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    let gameManager: GameManager = .shared
    var dataController: DataController!
    var completedGames: [CompletedGame] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        title = "Game History"
        
        let barButtonItem = UIBarButtonItem(systemItem: .add)
        barButtonItem.action = #selector(addButtonTapped)
        barButtonItem.target = self
        navigationItem.rightBarButtonItem = barButtonItem
        
        let cellNib = UINib(nibName: "GameHistoryTableViewCell", bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: "GameHistoryTableViewCell")
        
        let tiedGameCellNib = UINib(nibName: "TiedGameHistoryTableViewCell", bundle: nil)
        tableView.register(tiedGameCellNib, forCellReuseIdentifier: "TiedGameHistoryTableViewCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        completedGames = fetchCompletedGamesFromCoreData()
        tableView.reloadData()
    }

    @objc func addButtonTapped() {
        let storyboard = UIStoryboard(name: "NewGame", bundle: nil)
        let viewController = storyboard.instantiateInitialViewController()! as! UINavigationController
        let newGameViewController = viewController.viewControllers.first as! NewGameViewController
        newGameViewController.dataController = dataController
        present(viewController, animated: true)
    }
}

extension GameHistoryViewController {
    // Configure tableview: Show date of game, winnerName, winner image, winner score, and victory quote.
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if completedGames.isEmpty == false {
            return completedGames.count
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let defaultCell = tableView.dequeueReusableCell(withIdentifier: "DefaultTableViewCell", for: indexPath) as! DefaultTableViewCell
        let singleWinnerGameCell = tableView.dequeueReusableCell(withIdentifier: "GameHistoryTableViewCell", for: indexPath) as! GameHistoryTableViewCell
        let tiedWinnersGameCell = tableView.dequeueReusableCell(withIdentifier: "TiedGameHistoryTableViewCell", for: indexPath) as! TiedGameHistoryTableViewCell
                
        guard !completedGames.isEmpty else {
            defaultCell.defaultLabel.text = #"You have 0 completed games. Tap the "+" button to start your first game!"#
            defaultCell.defaultLabel.numberOfLines = 0
            return defaultCell
        }
        
        let completedGame = completedGames[indexPath.item]
        
        if completedGame.isATie {
            tiedWinnersGameCell.winnerNamesLabel.text = completedGame.winnerName
            tiedWinnersGameCell.dateLabel.text = DateFormatter.localizedString(from: completedGame.date ?? .now, dateStyle: .short, timeStyle: .none)
            tiedWinnersGameCell.tiedScoreLabel.text = completedGame.winnerScore
            tiedWinnersGameCell.tiedWinnerImageView.image = UIImage(systemName: "person.3.fill")
            return tiedWinnersGameCell
        } else {
            singleWinnerGameCell.winnerNameLabel.text = completedGame.winnerName
            singleWinnerGameCell.dateLabel.text = DateFormatter.localizedString(from: completedGame.date ?? .now, dateStyle: .short, timeStyle: .none)
            singleWinnerGameCell.winnerScoreLabel.text = completedGame.winnerScore
            let victoryQuoteString = completedGame.winnerVictoryQuote ?? ""
            singleWinnerGameCell.victoryQuoteLabel.text = "\"\(victoryQuoteString)\""
            singleWinnerGameCell.victoryQuoteLabel.numberOfLines = 0
            
            APIClient.getIdenticonFromAPI(playerName: completedGame.winnerName ?? "winner") { image, error in
                if let image = image {
                    singleWinnerGameCell.winnerImageView.image = image
                } else { // if retrieving data from API fails, show placeholder system image
                    singleWinnerGameCell.winnerImageView.image = UIImage(systemName: "person.crop.circle.badge.exclamationmark.fill")
                }
            }
            return singleWinnerGameCell
        }
    }
    
    func fetchCompletedGamesFromCoreData() -> [CompletedGame] {
        let fetchRequest = CompletedGame.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "date", ascending: false)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        do {
            let completedGames = try dataController.viewContext.fetch(fetchRequest)
            return completedGames
        } catch {
            print("Couldn't fetch completed games; error: \(error)")
            return []
        }
    }
}

