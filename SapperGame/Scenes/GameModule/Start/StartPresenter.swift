//
//  StartPresenter.swift
//  SapperGame
//
//  Created by pavel mishanin on 06.04.2022.
//

import UIKit

protocol StartPresenter {
    func onViewAttached(view: StartViewController)
    func signOut()
    func showGameViewController(state: SomeType)
}

protocol StartViewController: AnyObject {
    func createAlert(title: String)
}

final class StartPresenterImpl: StartPresenter {
    
    private weak var view: StartViewController?
    private let router: StartRouter
    private let interactor: Interactor
    
    init(router: StartRouter, interactor: Interactor) {
        self.router = router
        self.interactor = interactor
    }
    
    func onViewAttached(view: StartViewController) {
        self.view = view
    }
    
    func signOut() {
        interactor.signOut { errorMessage in
            self.view?.createAlert(title: errorMessage.rawValue)
        }
    }
    
    func showGameViewController(state: SomeType) {
        router.showGameViewController(state: state)
    }
}
