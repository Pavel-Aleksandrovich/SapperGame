//
//  AuthPresenter.swift
//  SapperGame
//
//  Created by pavel mishanin on 05.04.2022.
//

import Foundation

protocol AuthPresenter {
    func onViewAttached(view: AuthViewController)
    func entryButtonTapped()
    func createUser(name: String, email: String, password: String)
}

protocol AuthViewController: AnyObject {
    func createAlert(title: String)
}

final class AuthPresenterImpl: AuthPresenter {
    
    private weak var view: AuthViewController?
    private let router: AuthRouter
    private let interactor: Interactor
    
    init(router: AuthRouter, interactor: Interactor) {
        self.router = router
        self.interactor = interactor
    }
    
    func onViewAttached(view: AuthViewController) {
        self.view = view
        checkInternetConnection()
    }
    
    func entryButtonTapped() {
        router.showEntryViewController()
    }
    
    func createUser(name: String, email: String, password: String) {
        interactor.createUser(name: name, email: email, password: password) { errorMessage in
            self.view?.createAlert(title: errorMessage.rawValue)
        }
    }
    
    private func checkInternetConnection() {
        interactor.checkInternetConnection { bool in
            self.view?.createAlert(title: "\(bool)")
        }
    }
}
