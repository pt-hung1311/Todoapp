//
//  APIServiceBase.swift
//  JobLogic
//
//  Created by Pham Hung on 23/04/2022.
//

import Foundation
import Alamofire
import RxSwift

typealias JSONDictionary = [String: Any]
typealias ResponseHeader = [AnyHashable: Any]

class APIBase {
   
    var manager: Alamofire.Session
    
    convenience init() {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 60
        configuration.timeoutIntervalForResource = 60
        
        self.init(configuration: configuration)
    }
    
    init(configuration: URLSessionConfiguration) {
        manager = Alamofire.Session(configuration: configuration)
    }
    
    func request<T: Codable>(_ input: APIInputBase) -> Observable<APIResponse<T>> {
        let response: Observable<APIResponse<Data>> = requestData(input)
        
        return response
            .map { apiResponse -> APIResponse<T> in
                let decoder = JSONDecoder()

                if let t = try? decoder.decode(T.self, from: apiResponse.data) {
                    print("API Response:", t)
                    return APIResponse(header: apiResponse.header, data: t)
                }

                throw UnknownError(message: "Something wrong when decode")
            }
    }
    
    func request<T: Codable>(_ input: APIInputBase) -> Observable<T> {
        return request(input).map { $0.data }
    }

    func requestData(_ input: APIInputBase) -> Observable<APIResponse<Data>> {
        let urlRequest = Observable.just(input)
            .do(onNext: { input in
                print(input.description(isIncludedParameters: false))
            })
            .map { [unowned self] input -> DataRequest in
                manager.request(input.urlString,
                                method: input.method,
                                parameters: input.parameters,
                                headers: input.headers)
            }
            .flatMapLatest { dataRequest -> Observable<(HTTPURLResponse?, Data?)> in
                return Observable.create { observer -> Disposable in
                    dataRequest.responseData { data in
                        observer.onNext((data.response, data.data))
                        observer.onCompleted()
                    }
                    
                    return Disposables.create()
                }
            }
            .map { (dataResponse) -> APIResponse<Data> in
                try self.process(dataResponse)
            }
            .catch { error -> Observable<APIResponse<Data>> in
                throw error
            }
        
        return urlRequest
    }
    
    func process(_ response: (HTTPURLResponse?, Data?)) throws -> APIResponse<Data> {
        guard let urlResponse = response.0,
              let data = response.1, let json = (try? JSONSerialization.jsonObject(with: data)),
              let jsonEncode = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted) else {
                  throw UnknownError(message: "Something wrong when encode")
              }
        
        let error: Error
        let statusCode = urlResponse.statusCode
        
        switch statusCode {
        case 200..<300:
            print("👍 [\(statusCode)] " + (urlResponse.url?.absoluteString ?? ""))
            return APIResponse(header: urlResponse.allHeaderFields, data: jsonEncode)
        default:
            print("❌ [\(statusCode)] " + (urlResponse.url?.absoluteString ?? ""))
            error = APIUnknownError(statusCode: urlResponse.statusCode)
        }
        throw error
    }
}
