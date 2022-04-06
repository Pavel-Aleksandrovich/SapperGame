//
//  StartViewController.swift
//  SapperGame
//
//  Created by pavel mishanin on 28.03.2022.
//

import UIKit
import Firebase

struct SomeType {
    let numberOfBomb: Int
    let numberOfCells: CGFloat
    var numberOfELementsInArray: Int {
        return Int(numberOfCells) * Int(numberOfCells)
    }
}

final class StartViewControllerImpl: UIViewController, StartViewController, StartViewDelegate {
    
    private let presenter: StartPresenter
    private let superView: StartView
    private let alert = CustomAlert()
    
    init(presenter: StartPresenter, superView: StartView) {
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
        createExitBarButtonItem()
    }
    
    private func createExitBarButtonItem() {
        let exitBarButton = UIBarButtonItem(title: "Exit", style: .done, target: self, action: #selector(exitButtonTapped))
        navigationItem.leftBarButtonItem = exitBarButton
    }
    
    @objc private func exitButtonTapped() {
        presenter.signOut()
    }
    
    func createAlert(title: String) {
        alert.showAlert(view: self, title: title, complition: nil)
    }
    
    private func configureView() {
        title = "SapperGame"
    }
    
    func createViewController(state: SomeType) {
        presenter.showGameViewController(state: state)
    }
}
