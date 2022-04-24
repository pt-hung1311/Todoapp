//
//  ViewModelType.swift
//  JobLogic
//
//  Created by Pham Hung on 23/04/2022.
//

import Foundation
import RxSwift

protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    
    func transform(_ input: Input) -> Output
}
