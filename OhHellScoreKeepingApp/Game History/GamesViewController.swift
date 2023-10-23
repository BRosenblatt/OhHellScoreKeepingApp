//
//  GamesViewController.swift
//  OhHellScoreKeepingApp
//
//  Created by Becca Kauper on 7/2/23.
//

import UIKit

class GamesViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func addButtonTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "NewGame", bundle: nil)
        let viewController = storyboard.instantiateInitialViewController()!
        present(viewController, animated: true)
    }
    
    // Configure tableview: Show date of game, winnerName, winner image, winner score, and victory quote.
    
}

