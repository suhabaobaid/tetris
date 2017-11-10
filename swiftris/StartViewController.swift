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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    @IBAction func startGamePressed(_ sender: UIButton) {
        let routeDestination: RoutingDestination = .game
        store.dispatch(RoutingAction(destination: routeDestination))
    }
    
}



