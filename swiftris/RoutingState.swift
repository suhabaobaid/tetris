//
//  RoutingState.swift
//  swiftris
//
//  Created by Suha Baobaid on 21/08/2017.
//  Copyright © 2017 Suha Baobaid. All rights reserved.
//

import Foundation
import ReSwift

struct RoutingState: StateType {
    var navigationState: RoutingDestination
    
    init(navigationState: RoutingDestination = .menu) {
        self.navigationState = navigationState
    }
}
