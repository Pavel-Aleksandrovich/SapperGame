//
//  EntryPresenter.swift
//  SapperGame
//
//  Created by pavel mishanin on 05.04.2022.
//

import Foundation

protocol EntryPresenter {
    func onViewAttached(view: EntryViewController)
    func forgetPasswordButtonTapped()
    func signIn(email: String, password: String)
}

protocol EntryViewController: AnyObject {
    func createAlert(title: String)
}

final class EntryPresenterImpl: EntryPresenter {
    
    private weak var view: EntryViewController?
    private let router: EntryRouter
    private let interactor: Interactor
    
    init(router: EntryRouter, interactor: Interactor) {
        self.router = router
        self.interactor = interactor
    }
    
    func onViewAttached(view: EntryViewController) {
        self.view = view
    }
    
    func forgetPasswordButtonTapped() {
        router.showResertViewController()
    }
    
    func signIn(email: String, password: String) {
        interactor.signIn(email: email, password: password) { errorMassage in
            self.view?.createAlert(title: errorMassage.rawValue)
        }
    }
}
