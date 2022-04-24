//
//  SellListViewController.swift
//  JobLogic
//
//  Created by Pham Hung on 23/04/2022.
//

import UIKit
import RxSwift
import RxCocoa

class SellListViewController: UIViewController, BindableType {
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: SellListViewModel!
    let disposeBag: DisposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
    }
    
    private func configView() {
        title = "Sell List"
        tableView.register(UINib(nibName: "BuyListCell", bundle: nil),
                           forCellReuseIdentifier: "BuyListCell")
    }
    
    func bindViewModel() {
        let input = SellListViewModel.Input(
            loadTrigger: Driver.just(())
        )

        let output = viewModel.transform(input)
        
        output.sellList
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
