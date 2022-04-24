//
//  API+Call.swift
//  JobLogic
//
//  Created by Pham Hung on 23/04/2022.
//

import RxSwift

extension API {
    func getCallList(_ input: GetCallListInput) -> Observable<[Call]> {
        return request(input)
    }
}

extension API {
    final class GetCallListInput: APIInput {
        init() {
            super.init(urlString: API.Urls.getCallList,
                       parameters: nil,
                       method: .get)
        }
    }
}
