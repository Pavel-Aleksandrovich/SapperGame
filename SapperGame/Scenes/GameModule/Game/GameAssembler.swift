//
//  GameAssembler.swift
//  SapperGame
//
//  Created by pavel mishanin on 06.04.2022.
//

import UIKit

final class GameAssembler {
    
    private init() {}
    
    static func assembly(state: LevelsState) -> UIViewController {
        
        let firebase = CustomFirebase()
        let interactor = InteractorImpl(firebase: firebase)
        let gameConverter = GameConfigureLevelImpl()
        let router = GameRouterImpl()
        let presenter = GamePresenterImpl(router: router, gameConverter: gameConverter, levelsState: state, interactor: interactor)
        let controller = GameViewControllerImpl(presenter: presenter)
        router.controller = controller
        
        return controller
    }
}
