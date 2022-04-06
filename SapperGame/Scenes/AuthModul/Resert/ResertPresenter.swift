//
//  ResertPresenter.swift
//  SapperGame
//
//  Created by pavel mishanin on 05.04.2022.
//

import Foundation

protocol ResertPresenter {
    func onViewAttached(view: ResertViewController)
    func entryButtonTapped()
    func resetPasswordButtonTapped(email: String)
}

protocol ResertViewController: AnyObject {
    func createAlert(title: String)
}

final class ResertPresenterImpl: ResertPresenter {
    
    private weak var view: ResertViewController?
    private let router: ResertRouter
    private let interactor: Interactor
    
    init(router: ResertRouter, interactor: Interactor) {
        self.router = router
        self.interactor = interactor
    }
    
    func onViewAttached(view: ResertViewController) {
        self.view = view
    }
    
    func entryButtonTapped() {
        router.popToRootViewController()
    }
    
    func resetPasswordButtonTapped(email: String) {
        interactor.sendPasswordReset(email: email) { result in
            switch result {
            case .failure(let error):
                self.view?.createAlert(title: error.rawValue)
            case .success(let success):
                self.view?.createAlert(title: success)
            }
        }
    }
}
