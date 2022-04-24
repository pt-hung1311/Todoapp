//
//  BuyListViewModel.swift
//  JobLogic
//
//  Created by Pham Hung on 23/04/2022.
//

import RxSwift
import RxCocoa

struct BuyListViewModel {
    let navigator: BuyListNavigatorType
    let execute: BuyListExecuteType
}

// MARK: - ViewModelType
extension BuyListViewModel: ViewModelType {
    struct Input {
        let loadTrigger: Driver<Void>
    }
    
    struct Output {
        let buyList: Driver<[Item]>
        let error: Driver<Error>
    }
    
    func transform(_ input: Input) -> Output {
        let errorTrigger = PublishSubject<Error>()
        
        let buyList = input.loadTrigger
            .flatMapLatest { _ -> Driver<[Item]> in
                return execute.getBuyList()
                    .catch({ error in
                        errorTrigger.onNext(error)
                        return .empty()
                    })
                    .asDriver(onErrorJustReturn: [])
            }
                
        return Output(buyList: buyList,
                      error: errorTrigger.asDriver(onErrorJustReturn: UnknownError() as Error))
    }
}
