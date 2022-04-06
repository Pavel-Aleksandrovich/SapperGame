//
//  EntryRouter.swift
//  SapperGame
//
//  Created by pavel mishanin on 05.04.2022.
//

import UIKit

protocol EntryRouter {
    func showResertViewController()
}

final class EntryRouterImpl: EntryRouter {
    
    weak var controller: UIViewController?
    
    func showResertViewController() {
        let vc = ResertAssembler.assembly()
        controller?.navigationController?.pushViewController(vc, animated: false)
    }
}
