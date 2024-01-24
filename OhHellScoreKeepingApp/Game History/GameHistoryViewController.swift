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
        let completedGameCell = tableView.dequeueReusableCell(withIdentifier: "GameHistoryTableViewCell", for: indexPath) as! GameHistoryTableViewCell
        
        if completedGames.isEmpty == false {
            let completedGame = completedGames[indexPath.item]
            completedGameCell.winnerNameLabel.text = completedGame.winnerName
            completedGameCell.dateLabel.text = completedGame.date
            completedGameCell.winnerScoreLabel.text = completedGame.winnerScore
            completedGameCell.victoryQuoteLabel.text = completedGame.winnerVictoryQuote
            completedGameCell.victoryQuoteLabel.numberOfLines = 0
            
            return completedGameCell
        } else {
            defaultCell.defaultLabel.text = #"You have 0 completed games. Tap the "+" button to start your first game!"#
            defaultCell.defaultLabel.numberOfLines = 0
            
            return defaultCell
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

