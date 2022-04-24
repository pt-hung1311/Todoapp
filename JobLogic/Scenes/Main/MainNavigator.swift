//
//  MainNavigator.swift
//  JobLogic
//
//  Created by Pham Hung on 23/04/2022.
//

import UIKit

protocol MainNavigatorType {
    func toCallList()
    func toBuyList()
    func toSellList()
}

struct MainNavigator: MainNavigatorType {
    unowned let assembler: Assembler
    unowned let navigationController: UINavigationController
    
    func toCallList() {
        let navigation = UINavigationController()
        let vc: CallListViewController = assembler.resolve(navigationController: navigation)
        navigationController.pushViewController(vc, animated: true)
    }
    
    func toBuyList() {
        let navigation = UINavigationController()
        let vc: BuyListViewController = assembler.resolve(navigationController: navigation)
        navigationController.pushViewController(vc, animated: true)
        
    }
    
    func toSellList() {
        let navigation = UINavigationController()
        let vc: SellListViewController = assembler.resolve(navigationController: navigation)
        navigationController.pushViewController(vc, animated: true)
    }
}
