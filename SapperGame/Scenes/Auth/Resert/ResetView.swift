//
//  ResetView.swift
//  SapperGame
//
//  Created by pavel mishanin on 05.04.2022.
//

import UIKit

protocol ResetViewDelegate: AnyObject {
    func entryButtonTapped()
    func resetPasswordButtonTapped(email: String)
}

final class ResetView: UIView {
    
    weak var delegate: ResetViewDelegate?
    private let vStackView = AuthStackView()
    private let emailTextField = AuthTextField()
    private let resertButton = AuthButton()
    private let popToRootButton = AuthButton()
    
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
        
        resertButton.customButton(title: "Resert", action: #selector(resetPasswordButtonTapped), view: self, color: .blue)
        popToRootButton.customButton(title: "Go back", action: #selector(popToRootButtonTapped), view: self, color: .blue)
        
        addSubview(vStackView)
        vStackView.addArrangedSubviews([emailTextField, resertButton, popToRootButton])
    }
    
    @objc private func resetPasswordButtonTapped() {
        let email = emailTextField.text!
        delegate?.resetPasswordButtonTapped(email: email)
    }
    
    @objc private func popToRootButtonTapped() {
        delegate?.entryButtonTapped()
    }
    
    private func configureLayout() {
        
        NSLayoutConstraint.activate([
            vStackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 40),
            vStackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -40),
            vStackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 40),
            
            emailTextField.widthAnchor.constraint(equalTo: vStackView.widthAnchor),
            emailTextField.heightAnchor.constraint(equalToConstant: 40),
            
            resertButton.widthAnchor.constraint(equalTo: vStackView.widthAnchor),
            resertButton.heightAnchor.constraint(equalToConstant: 60),
            
            popToRootButton.widthAnchor.constraint(equalTo: vStackView.widthAnchor),
            popToRootButton.heightAnchor.constraint(equalToConstant: 60),
        ])
    }
}
