//
//  CallListExecute.swift
//  JobLogic
//
//  Created by Pham Hung on 23/04/2022.
//

import RxSwift

protocol CallListExecuteType {
    func getCallList() -> Observable<[Call]>
}

struct CallListExecute: CallListExecuteType {
    let useCase: CallUseCaseType
    
    func getCallList() -> Observable<[Call]> {
        return useCase.getCallList()
    }
}
