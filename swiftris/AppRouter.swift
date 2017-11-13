//
//  AppRouter.swift
//  swiftris
//
//  Created by Suha Baobaid on 21/08/2017.
//  Copyright © 2017 Suha Baobaid. All rights reserved.
//


/*
 * Class that react to changes of the routingState value and show the current destination on the screen
 */

import Foundation
import ReSwift
import UIKit

enum RoutingDestination: String {
    case game = "GameViewController"
    case start = "StartViewController"
}

final class AppRouter{
    let navigationController: UINavigationController
    
    // Subscribes to the global store for the routing state only
    init(window: UIWindow) {
        navigationController = UINavigationController()
        window.rootViewController = navigationController
        
        store.subscribe(self){
            subscription in subscription.select {
                state in state.routingState
            }
        }
    }
    
    // instantiates a view controller and pushes it into the naviagation stack
    fileprivate func pushViewController(identifier: String, animated: Bool) {
        
        let viewController = instantiateViewController(identifier: identifier)
        let newViewControllerType = type(of: viewController)
        if let currentVc = navigationController.topViewController {
            let currentViewControllerType = type(of: currentVc)
            if currentViewControllerType == newViewControllerType {
                return
            }
            // if the mainMenu is pressed then pop the top ViewController from the stack
            if identifier == "StartViewController" {
                navigationController.popViewController(animated: animated)
                return
            }
        }
        
        navigationController.pushViewController((viewController), animated: animated)
    }
    
    fileprivate func instantiateViewController(identifier: String) -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        return storyboard.instantiateViewController(withIdentifier: identifier)
    }
    
}

// MARK: store subscription
extension AppRouter: StoreSubscriber {
    func newState(state: RoutingState) {
        let shouldAnimate = navigationController.topViewController != nil
        pushViewController(identifier: state.navigationState.rawValue, animated: shouldAnimate)
    }
}
