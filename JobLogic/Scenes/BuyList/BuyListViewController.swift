//
//  BuyListViewController.swift
//  JobLogic
//
//  Created by Pham Hung on 23/04/2022.
//

import UIKit
import RxSwift
import RxCocoa

class BuyListViewController: UIViewController, BindableType {
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: BuyListViewModel!
    let disposeBag: DisposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
    }
    
    private func configView() {
        title = "Buy List"
        tableView.register(UINib.init(nibName: "BuyListCell", bundle: nil),
                           forCellReuseIdentifier: "BuyListCell")
    }
    
    func bindViewModel() {
        let input = BuyListViewModel.Input(
            loadTrigger: Driver.just(())
        )

        let output = viewModel.transform(input)
        
        output.buyList
            .drive(tableView.rx.items(cellIdentifier: "BuyListCell",
                                      cellType: BuyListCell.self)) { index, item, cell in
                cell.bindViewModel(item: item)
            }
            .disposed(by: disposeBag)
        
        output.error
            .drive(onNext: { [weak self] error in
                self?.showErrorAlert(error: error)
                return
            })
            .disposed(by: disposeBag)
    }
}
