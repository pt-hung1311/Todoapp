//
//  AppViewModel.swift
//  JobLogic
//
//  Created by Pham Hung on 23/04/2022.
//

import RxSwift
import RxCocoa

struct AppViewModel {
    let navigator: AppNavigatorType
    let execute: AppExecuteType
}

// MARK: - ViewModelType
extension AppViewModel: ViewModelType {
    struct Input {
        let loadTrigger: Driver<Void>
    }
    
    struct Output {
        let toMain: Driver<Void>
    }
    
    func transform(_ input: Input) -> Output {
        let toMain = input.loadTrigger
            .do(onNext: navigator.toMain)
        
        return Output(toMain: toMain)
    }
}
