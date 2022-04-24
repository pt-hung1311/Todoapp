//
//  AppNavigator.swift
//  JobLogic
//
//  Created by Pham Hung on 23/04/2022.
//

import Foundation
import UIKit

protocol AppNavigatorType {
    func toMain()
}

struct AppNavigator: AppNavigatorType {
    unowned let assembler: Assembler
    unowned let window: UIWindow
    
    func toMain() {
        let navigation = UINavigationController()
        let vc: MainViewController = assembler.resolve(navigationController: navigation)
        navigation.viewControllers = [vc]
        window.rootViewController = navigation
        window.makeKeyAndVisible()
    }
}
