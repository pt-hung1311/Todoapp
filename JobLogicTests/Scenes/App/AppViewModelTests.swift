//
//  AppViewModelTests.swift
//  JobLogicTests
//
//  Created by Pham Hung on 24/04/2022.
//

@testable import JobLogic
import XCTest
import RxSwift
import RxTest

class AppViewModelTests: XCTestCase {

    private var viewModel: AppViewModel!
    private var navigator: AppNavigatorMock!
    private var execute: AppExecuteMock!
    private var input: AppViewModel.Input!
    private var output: AppViewModel.Output!
    private var scheduler: TestScheduler!
    private var disposeBag: DisposeBag!
    
    // Triggers
    private let loadTrigger = PublishSubject<Void>()
    
    override func setUp() {
        super.setUp()
        navigator = AppNavigatorMock()
        execute = AppExecuteMock()
        viewModel = AppViewModel(navigator: navigator, execute: execute)
        
        input = AppViewModel.Input(
            loadTrigger: loadTrigger.asDriver(onErrorJustReturn: ())
        )
        
        disposeBag = DisposeBag()
        output = viewModel.transform(input)
        
        scheduler = TestScheduler(initialClock: 1)
        output.toMain.drive().disposed(by: disposeBag)
    }
    
    func test_loadTrigger_toMain() {
        XCTAssertFalse(navigator.toMainCalled)
        loadTrigger.onNext(())
        
        XCTAssertTrue(navigator.toMainCalled)
    }

}
