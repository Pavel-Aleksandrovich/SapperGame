//
//  GameRouter.swift
//  SapperGame
//
//  Created by pavel mishanin on 06.04.2022.
//

import UIKit

protocol GameRouter {
    func popToRootViewController()
}

final class GameRouterImpl: GameRouter {
    
    weak var controller: UIViewController?
    
    func popToRootViewController() {
        controller?.navigationController?.popToRootViewController(animated: true)
    }
}
