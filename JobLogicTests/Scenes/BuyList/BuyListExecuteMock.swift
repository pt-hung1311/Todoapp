//
//  BuyListExecuteMock.swift
//  JobLogicTests
//
//  Created by Pham Hung on 24/04/2022.
//

@testable import JobLogic
import RxSwift

class BuyListExecuteMock: BuyListExecuteType {
    var getBuyListCalled = false
    
    var getBuyListReturnValue: Observable<[Item]> = {
        let items = [
            Item(id: 0, name: "", price: 0, quantity: 0, type: 0),
            Item(id: 1, name: "", price: 0, quantity: 0, type: 0)
        ]
        return Observable.just(items)
    }()
    
    func getBuyList() -> Observable<[Item]> {
        getBuyListCalled = true
        return getBuyListReturnValue
    }
}
