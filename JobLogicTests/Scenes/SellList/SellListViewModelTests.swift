//
//  SellListViewModelTests.swift
//  JobLogicTests
//
//  Created by Pham Hung on 24/04/2022.
//

@testable import JobLogic
import XCTest
import RxSwift
import RxTest
import RxBlocking

class SellListViewModelTests: XCTestCase {

    private var viewModel: SellListViewModel!
    private var navigator: SellListNavigatorMock!
    private var execute: SellListExecuteMock!
    private var input: SellListViewModel.Input!
    private var output: SellListViewModel.Output!
    private var scheduler: TestScheduler!
    private var disposeBag: DisposeBag!
    
    // Triggers
    private let loadTrigger = PublishSubject<Void>()
    
    override func setUp() {
        super.setUp()
        navigator = SellListNavigatorMock()
        execute = SellListExecuteMock()
        viewModel = SellListViewModel(navigator: navigator, execute: execute)
        
        input = SellListViewModel.Input(
            loadTrigger: loadTrigger.asDriver(onErrorJustReturn: ())
        )
        
        disposeBag = DisposeBag()
        output = viewModel.transform(input)
        
        scheduler = TestScheduler(initialClock: 1)
        output.sellList.drive().disposed(by: disposeBag)
        output.error.drive().disposed(by: disposeBag)
    }
    
    func test_loadTrigger_getSellList_success() {
        XCTAssertFalse(execute.getSellListCalled)
        loadTrigger.onNext(())
        
        let sellList = try? output.sellList.toBlocking(timeout: 1).first()

        XCTAssertTrue(execute.getSellListCalled)
        XCTAssertEqual(sellList?.count, 3)
    }
    
    func test_loadTrigger_getSellList_failed() {
        XCTAssertFalse(execute.getSellListCalled)
        execute.getSellListReturnValue = Observable.error(UnknownError())
        loadTrigger.onNext(())
        
        let error = try? output.error.toBlocking(timeout: 1).first()

        XCTAssertTrue(execute.getSellListCalled)
        XCTAssertTrue(error is UnknownError)
    }

}
