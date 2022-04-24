//
//  MainViewModelTests.swift
//  JobLogicTests
//
//  Created by Pham Hung on 24/04/2022.
//

@testable import JobLogic
import XCTest
import RxSwift
import RxTest

class MainViewModelTests: XCTestCase {

    private var viewModel: MainViewModel!
    private var navigator: MainNavigatorMock!
    private var execute: MainExecuteMock!
    private var input: MainViewModel.Input!
    private var output: MainViewModel.Output!
    private var scheduler: TestScheduler!
    private var disposeBag: DisposeBag!
    
    // Triggers
    private let callListTrigger = PublishSubject<Void>()
    private let buyListTrigger = PublishSubject<Void>()
    private let sellListTrigger = PublishSubject<Void>()
    
    override func setUp() {
        super.setUp()
        navigator = MainNavigatorMock()
        execute = MainExecuteMock()
        viewModel = MainViewModel(navigator: navigator, execute: execute)
        
        input = MainViewModel.Input(
            callListTrigger: callListTrigger.asDriver(onErrorJustReturn: ()),
            buyListTrigger: buyListTrigger.asDriver(onErrorJustReturn: ()),
            sellListTrigger: sellListTrigger.asDriver(onErrorJustReturn: ())
        )
        
        disposeBag = DisposeBag()
        output = viewModel.transform(input)
        
        scheduler = TestScheduler(initialClock: 0)
        output.selectedCallList.drive().disposed(by: disposeBag)
        output.selectedBuyList.drive().disposed(by: disposeBag)
        output.selectedSellList.drive().disposed(by: disposeBag)
    }
    
    func test_callListTrigger_toCallList() {
        XCTAssertFalse(navigator.toCallListCalled)
        callListTrigger.onNext(())
        
        XCTAssertTrue(navigator.toCallListCalled)
    }
    
    func test_buyListTrigger_toBuyList() {
        XCTAssertFalse(navigator.toBuyListCalled)
        buyListTrigger.onNext(())
        
        XCTAssertTrue(navigator.toBuyListCalled)
    }
    
    func test_sellListTrigger_toSellList() {
        XCTAssertFalse(navigator.toSellListCalled)
        sellListTrigger.onNext(())
        
        XCTAssertTrue(navigator.toSellListCalled)
    }
    
}
