//
//  GameHistoryViewController.swift
//  OhHellScoreKeepingApp
//
//  Created by Becca Kauper on 7/2/23.
//

import UIKit

class GameHistoryViewController: UIViewController/*, UITableViewDelegate, UITableViewDataSource*/ {
    
    @IBOutlet weak var tableView: UITableView!
    
    let gameManager: GameManager = .shared
    var dataController: DataController!

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Your Completed Games"
        
        let barButtonItem = UIBarButtonItem(systemItem: .add)
        barButtonItem.action = #selector(addButtonTapped)
        navigationItem.rightBarButtonItem = barButtonItem
        
        let cellNib = UINib(nibName: "DefaultTableViewCell", bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: "DefaultTableViewCell")
    }

    @objc func addButtonTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "NewGame", bundle: nil)
        let viewController = storyboard.instantiateInitialViewController()! as! UINavigationController
        let newGameViewController = viewController.viewControllers.first as! NewGameViewController
        newGameViewController.dataController = dataController
        present(viewController, animated: true)
    }
}

extension GameHistoryViewController {
    // Configure tableview: Show date of game, winnerName, winner image, winner score, and victory quote.
    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        
//    }
}

