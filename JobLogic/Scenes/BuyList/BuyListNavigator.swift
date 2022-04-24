//
//  BuyListNavigator.swift
//  JobLogic
//
//  Created by Pham Hung on 23/04/2022.
//

import UIKit

protocol BuyListNavigatorType {
    
}

struct BuyListNavigator: BuyListNavigatorType {
    unowned let assembler: Assembler
    unowned let navigationController: UINavigationController
}
