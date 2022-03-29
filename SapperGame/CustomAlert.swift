//
//  CustomAlert.swift
//  SapperGame
//
//  Created by pavel mishanin on 29.03.2022.
//

import UIKit

final class CustomAlert {
    
    func showAlert(view: UIViewController, title: String, complition: @escaping () -> ()) {
        
        let alertController = UIAlertController(title: title, message: nil, preferredStyle: .alert)
    
        let action = UIAlertAction(title: "Ok", style: .default) {_ in
            complition()
        }
        alertController.addAction(action)
        
        view.present(alertController, animated: false, completion: nil)
    }
}
