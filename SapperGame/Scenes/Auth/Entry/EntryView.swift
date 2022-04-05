//
//  EntryView.swift
//  SapperGame
//
//  Created by pavel mishanin on 05.04.2022.
//

import UIKit

protocol EntryViewDelegate: AnyObject {
    func forgetPasswordButtonTapped()
    func signIn(email: String, password: String)
}

final class EntryView: UIView {
    
    weak var delegate: EntryViewDelegate?
    private let vStackView = AuthStackView()
    private let emailTextField = AuthTextField()
    private let passwordTextField = AuthTextField()
    private let entryButton = AuthButton()
    private let forgetPasswordButton = AuthButton()
    
    init() {
        super.init(frame: CGRect())
        configureView()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureView() {
        backgroundColor = .white
        emailTextField.configureTextField(view: self, placeholder: "email")

        passwordTextField.configureTextField(view: self, placeholder: "password")
        
        entryButton.customButton(title: "Entry", action: #selector(entryButtonTapped), view: self, color: .blue)
        forgetPasswordButton.customButton(title: "Forget the password", action: #selector(forgetPasswordButtonTapped), view: self, color: .blue)
        
        addSubview(vStackView)
        vStackView.addArrangedSubviews([emailTextField, passwordTextField, entryButton, forgetPasswordButton])
    }
    
    @objc private func forgetPasswordButtonTapped() {
        delegate?.forgetPasswordButtonTapped()
    }
    
    @objc private func entryButtonTapped() {
        let password = passwordTextField.text!
        let email = emailTextField.text!
        delegate?.signIn(email: email, password: password)
    }
    
    private func configureLayout() {
        
        NSLayoutConstraint.activate([
            vStackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 40),
            vStackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -40),
            vStackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 40),
            
            emailTextField.widthAnchor.constraint(equalTo: vStackView.widthAnchor),
            emailTextField.heightAnchor.constraint(equalToConstant: 40),
            
            passwordTextField.widthAnchor.constraint(equalTo: vStackView.widthAnchor),
            passwordTextField.heightAnchor.constraint(equalToConstant: 40),
            
            entryButton.widthAnchor.constraint(equalTo: vStackView.widthAnchor),
            entryButton.heightAnchor.constraint(equalToConstant: 60),
            
            forgetPasswordButton.widthAnchor.constraint(equalTo: vStackView.widthAnchor),
            forgetPasswordButton.heightAnchor.constraint(equalToConstant: 60),
        ])
    }
}
