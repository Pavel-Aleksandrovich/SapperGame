//
//  AuthViewController.swift
//  SapperGame
//
//  Created by pavel mishanin on 31.03.2022.
//

import UIKit
import Firebase

final class AuthViewController: UIViewController, UITextFieldDelegate {
    
    private let vStackView = AuthStackView()
    private let nameTextField = AuthTextField()
    private let emailTextField = AuthTextField()
    private let passwordTextField = AuthTextField()
    private let enterButton = AuthButton()
    
    private var signUp: Bool = true {
        willSet{
            if newValue {
                title = "Auth"
            } else {
                title = "Entry"
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureLayoutConstraints()
    }
    
    private func configureView() {
        title = "Auth"
        
        view.backgroundColor = .white
        
        nameTextField.configureTextField(view: self, placeholder: "name")
        nameTextField.delegate = self
        emailTextField.configureTextField(view: self, placeholder: "email")
        emailTextField.delegate = self
        passwordTextField.configureTextField(view: self, placeholder: "password")
        passwordTextField.delegate = self
        enterButton.customButton(title: "Entry", action: #selector(enterButtonTapped), view: self, color: .blue)
        
        view.addSubview(vStackView)
        vStackView.addArrangedSubviews([nameTextField, emailTextField, passwordTextField, enterButton])
    }
    
    @objc private func enterButtonTapped() {
        signUp.toggle()
        print("tap")
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        Test@mail.ru
// name:       Test-test
//password:        TestTest
        let name = nameTextField.text!
        let email = emailTextField.text!
        let password = passwordTextField.text!
        
        if signUp {
            if (!name.isEmpty && !email.isEmpty && !password.isEmpty) {
                Auth.auth().createUser(withEmail: email, password: password) { result, error in
                    if error == nil {
                        if let result = result {
                            print(result.user.uid)
                            print("register")
                            
                            let ref = Database.database().reference().child("users")
                            ref.child(result.user.uid).updateChildValues(["name": name, "email": email])
                        }
                    }
                }
            } else {
                print("error. fill in the fields")
            }
        } else {
            if (!email.isEmpty && !password.isEmpty) {
                
                Auth.auth().signIn(withEmail: email, password: password) { result, error in
                    if error == nil {
                        print("enter complete")
                    }
                }
            }else {
                print("bag")
            }
        }
        
        
        
        
        
        return true
    }
    
    private func configureLayoutConstraints() {
        NSLayoutConstraint.activate([
            
            vStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 40),
            vStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -40),
            vStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            
            nameTextField.widthAnchor.constraint(equalTo: vStackView.widthAnchor),
            nameTextField.heightAnchor.constraint(equalToConstant: 40),
            
            emailTextField.widthAnchor.constraint(equalTo: vStackView.widthAnchor),
            emailTextField.heightAnchor.constraint(equalToConstant: 40),
            
            passwordTextField.widthAnchor.constraint(equalTo: vStackView.widthAnchor),
            passwordTextField.heightAnchor.constraint(equalToConstant: 40),
            
            enterButton.widthAnchor.constraint(equalTo: vStackView.widthAnchor),
            enterButton.heightAnchor.constraint(equalToConstant: 60),
        ])
    }
}
