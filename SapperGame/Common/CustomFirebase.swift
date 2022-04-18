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
    case shortPassword = "Too short Password. Must be 7 characters"
}

final class CustomFirebase {
    
    private let someAuth = Auth.auth()
    
    func sendPasswordReset(email: String, complition: @escaping (ValirationResult) -> ()) {
        
        someAuth.sendPasswordReset(withEmail: email) { error in
            // вынести логику обработки ошибок в интерактор и там её фильтровать и решать что делать
            if ((error as? CFNetworkErrors) != nil) {
                
            }
            
            
            
            if error == nil{
                
                complition(.success)
            } else {
                complition(.failure(.resetPasswordError))
            }
        }
    }
    
    func signIn(email: String, password: String, complition: @escaping (ErrorMessage) -> ()) {
        
        someAuth.signIn(withEmail: email, password: password) { result, error in
            if result == nil {
                complition(.signInError)
            } else {
                print("success")
            }
            
            if error != nil {
                complition(.signInError)
            }
        }
    }
    
    func signOut(complition: @escaping (ErrorMessage) -> ()) {
        
        do{
            try someAuth.signOut()
        }catch {
            complition(.signOutError)
        }
    }
    
    func createUser(name: String, email: String, password: String, complition: @escaping (ErrorMessage) -> ()) {
        
        someAuth.createUser(withEmail: email, password: password) { result, error in
            
            if error != nil {
                complition(.authError)
                return
            }
            
            let uid = result?.user.uid
            
            if let uid = uid {
                let ref = Database.database().reference().child("users")
                ref.child(uid).updateChildValues(["name": name, "email": email])
            } else {
                complition(.authError)
            }
        }
    }
}
