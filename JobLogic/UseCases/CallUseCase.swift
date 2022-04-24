//
//  CallUseCase.swift
//  JobLogic
//
//  Created by Pham Hung on 23/04/2022.
//

import RxSwift

protocol CallUseCaseType {
    func getCallList() -> Observable<[Call]>
}

class CallUseCase: CallUseCaseType {
    func getCallList() -> Observable<[Call]> {
        let input = API.GetCallListInput()
        
        return API.shared.getCallList(input)
    }
}
