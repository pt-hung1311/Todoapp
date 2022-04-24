//
//  BuyListViewModelTests.swift
//  JobLogicTests
//
//  Created by Pham Hung on 24/04/2022.
//

@testable import JobLogic
import XCTest
import RxSwift
import RxTest
import RxBlocking

class BuyListViewModelTests: XCTestCase {

    private var viewModel: BuyListViewModel!
    private var navigator: BuyListNavigatorMock!
    private var execute: BuyListExecuteMock!
    private var input: BuyListViewModel.Input!
    private var output: BuyListViewModel.Output!
    private var scheduler: TestScheduler!
    private var disposeBag: DisposeBag!
    
    // Triggers
    private let loadTrigger = PublishSubject<Void>()
    
    override func setUp() {
        super.setUp()
        navigator = BuyListNavigatorMock()
        execute = BuyListExecuteMock()
        viewModel = BuyListViewModel(navigator: navigator, execute: execute)
        
        input = BuyListViewModel.Input(
            loadTrigger: loadTrigger.asDriver(onErrorJustReturn: ())
        )
        
        disposeBag = DisposeBag()
        output = viewModel.transform(input)
        
        scheduler = TestScheduler(initialClock: 1)
        output.buyList.drive().disposed(by: disposeBag)
        output.error.drive().disposed(by: disposeBag)
    }
    
    func test_loadTrigger_getBuyList_success() {
        XCTAssertFalse(execute.getBuyListCalled)
        loadTrigger.onNext(())
        
        let buyList = try? output.buyList.toBlocking(timeout: 1).first()

        XCTAssertTrue(execute.getBuyListCalled)
        XCTAssertEqual(buyList?.count, 2)
    }
    
    func test_loadTrigger_getBuyList_failed() {
        XCTAssertFalse(execute.getBuyListCalled)
        execute.getBuyListReturnValue = Observable.error(UnknownError())

        loadTrigger.onNext(())
        
        let error = try? output.error.toBlocking(timeout: 1).first()

        XCTAssertTrue(execute.getBuyListCalled)
        XCTAssertTrue(error is UnknownError)
    }

}
