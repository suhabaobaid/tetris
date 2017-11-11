//
//  AppRouter.swift
//  swiftris
//
//  Created by Suha Baobaid on 21/08/2017.
//  Copyright © 2017 Suha Baobaid. All rights reserved.
//

import Foundation
import ReSwift

enum RoutingDestination: String {
    case game = "GameViewController"
    case start = "StartViewController"
}

final class AppRouter{
    let navigationController: UINavigationController
    
    init(window: UIWindow) {
        navigationController = UINavigationController()
        window.rootViewController = navigationController
        store.subscribe(self){
            subscription in subscription.select {
                state in state.routingState
            }
        }
    }
    
    fileprivate func pushViewController(identifier: String, animated: Bool) {
        
        let viewController = instantiateViewController(identifier: identifier)
        let newViewControllerType = type(of: viewController)
        if let currentVc = navigationController.topViewController {
            let currentViewControllerType = type(of: currentVc)
            if currentViewControllerType == newViewControllerType {
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
