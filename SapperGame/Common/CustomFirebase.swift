//
//  CustomFirebase.swift
//  SapperGame
//
//  Created by pavel mishanin on 04.04.2022.
//

import UIKit
import Firebase

enum ErrorMessage: String, Error {
    case unableAuth = "Unable Auth. Please try again."
    case emptyFields = "Fill in the fields"
    case authError = "Auth error. Please try again"
    case enterError = "Enter error. Please try again"
    case signOutError = "SignOut error. Please try again"
    case signInError = "SignIn error. Please try again"
    case resetPasswordError = "Reset password error. This is email is not exist"
}

final class CustomFirebase {
    
    func sendPasswordReset(email: String, complition: @escaping (Result<String, ErrorMessage>) -> ()) {
        if !email.isEmpty{
            Auth.auth().sendPasswordReset(withEmail: email) { error in
                if error == nil{
                    complition(.success("check your email"))
                } else {
                    complition(.failure(.resetPasswordError))
                }
            }
        } else {
            complition(.failure(.emptyFields))
        }
    }
    
    func signIn(email: String, password: String, complition: @escaping (ErrorMessage) -> ()) {
        
        if (!email.isEmpty && !password.isEmpty) {
            Auth.auth().signIn(withEmail: email, password: password) { result, error in
                if error != nil {
                    complition(.signInError)
                }
            }
        } else {
            complition(.emptyFields)
        }
    }
    
    func signOut(complition: @escaping (ErrorMessage) -> ()) {
        do{
            try Auth.auth().signOut()
        }catch {
            complition(.signOutError)
        }
    }
    
    func createUser(name: String, email: String, password: String, complition: @escaping (ErrorMessage) -> ()) {
        
        if (!name.isEmpty && !email.isEmpty && !password.isEmpty) {
            
            Auth.auth().createUser(withEmail: email, password: password) { result, error in
                if error == nil {
                    if let result = result {
                        print(result.user.uid)
                        
                        let ref = Database.database().reference().child("users")
                        ref.child(result.user.uid).updateChildValues(["name": name, "email": email])
                    }
                } else {
                    complition(.authError)
                }
            }
        } else {
            complition(.emptyFields)
        }
    }
}
