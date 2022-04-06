//
//  ResertPasswordViewController.swift
//  SapperGame
//
//  Created by pavel mishanin on 04.04.2022.
//

import UIKit
import Firebase

final class ResetViewControllerImpl: UIViewController, ResertViewController, ResetViewDelegate {
    
    private let presenter: ResertPresenter
    private var superView: ResetView?
    private let alert = CustomAlert()
    
    init(presenter: ResertPresenter, superView: ResetView) {
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
        title = "Resert"
    }
    
    func createAlert(title: String) {
        alert.showAlert(view: self, title: title, complition: nil)
    }
    
    func entryButtonTapped() {
        presenter.entryButtonTapped()
    }
    
    func resetPasswordButtonTapped(email: String) {
        presenter.resetPasswordButtonTapped(email: email)
    }
}
