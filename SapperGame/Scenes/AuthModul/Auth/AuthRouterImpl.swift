//
//  AuthRouterImpl.swift
//  SapperGame
//
//  Created by pavel mishanin on 05.04.2022.
//

import UIKit

protocol AuthRouter {
    func showEntryViewController()
}

final class AuthRouterImpl: AuthRouter {
    
    weak var controller: UIViewController?
    
    func showEntryViewController() {
        let vc = EntryAssembler.assembly()
        controller?.navigationController?.pushViewController(vc, animated: false)
    }
}
