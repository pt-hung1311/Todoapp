//
//  SellListViewModel.swift
//  JobLogic
//
//  Created by Pham Hung on 23/04/2022.
//

import RxSwift
import RxCocoa

struct SellListViewModel {
    let navigator: SellListNavigatorType
    let execute: SellListExecuteType
}

// MARK: - ViewModelType
extension SellListViewModel: ViewModelType {
    struct Input {
        let loadTrigger: Driver<Void>
    }
    
    struct Output {
        let sellList: Driver<[Item]>
        let error: Driver<Error>
    }
    
    func transform(_ input: Input) -> Output {
        let errorTrigger = PublishSubject<Error>()
        
        let sellList = input.loadTrigger
            .flatMapLatest { _ -> Driver<[Item]> in
                return execute.getSellList()
                    .catch({ error in
                        errorTrigger.onNext(error)
                        return .empty()
                    })
                    .asDriver(onErrorJustReturn: [])
            }
                
        return Output(sellList: sellList,
                      error: errorTrigger.asDriver(onErrorJustReturn: UnknownError() as Error))
    }
}
