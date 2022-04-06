//
//  EntryAssembler.swift
//  SapperGame
//
//  Created by pavel mishanin on 05.04.2022.
//

import UIKit

final class EntryAssembler {
    
    static func assembly() -> UIViewController {
        
        let firebase = CustomFirebase()
        let interactor = InteractorImpl(firebase: firebase)
        let router = EntryRouterImpl()
        let presenter = EntryPresenterImpl(router: router, interactor: interactor)
        let superView = EntryView()
        let controller = EntryViewControllerImpl(presenter: presenter, superView: superView)
        superView.delegate = controller
        router.controller = controller
        
        return controller
    }
}
