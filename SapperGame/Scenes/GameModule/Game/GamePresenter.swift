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
    func showAlertGoBack(title: String)
    func showAlert(title: String)
    func reloadData()
    func getNumberOfLives(number: Int)
}

final class GamePresenterImpl: GamePresenter {
    
    private weak var view: GameViewController?
    private let router: GameRouter
    private let gameConverter: GameConfigureLevel
    private let levelsState: LevelsState
    private let interactor: Interactor
    
    init(router: GameRouter, gameConverter: GameConfigureLevel, levelsState: LevelsState, interactor: Interactor) {
        self.router = router
        self.gameConverter = gameConverter
        self.levelsState = levelsState
        self.interactor = interactor
    }
    
    func onViewAttached(view: GameViewController) {
        self.view = view
        config()
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
        gameConverter.didSelectItemAt(index: index) { [ weak self ] result in
            switch result {
            case .reload:
                self?.view?.reloadData()
            case .gameWin:
                self?.view?.showAlertGoBack(title: "You are win")
                self?.interactor.playSound(sound: .cat)
            case .gameOver:
                self?.view?.getNumberOfLives(number: (self?.gameConverter.getNumberOfLives()) ?? 1)
                self?.view?.showAlertGoBack(title: "Game Over")
                self?.interactor.playSound(sound: .dog)
            case .onBombTapped:
                self?.view?.getNumberOfLives(number: self?.gameConverter.getNumberOfLives() ?? 1)
                self?.view?.showAlert(title: "On Bomb Tapped")
            }
        }
    }
    
    func getConstant() -> CGFloat {
        return gameConverter.getConstant()
    }
    
    private func config() {
        gameConverter.convert(state: levelsState)
        self.view?.getNumberOfLives(number: gameConverter.getNumberOfLives())
    }
}
