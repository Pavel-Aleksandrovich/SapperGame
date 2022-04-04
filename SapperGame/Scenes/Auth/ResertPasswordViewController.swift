//
//  ResertPasswordViewController.swift
//  SapperGame
//
//  Created by pavel mishanin on 04.04.2022.
//

import UIKit
import Firebase

final class ResertPasswordViewController: UIViewController {
    
    private let vStackView = AuthStackView()
    private let emailTextField = AuthTextField()
    private let resertButton = AuthButton()
    private let goBackButton = AuthButton()
    private let alert = CustomAlert()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureLayout()
    }
    
    private func configureView() {
        title = "Resert"
        view.backgroundColor = .white
        
        emailTextField.configureTextField(view: self, placeholder: "email")
        
        resertButton.customButton(title: "Resert", action: #selector(resertPassword), view: self, color: .blue)
        goBackButton.customButton(title: "Go back", action: #selector(goToAuth), view: self, color: .blue)
        
        view.addSubview(vStackView)
        vStackView.addArrangedSubviews([emailTextField, resertButton, goBackButton])
    }
    
    @objc private func resertPassword() {
        let email = emailTextField.text!
        if !email.isEmpty{
            emailTextField.text! = ""
            Auth.auth().sendPasswordReset(withEmail: email) { error in
                
                if error == nil{
                    self.alert.showAlert(view: self, title: "check your email", complition: nil)
                } else {
                    self.alert.showAlert(view: self, title: "error", complition: nil)
                }
            }
        } else {
            alert.showAlert(view: self, title: "enter email", complition: nil)
        }
    }
    
    @objc private func goToAuth() {
        navigationController?.popToRootViewController(animated: true)
    }
    
    private func configureLayout() {
        
        NSLayoutConstraint.activate([
            vStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 40),
            vStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -40),
            vStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            
            emailTextField.widthAnchor.constraint(equalTo: vStackView.widthAnchor),
            emailTextField.heightAnchor.constraint(equalToConstant: 40),
            
            resertButton.widthAnchor.constraint(equalTo: vStackView.widthAnchor),
            resertButton.heightAnchor.constraint(equalToConstant: 60),
            
            goBackButton.widthAnchor.constraint(equalTo: vStackView.widthAnchor),
            goBackButton.heightAnchor.constraint(equalToConstant: 60),
        ])
    }
}
