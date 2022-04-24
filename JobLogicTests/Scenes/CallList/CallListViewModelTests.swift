//
//  CallListViewModelTests.swift
//  JobLogicTests
//
//  Created by Pham Hung on 24/04/2022.
//

@testable import JobLogic
import XCTest
import RxSwift
import RxTest
import RxBlocking

class CallListViewModelTests: XCTestCase {

    private var viewModel: CallListViewModel!
    private var navigator: CallListNavigatorMock!
    private var execute: CallListExecuteMock!
    private var input: CallListViewModel.Input!
    private var output: CallListViewModel.Output!
    private var scheduler: TestScheduler!
    private var disposeBag: DisposeBag!
    
    // Triggers
    private let loadTrigger = PublishSubject<Void>()
    
    override func setUp() {
        super.setUp()
        navigator = CallListNavigatorMock()
        execute = CallListExecuteMock()
        viewModel = CallListViewModel(navigator: navigator, execute: execute)
        
        input = CallListViewModel.Input(
            loadTrigger: loadTrigger.asDriver(onErrorJustReturn: ())
        )
        
        disposeBag = DisposeBag()
        output = viewModel.transform(input)
        
        scheduler = TestScheduler(initialClock: 1)
        output.callList.drive().disposed(by: disposeBag)
        output.error.drive().disposed(by: disposeBag)
    }
    
    func test_loadTrigger_getCallList_success() {
        XCTAssertFalse(execute.getCallListCalled)
        loadTrigger.onNext(())
        
        let callList = try? output.callList.toBlocking(timeout: 1).first()

        XCTAssertTrue(execute.getCallListCalled)
        XCTAssertEqual(callList?.count, 2)
    }
    
    func test_loadTrigger_getCallList_failed() {
        XCTAssertFalse(execute.getCallListCalled)
        execute.getCallListReturnValue = Observable.error(UnknownError())
        loadTrigger.onNext(())
        
        let error = try? output.error.toBlocking(timeout: 1).first()

        XCTAssertTrue(execute.getCallListCalled)
        XCTAssertTrue(error is UnknownError)
    }

}
