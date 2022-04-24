//
//  CallListViewController.swift
//  JobLogic
//
//  Created by Pham Hung on 23/04/2022.
//

import UIKit
import RxSwift
import RxCocoa

class CallListViewController: UIViewController, BindableType {
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: CallListViewModel!
    let disposeBag: DisposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
    }
    
    private func configView() {
        title = "Call List"
        tableView.register(UINib.init(nibName: "CallListCell", bundle: nil),
                           forCellReuseIdentifier: "CallListCell")
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    func bindViewModel() {
        let input = CallListViewModel.Input(
            loadTrigger: Driver.just(())
        )

        let output = viewModel.transform(input)
        
        output.callList
            .drive(tableView.rx.items(cellIdentifier: "CallListCell",
                                      cellType: CallListCell.self)) { index, call, cell in
                cell.bindViewModel(call: call)
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
