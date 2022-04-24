//
//  BindableType.swift
//  JobLogic
//
//  Created by Pham Hung on 23/04/2022.
//

import UIKit
import RxSwift

protocol BindableType: AnyObject {
    associatedtype ViewModelType
    
    var viewModel: ViewModelType! { get set }
    var disposeBag: DisposeBag { get }
    
    func bindViewModel()
}

extension BindableType where Self: UIViewController {
    func bindViewModel(to model: Self.ViewModelType) {
        viewModel = model
        loadViewIfNeeded()
        bindViewModel()
    }
}
