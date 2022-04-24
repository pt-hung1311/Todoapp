//
//  SellListNavigator.swift
//  JobLogic
//
//  Created by Pham Hung on 23/04/2022.
//

import UIKit

protocol SellListNavigatorType {
    
}

struct SellListNavigator: SellListNavigatorType {
    unowned let assembler: Assembler
    unowned let navigationController: UINavigationController
}
