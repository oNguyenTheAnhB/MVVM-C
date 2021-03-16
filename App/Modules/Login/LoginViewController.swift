//
//  LoginViewController.swift
//  MyApp
//
//  Created by nguyen.the.anhb on 3/8/21.
//

import UIKit
import RxSwift
import RxCocoa

class LoginViewController: ViewController {

    // MARK: - Outlets

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var tokenTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    
    // MARK: - Properties
    
    private let viewModel: LoginViewModel

    private let disposeBag = DisposeBag()

    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
    }
    
    private func bindViewModel() {
        let input = LoginViewModel.Input(username: usernameTextField.rx.text.orEmpty.asDriver(),
                                         token: tokenTextField.rx.text.orEmpty.asDriver(),
                                         loginButtonTapped: signInButton.rx.tap.asDriver())
        let output = viewModel.transform(input: input)
        output.loading.asObservable()
            .map { !$0 }
            .bind(to: signInButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        output.user.asObservable()
            .subscribe(onNext: { [weak self] (user) in
                print(user)
                self?.coordinator?.showList()
            })
            .disposed(by: disposeBag)

        output.error.asObservable()
            .subscribe(onNext: { (error) in
                print(error)
            })
            .disposed(by: disposeBag)

    }
}
