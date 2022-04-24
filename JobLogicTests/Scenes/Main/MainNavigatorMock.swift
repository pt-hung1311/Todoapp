//
//  MainNavigatorMock.swift
//  JobLogicTests
//
//  Created by Pham Hung on 24/04/2022.
//

@testable import JobLogic

class MainNavigatorMock: MainNavigatorType {
    var toCallListCalled = false
    func toCallList() {
        toCallListCalled = true
    }
    
    var toBuyListCalled = false
    func toBuyList() {
        toBuyListCalled = true
    }
    
    var toSellListCalled = false
    func toSellList() {
        toSellListCalled = true
    }
}
