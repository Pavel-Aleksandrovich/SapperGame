//
//  StartRouter.swift
//  SapperGame
//
//  Created by pavel mishanin on 06.04.2022.
//

import UIKit

protocol StartRouter {
    func showGameViewController(state: SomeType)
}

final class StartRouterImpl: StartRouter {
    
    weak var controller: UIViewController?
    
    func showGameViewController(state: SomeType) {
        let vc = GameAssembler.assembly(state: state)
        controller?.navigationController?.pushViewController(vc, animated: false)
    }
}
