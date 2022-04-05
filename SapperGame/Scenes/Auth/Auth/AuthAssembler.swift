//
//  AuthAssembler.swift
//  SapperGame
//
//  Created by pavel mishanin on 05.04.2022.
//

import UIKit

final class AuthAssembler {
    
    static func assembly() -> UIViewController {
        
        let firebase = CustomFirebase()
        let interactor = InteractorImpl(firebase: firebase)
        let router = AuthRouterImpl()
        let presenter = AuthPresenterImpl(router: router, interactor: interactor)
        let superView = AuthView()
        let controller = AuthViewControllerImpl(presenter: presenter, superView: superView)
        superView.delegate = controller
        router.controller = controller
        
        return controller
    }
}
