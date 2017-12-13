//
//  Utils.swift
//  swiftris
//
//  Created by Suha Baobaid on 10.11.2017.
//  Copyright © 2017 Suha Baobaid. All rights reserved.
//

import Foundation
import UIKit

/*
 * function: takes the UIViewController and sets the navigationbar to be hidden or shown
 * with animation. true -> hide bar 
 */
func setupAnimationForNavigationBar(caseOfFunction: Bool, view: UIViewController) {
    if caseOfFunction == true {
        view.navigationController?.isNavigationBarHidden = true
        UIView.animate(withDuration: 0.5) {
            view.navigationController?.navigationBar.transform = CGAffineTransform(translationX: 0, y: -200)
        }
    } else {
        view.navigationController?.isNavigationBarHidden = false
        UIView.animate(withDuration: 0.5, animations: {
            view.navigationController?.navigationBar.transform = CGAffineTransform.identity
        })
    }
    
}
