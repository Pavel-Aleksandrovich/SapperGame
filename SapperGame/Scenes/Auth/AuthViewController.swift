//
//  AuthViewController.swift
//  SapperGame
//
//  Created by pavel mishanin on 31.03.2022.
//

import UIKit
import Firebase

final class AuthViewController: UIViewController {
    
    private let vStackView = AuthStackView()
    private let nameTextField = AuthTextField()
    private let emailTextField = AuthTextField()
    private let passwordTextField = AuthTextField()
    private let enterButton = AuthButton()
    private let goBackButton = AuthButton()
    private let alert = CustomAlert()
    let al = Alert()
    
    private var nameConstraints = [NSLayoutConstraint]()
    private var stackConstraints = [NSLayoutConstraint]()
    private var defaultConstraint = [NSLayoutConstraint]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureLayoutHierarchy()
    }
    
    private func configureView() {
        view.backgroundColor = .white
        
        nameTextField.configureTextField(view: self, placeholder: "name")
        emailTextField.configureTextField(view: self, placeholder: "email")
        passwordTextField.configureTextField(view: self, placeholder: "password")
        
        enterButton.customButton(title: "Have you got an account? Entry", action: #selector(enterButtonTapped), view: self, color: .blue)
        goBackButton.customButton(title: "Auth", action: #selector(auth), view: self, color: .blue)
        title = "Auth"
        
        view.addSubview(vStackView)
        vStackView.addArrangedSubviews([nameTextField, emailTextField, passwordTextField, enterButton, goBackButton])
    }
    
    @objc private func enterButtonTapped() {
        let vc = EntryViewController()
        navigationController?.pushViewController(vc, animated: false)
    }
    
    @objc private func auth() {
        let name = nameTextField.text!
        let email = emailTextField.text!
        let password = passwordTextField.text!
        
        if (!name.isEmpty && !email.isEmpty && !password.isEmpty) {
            
            Auth.auth().createUser(withEmail: email, password: password) { result, error in
                if error == nil {
                    if let result = result {
                        print(result.user.uid)
                        
                        let ref = Database.database().reference().child("users")
                        ref.child(result.user.uid).updateChildValues(["name": name, "email": email])
                    }
                }
            }
        } else {
            alert.showAlert(view: self, title: "fill in the fields", complition: nil)
        }
    }
    
    private func configureLayoutHierarchy() {
        
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
            
            goBackButton.widthAnchor.constraint(equalTo: vStackView.widthAnchor),
            goBackButton.heightAnchor.constraint(equalToConstant: 60),
        ])
    }
}
