//
//  ViewController.swift
//  JobLogic
//
//  Created by Pham Hung on 23/04/2022.
//

import UIKit
import RxSwift
import RxCocoa

class MainViewController: UIViewController, BindableType {
    @IBOutlet weak var callListButton: UIButton!
    @IBOutlet weak var buyListButton: UIButton!
    @IBOutlet weak var sellListButton: UIButton!
    
    var viewModel: MainViewModel!
    let disposeBag: DisposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func bindViewModel() {
        let input = MainViewModel.Input(
            callListTrigger: callListButton.rx.tap.asDriver(),
            buyListTrigger: buyListButton.rx.tap.asDriver(),
            sellListTrigger: sellListButton.rx.tap.asDriver()
            
        )

        let output = viewModel.transform(input)
        
        output.selectedCallList
            .drive()
            .disposed(by: disposeBag)
        
        output.selectedBuyList
            .drive()
            .disposed(by: disposeBag)
        
        output.selectedSellList
            .drive()
            .disposed(by: disposeBag)
    }
}

