//
//  MainAssembler.swift
//  JobLogic
//
//  Created by Pham Hung on 23/04/2022.
//

import UIKit

protocol MainAssembler {
    func resolve(navigationController: UINavigationController) -> MainViewController
    func resolve(navigationController: UINavigationController) -> MainViewModel
    func resolve(navigationController: UINavigationController) -> MainNavigatorType
    func resolve() -> MainExecuteType
}

extension MainAssembler {
    func resolve(navigationController: UINavigationController) -> MainViewController {
        guard let vc = Storyboards.main.instantiateViewController(withIdentifier: "MainViewController") as? MainViewController else {
            fatalError("Can not cast to MainViewController")
        }
        let vm: MainViewModel = resolve(navigationController: navigationController)
        vc.bindViewModel(to: vm)
        return vc
    }

    func resolve(navigationController: UINavigationController) -> MainViewModel {
        return MainViewModel(
            navigator: resolve(navigationController: navigationController),
            execute: resolve()
        )
    }
}

extension MainAssembler where Self: DefaultAssembler {
    func resolve(navigationController: UINavigationController) -> MainNavigatorType {
        return MainNavigator(assembler: self, navigationController: navigationController)
    }

    func resolve() -> MainExecuteType {
        return MainExecute()
    }
}
