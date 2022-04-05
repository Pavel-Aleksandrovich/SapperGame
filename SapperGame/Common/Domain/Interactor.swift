//
//  AuthInteractor.swift
//  SapperGame
//
//  Created by pavel mishanin on 05.04.2022.
//

import Foundation

protocol Interactor {
    func sendPasswordReset(email: String, complition: @escaping (Result<String, ErrorMessage>) -> ())
    func signIn(email: String, password: String, complition: @escaping (ErrorMessage) -> ())
    func signOut(complition: @escaping (ErrorMessage) -> ())
    func createUser(name: String, email: String, password: String, complition: @escaping (ErrorMessage) -> ())
}

final class InteractorImpl: Interactor {
    
    private let firebase: CustomFirebase
    
    init(firebase: CustomFirebase) {
        self.firebase = firebase
    }
    
    func sendPasswordReset(email: String, complition: @escaping (Result<String, ErrorMessage>) -> ()) {
        firebase.sendPasswordReset(email: email, complition: complition)
    }
    
    func signIn(email: String, password: String, complition: @escaping (ErrorMessage) -> ()) {
        firebase.signIn(email: email, password: password, complition: complition)
    }
    
    func signOut(complition: @escaping (ErrorMessage) -> ()) {
        firebase.signOut(complition: complition)
    }
    
    func createUser(name: String, email: String, password: String, complition: @escaping (ErrorMessage) -> ()) {
        firebase.createUser(name: name, email: email, password: password, complition: complition)
    }
}
