//
//  AppReducer.swift
//  swiftris
//  To hold the reducer functions of the application
//
//  Created by Suha Baobaid on 21/08/2017.
//  Copyright © 2017 Suha Baobaid. All rights reserved.
//

import Foundation
import ReSwift

func appReducer(action: Action, state: AppState?) -> AppState {
    return AppState(routingState: routingReducer(action: action, state: state?.routingState), menuState: menuReducer(action: action, state: state?.menuState))
}
