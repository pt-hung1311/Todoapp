//
//  MainViewModel.swift
//  JobLogic
//
//  Created by Pham Hung on 23/04/2022.
//

import RxSwift
import RxCocoa

struct MainViewModel {
    let navigator: MainNavigatorType
    let execute: MainExecuteType
}

// MARK: - ViewModelType
extension MainViewModel: ViewModelType {
    struct Input {
        let callListTrigger: Driver<Void>
        let buyListTrigger: Driver<Void>
        let sellListTrigger: Driver<Void>
    }
    
    struct Output {
        let selectedCallList: Driver<Void>
        let selectedBuyList: Driver<Void>
        let selectedSellList: Driver<Void>
    }
    
    func transform(_ input: Input) -> Output {
        
        let selectedCallList = input.callListTrigger
            .do(onNext: navigator.toCallList)
            .asDriver()
                
        let selectedBuyList = input.buyListTrigger
            .do(onNext: navigator.toBuyList)
            .asDriver()
        
        let selectedSellList = input.sellListTrigger
            .do(onNext: navigator.toSellList)
            .asDriver()
                        
        return Output(selectedCallList: selectedCallList,
                      selectedBuyList: selectedBuyList,
                      selectedSellList: selectedSellList)
    }
}
