//
//  AuthViewController.swift
//  SapperGame
//
//  Created by pavel mishanin on 31.03.2022.
//

import UIKit
import Firebase

enum State {
    
}

final class AuthViewController: UIViewController, UITextFieldDelegate {
    
    private let vStackView = AuthStackView()
    private let nameTextField = AuthTextField()
    private let emailTextField = AuthTextField()
    private let passwordTextField = AuthTextField()
    private let enterButton = AuthButton()
    private let resetPasswordButton = AuthButton()
    private let goBackButton = AuthButton()
    private let alert = CustomAlert()
    
    private var nameConstraints = [NSLayoutConstraint]()
    private var stackConstraints = [NSLayoutConstraint]()
    private var defaultConstraint = [NSLayoutConstraint]()
    
    private var signUp: Bool = true {
        willSet{
            if newValue {
                title = "Registration"
                goBackButton.isHidden = true
                nameTextField.isHidden = false
                passwordTextField.isHidden = false
                resetPasswordButton.isHidden = true
                enterButton.customButton(title: "Do you already have an account?", action: #selector(enterButtonTapped), view: self, color: .blue)
            } else {
                nameTextField.isHidden = true
                resetPasswordButton.isHidden = false
                title = "Entry"
                enterButton.customButton(title: "No account? Registration", action: #selector(enterButtonTapped), view: self, color: .blue)
            }
        }
    }
    
    private var reset: Bool = true {
        willSet{
            if newValue {
                signUp.toggle()
                passwordTextField.isHidden = false
                goBackButton.isHidden = true
                enterButton.isHidden = false
//                alert.showAlert(view: self, title: "check your email", complition: nil)
                
                resetPasswordButton.customButton(title: "Do you forget your password?", action: #selector(resetPasswordButtonTapped), view: self, color: .blue)
            } else {
                title = "Reset"
                goBackButton.isHidden = false
                passwordTextField.isHidden = true
                enterButton.isHidden = true
                
                resetPasswordButton.customButton(title: "Reset", action: #selector(resetPasswordButtonTapped), view: self, color: .blue)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureLayoutHierarchy()
    }
    
    private func configureView() {
        title = "Registration"
        
        view.backgroundColor = .white
        
        goBackButton.isHidden = true
        goBackButton.customButton(title: "Go Back?", action: #selector(goBackButtonTapped), view: self, color: .blue)
        
        resetPasswordButton.isHidden = true
        resetPasswordButton.customButton(title: "Do you forget your password?", action: #selector(resetPasswordButtonTapped), view: self, color: .blue)
        
        nameTextField.configureTextField(view: self, placeholder: "name")
        nameTextField.delegate = self
        
        emailTextField.configureTextField(view: self, placeholder: "email")
        emailTextField.delegate = self
        passwordTextField.configureTextField(view: self, placeholder: "password")
        passwordTextField.delegate = self
        enterButton.customButton(title: "Do you already have an account?", action: #selector(enterButtonTapped), view: self, color: .blue)
        
        view.addSubview(vStackView)
        vStackView.addArrangedSubviews([nameTextField, emailTextField, passwordTextField, enterButton, resetPasswordButton, goBackButton])
    }
    
    @objc private func enterButtonTapped() {
        signUp.toggle()
    }
    
    func prin() {
        print(reset)
    }
    
    @objc private func goBackButtonTapped() {
        
        reset.toggle()
        print("goBackButtonTapped")
    }
    
    @objc private func resetPasswordButtonTapped() {
        
        reset.toggle()
        print("resetPasswordButtonTapped")
        
        if reset {
            let email = emailTextField.text!
            if !email.isEmpty{
                Auth.auth().sendPasswordReset(withEmail: email) { error in
                    if error == nil{
                        self.alert.showAlert(view: self, title: "check your email", complition: nil)
                    }
                }
            }
        }
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
    
    private func configureLayoutHierarchy() {
        configureLayouStack()
        configureLayouName()
        configureLayouDefault()
    }
    
    private func configureLayouStack() {
        
        stackConstraints.append(contentsOf: [
            vStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 40),
            vStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -40),
            vStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
        ])
        
        NSLayoutConstraint.activate(stackConstraints)
    }
    
    private func configureLayouName() {
        
        nameConstraints.append(contentsOf: [
            nameTextField.widthAnchor.constraint(equalTo: vStackView.widthAnchor),
            nameTextField.heightAnchor.constraint(equalToConstant: 40),
        ])
        
        NSLayoutConstraint.activate(nameConstraints)
    }
    
    private func configureLayouDefault() {
        
        defaultConstraint.append(contentsOf: [
            emailTextField.widthAnchor.constraint(equalTo: vStackView.widthAnchor),
            emailTextField.heightAnchor.constraint(equalToConstant: 40),
            
            passwordTextField.widthAnchor.constraint(equalTo: vStackView.widthAnchor),
            passwordTextField.heightAnchor.constraint(equalToConstant: 40),
            
            enterButton.widthAnchor.constraint(equalTo: vStackView.widthAnchor),
            enterButton.heightAnchor.constraint(equalToConstant: 60),
            
            goBackButton.widthAnchor.constraint(equalTo: vStackView.widthAnchor),
            goBackButton.heightAnchor.constraint(equalToConstant: 60),
            
            resetPasswordButton.widthAnchor.constraint(equalTo: vStackView.widthAnchor),
            resetPasswordButton.heightAnchor.constraint(equalToConstant: 60),
        ])
        
        NSLayoutConstraint.activate(defaultConstraint)
    }
}
