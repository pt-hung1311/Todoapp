//
//  SellListExecuteMock.swift
//  JobLogicTests
//
//  Created by Pham Hung on 24/04/2022.
//

@testable import JobLogic
import RxSwift

class SellListExecuteMock: SellListExecuteType {
    var getSellListCalled = false
    
    var getSellListReturnValue: Observable<[Item]> = {
        let items = [
            Item(id: 1, name: "iPhone X", price: 150000, quantity: 1, type: 2),
            Item(id: 2, name: "TV", price: 38000, quantity: 2, type: 2),
            Item(id: 3, name: "Table", price: 12000, quantity: 1, type: 2)
        ]
        
        return Observable.just(items)
    }()
    
    func getSellList() -> Observable<[Item]> {
        getSellListCalled = true
        
        return getSellListReturnValue
    }
}
