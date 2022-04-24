//
//  CallListViewModel.swift
//  JobLogic
//
//  Created by Pham Hung on 23/04/2022.
//

import RxSwift
import RxCocoa

struct CallListViewModel {
    let navigator: CallListNavigatorType
    let execute: CallListExecuteType
}

// MARK: - ViewModelType
extension CallListViewModel: ViewModelType {
    struct Input {
        let loadTrigger: Driver<Void>
    }
    
    struct Output {
        let callList: Driver<[Call]>
        let error: Driver<Error>
    }
    
    func transform(_ input: Input) -> Output {
        let errorTrigger = PublishSubject<Error>()
        
        let callList = input.loadTrigger
            .flatMapLatest { _ -> Driver<[Call]> in
                return execute.getCallList()
                    .catch({ error in
                        errorTrigger.onNext(error)
                        return .empty()
                    })
                    .asDriver(onErrorJustReturn: [])
            }
                
        return Output(callList: callList,
                      error: errorTrigger.asDriver(onErrorJustReturn: UnknownError() as Error))
    }
}
