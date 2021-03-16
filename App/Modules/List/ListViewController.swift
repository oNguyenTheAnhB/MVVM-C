//
//  ListViewController.swift
//  MyApp
//
//  Created by nguyen.the.anhb on 3/8/21.
//

import UIKit
import RxSwift
import RxCocoa

class ListViewController: ViewController {

    // MARK: - Outlets
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
    
    private let viewModel: ListViewModel

    private let disposeBag = DisposeBag()

    // MARK: - Init
    
    init(viewModel: ListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        bindViewModel()
    }
    
    private func configureTableView() {
        tableView.refreshControl = UIRefreshControl()
        tableView.estimatedRowHeight = 64
        tableView.rowHeight = 78
        tableView.register(UINib(nibName: "ListViewCell", bundle: nil), forCellReuseIdentifier: ListViewCell.reuseID)
    }
    
    private func bindViewModel() {
        let viewWillAppear = rx.sentMessage(#selector(UIViewController.viewWillAppear(_:)))
                    .mapToVoid()
                    .asDriverOnErrorJustComplete()
        let pull = tableView.refreshControl!.rx
            .controlEvent(.valueChanged)
            .asDriver()
        
        let input = ListViewModel.Input(trigger: Driver.merge(viewWillAppear, pull),
                                        selection: tableView.rx.itemSelected.asDriver())
        let output = viewModel.transform(input: input)
        // Bind items to UITableView
        output.items
            .drive(tableView.rx.items(cellIdentifier: ListViewCell.reuseID, cellType: ListViewCell.self)) { tv, viewModel, cell in
                cell.bind(viewModel)
            }
            .disposed(by: disposeBag)
        // Connect Create Post to UI
        
        output.fetching
            .drive(tableView.refreshControl!.rx.isRefreshing)
            .disposed(by: disposeBag)
        output.selectedItem.asObservable()
            .subscribe(onNext: { [weak self](repos) in
                self?.coordinator?.showDetail(with: repos)
            })
            .disposed(by: disposeBag)
    }
}
