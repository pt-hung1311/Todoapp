//
//  AppNavigatorMock.swift
//  JobLogicTests
//
//  Created by Pham Hung on 24/04/2022.
//

@testable import JobLogic

class AppNavigatorMock: AppNavigatorType {
    var toMainCalled = false
    func toMain() {
        toMainCalled = true
    }
}
