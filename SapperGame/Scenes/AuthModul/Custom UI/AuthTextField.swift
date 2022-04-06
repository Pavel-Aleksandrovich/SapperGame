//
//  AuthCustomTextField.swift
//  SapperGame
//
//  Created by pavel mishanin on 31.03.2022.
//

import UIKit
import Firebase

final class AuthTextField: UITextField, UITextFieldDelegate {
    
    private var view: UIView?
    
    var textOrEmptyString: String {
        return text ?? ""
    }
    
    func configureTextField(view: UIView, placeholder: String) {
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
        view?.addGestureRecognizer(tap)
    }

    @objc private func dismissKeyboard() {
        view?.endEditing(true)
    }
    
    func keyboardToolbar(textFields: [UITextField], doneAction: Selector) {
        let toolbar = UIToolbar(frame:CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        toolbar.barStyle = .default
        
        toolbar.items = [
            UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelTapped)),
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
            UIBarButtonItem(title: "Done", style: .plain, target: view, action: doneAction)
        ]
        toolbar.sizeToFit()
        textFields.forEach {
            $0.inputAccessoryView = toolbar
        }
    }
    
    @objc func cancelTapped() {
        view?.endEditing(true)
    }
}
