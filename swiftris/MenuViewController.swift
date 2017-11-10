//
//  MenuViewController.swift
//  swiftris
//
//  Created by Suha Baobaid on 21/08/2017.
//  Copyright © 2017 Suha Baobaid. All rights reserved.
//

import ReSwift
import UIKit

final class MenuViewController: UITableViewController {
    
    var tableDataSource: TableDataSource<UITableViewCell, String>?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        store.subscribe(self){
            subscription in subscription.select {
                state in state.menuState
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        store.unsubscribe(self)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var routeDestination: RoutingDestination = .menu
        switch (indexPath.row) {
        case 0: routeDestination = .game
        default:
            break
        }
        store.dispatch(RoutingAction(destination: routeDestination))
    }
}

// MARK: StoreSubscriber
extension MenuViewController: StoreSubscriber{
    func newState(state: MenuState){
        tableDataSource = TableDataSource(cellIdentifier: "TitleCell", models: state.menuTitles) {
            cell, model in cell.textLabel?.text = model
            cell.textLabel?.textAlignment = .center
            return cell
        }
        
        tableView.dataSource = tableDataSource
        tableView.reloadData()
    }
}
