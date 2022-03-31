//
//  AuthCustomTextField.swift
//  SapperGame
//
//  Created by pavel mishanin on 31.03.2022.
//

import UIKit
import Firebase

final class AuthTextField: UITextField {
    
    private var view: UIViewController?
    
    var textOrEmptyString: String {
        return text ?? ""
    }
    
    func configureTextField(view: UIViewController, placeholder: String) {
        self.view = view
//        self.delegate = self
        self.placeholder = placeholder
        self.borderStyle = .roundedRect
        self.translatesAutoresizingMaskIntoConstraints = false
        
        hideKeyboardWhenTappedAround()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.resignFirstResponder()
        return true
    }
    
    private func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view?.view.addGestureRecognizer(tap)
    }
    
    @objc private func dismissKeyboard() {
        view?.view.endEditing(true)
    }
}
