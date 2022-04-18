//
//  AuthViewController.swift
//  SapperGame
//
//  Created by pavel mishanin on 31.03.2022.
//

import UIKit

final class AuthViewControllerImpl: UIViewController, AuthViewController, AuthViewDelegate {
    
    private let presenter: AuthPresenter
    private var superView: AuthView?
    private let alert = CustomAlert()
    
    init(presenter: AuthPresenter, superView: AuthView) {
        self.superView = superView
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        view = superView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.onViewAttached(view: self)
        configureView()
    }
    
    private func configureView() {
        title = "Auth"
    }
    
    func createAlert(title: String) {
        alert.showAlert(view: self, title: title, complition: nil)
    }
    
    func entryButtonTapped() {
        presenter.entryButtonTapped()
    }
    
    func createUser(name: String, email: String, password: String) {
        presenter.createUser(name: name, email: email, password: password)
    }
    
    func phoneNumberButtonTapped() {
        let vc = PhoneNumberViewController()
        present(vc, animated: false)
    }
}

