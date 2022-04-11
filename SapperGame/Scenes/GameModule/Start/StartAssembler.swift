//
//  StartAssembler.swift
//  SapperGame
//
//  Created by pavel mishanin on 06.04.2022.
//

import UIKit

final class StartAssembler {
    
    private init() {}
    
    static func assembly() -> UIViewController {
        
        let firebase = CustomFirebase()
        let interactor = InteractorImpl(firebase: firebase)
        let router = StartRouterImpl()
        let presenter = StartPresenterImpl(router: router, interactor: interactor)
        let superView = StartView()
        let controller = StartViewControllerImpl(presenter: presenter, superView: superView)
        superView.delegate = controller
        router.controller = controller
        
        return controller
    }
}
