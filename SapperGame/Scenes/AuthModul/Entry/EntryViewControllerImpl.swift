//
//  EntryViewController.swift
//  SapperGame
//
//  Created by pavel mishanin on 04.04.2022.
//

import UIKit
import Firebase

//        Test@mail.ru
// name:       Test-test
//password:        TestTest

final class EntryViewControllerImpl: UIViewController, EntryViewController, EntryViewDelegate {
    
    private let presenter: EntryPresenter
    private var superView: EntryView?
    private let alert = CustomAlert()
    
    init(presenter: EntryPresenter, superView: EntryView) {
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
        presenter.onViewAttached(view: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    private func configureView() {
        navigationItem.hidesBackButton = true
        title = "Entry"
    }
    
    func createAlert(title: String) {
        alert.showAlert(view: self, title: title, complition: nil)
    }
    
    func signIn(email: String, password: String) {
        presenter.signIn(email: email, password: password)
    }
    
    func forgetPasswordButtonTapped() {
        presenter.forgetPasswordButtonTapped()
    }
}
