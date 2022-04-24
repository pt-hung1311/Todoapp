//
//  CallListExecuteMock.swift
//  JobLogicTests
//
//  Created by Pham Hung on 24/04/2022.
//

@testable import JobLogic
import RxSwift

class CallListExecuteMock: CallListExecuteType {
    
    var getCallListCalled = false
    
    var getCallListReturnValue: Observable<[Call]> = {
        let items = [
            Call(id: 0, name: "", number: ""),
            Call(id: 1, name: "", number: "")
        ]
        return Observable.just(items)
    }()
    
    func getCallList() -> Observable<[Call]> {
        getCallListCalled = true
        return getCallListReturnValue
    }
}
