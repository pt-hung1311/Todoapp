//
//  SellListAssembler.swift
//  JobLogic
//
//  Created by Pham Hung on 23/04/2022.
//

import UIKit

protocol SellListAssembler {
    func resolve(navigationController: UINavigationController) -> SellListViewController
    func resolve(navigationController: UINavigationController) -> SellListViewModel
    func resolve(navigationController: UINavigationController) -> SellListNavigatorType
    func resolve() -> SellListExecuteType
}

extension SellListAssembler {
    func resolve(navigationController: UINavigationController) -> SellListViewController {
        guard let vc = Storyboards.main.instantiateViewController(withIdentifier: "SellListViewController") as? SellListViewController else {
            fatalError("Can not cast to SellListController")
        }
        let vm: SellListViewModel = resolve(navigationController: navigationController)
        vc.bindViewModel(to: vm)
        return vc
    }

    func resolve(navigationController: UINavigationController) -> SellListViewModel {
        return SellListViewModel(
            navigator: resolve(navigationController: navigationController),
            execute: resolve()
        )
    }
}

extension MainAssembler where Self: DefaultAssembler {
    func resolve(navigationController: UINavigationController) -> SellListNavigatorType {
        return SellListNavigator(assembler: self, navigationController: navigationController)
    }

    func resolve() -> SellListExecuteType {
        return SellListExecute(useCase: SellUseCase())
    }
}
