//
//  GamePresenter.swift
//  SapperGame
//
//  Created by pavel mishanin on 06.04.2022.
//

import UIKit

protocol GamePresenter {
    func onViewAttached(view: GameViewController)
    func popToRootButtonTapped()
    func numberOfItemsInSection() -> Int
    func getColor(index: Int) -> UIColor
    func didSelectItemAt(index: Int)
    func getConstant() -> CGFloat
}

protocol GameViewController: AnyObject {
    func createAlert(title: String)
    func reloadData()
}

final class GamePresenterImpl: GamePresenter {
    
    private weak var view: GameViewController?
    private let router: GameRouter
    private let gameConverter: GameConverter
    
    init(router: GameRouter, gameConverter: GameConverter) {
        self.router = router
        self.gameConverter = gameConverter
    }
    
    func onViewAttached(view: GameViewController) {
        self.view = view
    }
    
    func popToRootButtonTapped() {
        router.popToRootViewController()
    }
    
    func numberOfItemsInSection() -> Int {
        return gameConverter.numberOfItemsInSection()
    }
    
    func getColor(index: Int) -> UIColor {
        return gameConverter.getColor(index: index)
    }
    
    func didSelectItemAt(index: Int) {
        gameConverter.didSelectItemAt(index: index) { result in
            switch result {
            case .reload:
                self.view?.reloadData()
            case .gameWin:
                self.view?.createAlert(title: "You are win")
            case .gameOver:
                self.view?.createAlert(title: "Game Over")
            }
        }
    }
    
    func getConstant() -> CGFloat {
        return gameConverter.getConstant()
    }
}
