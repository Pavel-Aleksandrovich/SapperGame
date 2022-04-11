//
//  ResertAssembler.swift
//  SapperGame
//
//  Created by pavel mishanin on 05.04.2022.
//

import UIKit

final class ResertAssembler {
    
    private init() {}
    
    static func assembly() -> UIViewController {
        
        let firebase = CustomFirebase()
        let interactor = InteractorImpl(firebase: firebase)
        let router = ResertRouterImpl()
        let presenter = ResertPresenterImpl(router: router, interactor: interactor)
        let superView = ResetView()
        let controller = ResetViewControllerImpl(presenter: presenter, superView: superView)
        superView.delegate = controller
        router.controller = controller
        
        return controller
    }
}
