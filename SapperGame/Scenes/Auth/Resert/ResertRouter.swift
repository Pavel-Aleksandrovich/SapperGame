//
//  ResertRouter.swift
//  SapperGame
//
//  Created by pavel mishanin on 05.04.2022.
//

import UIKit

protocol ResertRouter {
    func popToRootViewController()
}

final class ResertRouterImpl: ResertRouter {
    
    weak var controller: UIViewController?
    
    func popToRootViewController() {
        controller?.navigationController?.popToRootViewController(animated: true)
    }
}
