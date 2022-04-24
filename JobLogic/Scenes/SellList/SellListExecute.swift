//
//  SellListExecute.swift
//  JobLogic
//
//  Created by Pham Hung on 23/04/2022.
//

import RxSwift

protocol SellListExecuteType {
    func getSellList() -> Observable<[Item]>
}

struct SellListExecute: SellListExecuteType {
    let useCase: SellUseCaseType
    
    func getSellList() -> Observable<[Item]> {
        return useCase.getSellList(coreDataServiceType: CoreDataService())
    }
}
