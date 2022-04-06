//
//  SceneDelegate.swift
//  SapperGame
//
//  Created by pavel mishanin on 28.03.2022.
//

import UIKit
import Firebase

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        
        Auth.auth().addStateDidChangeListener { auth, user in
            if user == nil {
                self.showAuthViewController(AuthAssembler.assembly())
            } else {
                self.showAuthViewController(StartAssembler.assembly())
            }
        }
    }
    
    private func showAuthViewController(_ viewController: UIViewController) {
        let navigationController = UINavigationController(rootViewController: viewController)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}
