//
//  DetailViewController.swift
//  MyApp
//
//  Created by nguyen.the.anhb on 3/8/21.
//

import UIKit
import RxSwift
import RxCocoa

class DetailViewController: ViewController {

    // MARK: - Outlets
    
    @IBOutlet private weak var avatarImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var summaryLabel: UILabel!
    @IBOutlet private weak var starLabel: UILabel!
    @IBOutlet private weak var forkLabel: UILabel!
    @IBOutlet private weak var languageLabel: UILabel!
    @IBOutlet private weak var tableView: UITableView!
    
    // MARK: - Properties
    
    private let viewModel: DetailViewModel

    private let disposeBag = DisposeBag()

    // MARK: - Init
    
    init(viewModel: DetailViewModel) {
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
        tableView.rowHeight = 44
        tableView.register(DetailUserViewCell.self, forCellReuseIdentifier: DetailUserViewCell.reuseID)
    }
    
    private func bindViewModel() {
        let viewWillAppear = rx.sentMessage(#selector(UIViewController.viewWillAppear(_:)))
                    .mapToVoid()
                    .asDriverOnErrorJustComplete()
        let input = DetailViewModel.Input(trigger: viewWillAppear)
        let output = viewModel.transform(input: input)
        // Bind items to UITableView
        output.users
            .drive(tableView.rx.items(cellIdentifier: DetailUserViewCell.reuseID, cellType: DetailUserViewCell.self)) { tv, viewModel, cell in
                cell.bind(viewModel)
            }
            .disposed(by: disposeBag)
        
        output.repos.asObservable()
            .subscribe(onNext: { [weak self](viewModel) in
                self?.bind(viewModel)
            })
            .disposed(by: disposeBag)
    }
    
    private func bind(_ viewModel: DetailReposViewModel) {
        avatarImageView?.kf.setImage(with: URL(string: viewModel.avatar))
        nameLabel.text = viewModel.name
        summaryLabel.text = viewModel.summary
        starLabel.text = "Stars\n\(viewModel.stars)"
        forkLabel.text = "Forks\n\(viewModel.forks)"
        languageLabel.text = "Language\n\(viewModel.language ?? "")"
    }
}
