//
//  AuthView.swift
//  SapperGame
//
//  Created by pavel mishanin on 05.04.2022.
//

import UIKit

protocol AuthViewDelegate: AnyObject {
    func entryButtonTapped()
    func createUser(name: String, email: String, password: String)
}

final class AuthView: UIView {
    
    weak var delegate: AuthViewDelegate?
    private let vStackView = AuthStackView()
    private let nameTextField = AuthTextField()
    private let emailTextField = AuthTextField()
    private let passwordTextField = AuthTextField()
    private let entryButton = AuthButton()
    private let authButton = AuthButton()
    
    init() {
        super.init(frame: CGRect())
        configureView()
        configureLayoutHierarchy()
        configureKeyboardToolbar()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureKeyboardToolbar() {
        nameTextField.keyboardToolbar(textFields: [nameTextField, emailTextField, passwordTextField], doneAction: #selector(authButtonTapped))
    }
    
    private func configureView() {
        backgroundColor = .white
        
        nameTextField.configureTextField(view: self, placeholder: "name")
        emailTextField.configureTextField(view: self, placeholder: "email")
        passwordTextField.configureTextField(view: self, placeholder: "password")
        
        entryButton.customButton(title: "Have you got an account? Entry", action: #selector(entryButtonTapped), view: self, color: .blue)
        authButton.customButton(title: "Auth", action: #selector(authButtonTapped), view: self, color: .blue)
        
        addSubview(vStackView)
        vStackView.addArrangedSubviews([nameTextField, emailTextField, passwordTextField, entryButton, authButton])
    }
    
    @objc private func entryButtonTapped() {
        delegate?.entryButtonTapped()
    }
    
    @objc private func authButtonTapped() {
        let name = nameTextField.text!
        let email = emailTextField.text!
        let password = passwordTextField.text!
        delegate?.createUser(name: name, email: email, password: password)
    }
    
    private func configureLayoutHierarchy() {
        NSLayoutConstraint.activate([
            vStackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 40),
            vStackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -40),
            vStackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 40),
            
            nameTextField.widthAnchor.constraint(equalTo: vStackView.widthAnchor),
            nameTextField.heightAnchor.constraint(equalToConstant: 40),
            
            emailTextField.widthAnchor.constraint(equalTo: vStackView.widthAnchor),
            emailTextField.heightAnchor.constraint(equalToConstant: 40),
            
            passwordTextField.widthAnchor.constraint(equalTo: vStackView.widthAnchor),
            passwordTextField.heightAnchor.constraint(equalToConstant: 40),
            
            entryButton.widthAnchor.constraint(equalTo: vStackView.widthAnchor),
            entryButton.heightAnchor.constraint(equalToConstant: 60),
            
            authButton.widthAnchor.constraint(equalTo: vStackView.widthAnchor),
            authButton.heightAnchor.constraint(equalToConstant: 60),
        ])
    }
}
