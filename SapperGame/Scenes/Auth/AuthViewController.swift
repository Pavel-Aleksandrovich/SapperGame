//
//  AuthViewController.swift
//  SapperGame
//
//  Created by pavel mishanin on 31.03.2022.
//

import UIKit

final class AuthViewController: UIViewController {
    
    private let vStackView = AuthStackView()
    private let nameTextField = AuthTextField()
    private let emailTextField = AuthTextField()
    private let passwordTextField = AuthTextField()
    private let enterButton = AuthButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureLayoutConstraints()
    }
    
    private func configureView() {
        
        title = "Auth"
        view.backgroundColor = .white
        
        nameTextField.configureTextField(view: self, placeholder: "name")
        
        emailTextField.configureTextField(view: self, placeholder: "email")
        
        passwordTextField.configureTextField(view: self, placeholder: "password")
        
        enterButton.customButton(title: "Enter", action: #selector(enterButtonTapped), view: self, color: .blue)
        
        view.addSubview(vStackView)
        vStackView.addArrangedSubviews([nameTextField, emailTextField, passwordTextField, enterButton])
    }
    
    @objc private func enterButtonTapped() {
        print("tap")
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
