//
//  StartViewController.swift
//  swiftris
//
//  Created by Suha Baobaid on 9.11.2017.
//  Copyright © 2017 Suha Baobaid. All rights reserved.
//

import ReSwift
import UIKit

final class StartViewController: UIViewController {
    
    @IBOutlet weak var startGameButton: UIButton!
 
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupAnimationForNavigationBar(caseOfFunction: true, view: self)
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background")!)
        
        startGameButton.layer.cornerRadius = 4

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    @IBAction func startGamePressed(_ sender: UIButton) {
        let routeDestination: RoutingDestination = .game
        store.dispatch(RoutingAction(destination: routeDestination))
    }
    
}
