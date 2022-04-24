//
//  BuyListAssembler.swift
//  JobLogic
//
//  Created by Pham Hung on 23/04/2022.
//

import UIKit

protocol BuyListAssembler {
    func resolve(navigationController: UINavigationController) -> BuyListViewController
    func resolve(navigationController: UINavigationController) -> BuyListViewModel
    func resolve(navigationController: UINavigationController) -> BuyListNavigatorType
    func resolve() -> BuyListExecuteType
}

extension BuyListAssembler {
    func resolve(navigationController: UINavigationController) -> BuyListViewController {
        guard let vc = Storyboards.main.instantiateViewController(withIdentifier: "BuyListViewController") as? BuyListViewController else {
            fatalError("Can not cast to BuyListController")
        }
        let vm: BuyListViewModel = resolve(navigationController: navigationController)
        vc.bindViewModel(to: vm)
        return vc
    }

    func resolve(navigationController: UINavigationController) -> BuyListViewModel {
        return BuyListViewModel(
            navigator: resolve(navigationController: navigationController),
            execute: resolve()
        )
    }
}

extension MainAssembler where Self: DefaultAssembler {
    func resolve(navigationController: UINavigationController) -> BuyListNavigatorType {
        return BuyListNavigator(assembler: self, navigationController: navigationController)
    }

    func resolve() -> BuyListExecuteType {
        return BuyListExecute(useCase: BuyUseCase())
    }
}
