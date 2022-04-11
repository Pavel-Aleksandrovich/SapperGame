//
//  StartPresenter.swift
//  SapperGame
//
//  Created by pavel mishanin on 06.04.2022.
//

import UIKit

protocol StartPresenter {
    func onViewAttached(view: StartViewController)
    func onSignOutTapped()
    func onLevelButtonTapped(state: LevelsState)
}

protocol StartViewController: AnyObject {
    func showAlert(title: String)
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
    
    func onSignOutTapped() {
        interactor.signOut { errorMessage in
            self.view?.showAlert(title: errorMessage.rawValue)
        }
    }
    // TODO: переминовать все в соответсвии routeToGameScreen
    func onLevelButtonTapped(state: LevelsState) {
        router.routeToGameScreen(state: state)
    }
}
