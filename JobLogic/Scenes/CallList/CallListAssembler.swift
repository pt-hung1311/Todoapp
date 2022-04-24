//
//  CallListAssembler.swift
//  JobLogic
//
//  Created by Pham Hung on 23/04/2022.
//

import UIKit

protocol CallListAssembler {
    func resolve(navigationController: UINavigationController) -> CallListViewController
    func resolve(navigationController: UINavigationController) -> CallListViewModel
    func resolve(navigationController: UINavigationController) -> CallListNavigatorType
    func resolve() -> CallListExecuteType
}

extension CallListAssembler {
    func resolve(navigationController: UINavigationController) -> CallListViewController {
        guard let vc = Storyboards.main.instantiateViewController(withIdentifier: "CallListViewController") as? CallListViewController else {
            fatalError("Can not cast to CallListController")
        }
        let vm: CallListViewModel = resolve(navigationController: navigationController)
        vc.bindViewModel(to: vm)
        return vc
    }

    func resolve(navigationController: UINavigationController) -> CallListViewModel {
        return CallListViewModel(
            navigator: resolve(navigationController: navigationController),
            execute: resolve()
        )
    }
}

extension MainAssembler where Self: DefaultAssembler {
    func resolve(navigationController: UINavigationController) -> CallListNavigatorType {
        return CallListNavigator(assembler: self, navigationController: navigationController)
    }

    func resolve() -> CallListExecuteType {
        return CallListExecute(useCase: CallUseCase())
    }
}
