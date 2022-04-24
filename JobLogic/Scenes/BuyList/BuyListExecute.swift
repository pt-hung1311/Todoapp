//
//  BuyListExecute.swift
//  JobLogic
//
//  Created by Pham Hung on 23/04/2022.
//

import RxSwift

protocol BuyListExecuteType {
    func getBuyList() -> Observable<[Item]>
}

struct BuyListExecute: BuyListExecuteType {
    let useCase: BuyUseCaseType
    
    func getBuyList() -> Observable<[Item]> {
        return useCase.getBuyList()
    }
}
