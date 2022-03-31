//
//  AuthViewController.swift
//  SapperGame
//
//  Created by pavel mishanin on 31.03.2022.
//

import UIKit

final class AuthViewController: UIViewController {
    
    private let vStackView = AuthCustomStackView()
    private let nameTextField = UITextField()
    private let emailTextField = UITextField()
    private let passwordTextField = UITextField()
    private let enterButton = AuthCustomButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureLayoutConstraints()
    }
    
    private func configureView() {
        
        title = "Auth"
        view.backgroundColor = .white
        
        nameTextField.delegate = self
        nameTextField.placeholder = "name"
        nameTextField.borderStyle = .roundedRect
        
        emailTextField.delegate = self
        emailTextField.placeholder = "email"
        emailTextField.borderStyle = .roundedRect
        
        passwordTextField.delegate = self
        passwordTextField.placeholder = "password"
        passwordTextField.borderStyle = .roundedRect
        
        enterButton.customButton(title: "Enter", action: #selector(enterButtonTapped), view: self, color: .blue)
        
        [nameTextField, emailTextField, passwordTextField].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        view.addSubview(vStackView)
        vStackView.addArrangedSubview(nameTextField)
        vStackView.addArrangedSubview(emailTextField)
        vStackView.addArrangedSubview(passwordTextField)
        vStackView.addArrangedSubview(enterButton)
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

extension AuthViewController: UITextFieldDelegate {
}
