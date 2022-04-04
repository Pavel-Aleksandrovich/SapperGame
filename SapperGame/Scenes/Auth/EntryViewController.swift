//
//  EntryViewController.swift
//  SapperGame
//
//  Created by pavel mishanin on 04.04.2022.
//

import UIKit
import Firebase

//        Test@mail.ru
// name:       Test-test
//password:        TestTest

final class EntryViewController: UIViewController {
    
    private let vStackView = AuthStackView()
    private let emailTextField = AuthTextField()
    private let passwordTextField = AuthTextField()
    private let enterButton = AuthButton()
    private let goBackButton = AuthButton()
    private let alert = CustomAlert()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true 
        configureView()
        configureLayout()
    }
    
    private func configureView() {
        view.backgroundColor = .white
        emailTextField.configureTextField(view: self, placeholder: "email")
        
        passwordTextField.configureTextField(view: self, placeholder: "password")
        
        enterButton.customButton(title: "Entry", action: #selector(entry), view: self, color: .blue)
        goBackButton.customButton(title: "Forget the password", action: #selector(forgetPasswordButtonTapped), view: self, color: .blue)
        title = "Entry"
        
        view.addSubview(vStackView)
        vStackView.addArrangedSubviews([emailTextField, passwordTextField, enterButton, goBackButton])
    }
    
    @objc private func forgetPasswordButtonTapped() {
        let vc = ResertPasswordViewController()
        navigationController?.pushViewController(vc, animated: false)
    }
    
    @objc private func entry() {
        let password = passwordTextField.text!
        let email = emailTextField.text!
        
        if (!email.isEmpty && !password.isEmpty) {
            
            Auth.auth().signIn(withEmail: email, password: password) { result, error in
                if error == nil {
                    print("enter complete")
                } else {
                    self.alert.showAlert(view: self, title: "enter error", complition: nil)
                }
            }
        }else {
            alert.showAlert(view: self, title: "fill in the fields", complition: nil)
        }
    }
    
    private func configureLayout() {
        
        NSLayoutConstraint.activate([
            vStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 40),
            vStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -40),
            vStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            
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
