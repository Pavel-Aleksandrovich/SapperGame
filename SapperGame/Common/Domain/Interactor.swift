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
    func checkInternetConnection(complition: @escaping (Bool) -> ())
}

final class InteractorImpl: Interactor {
    
    private let firebase: CustomFirebase
    private let internetConnection = InternetConnection()
    
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
    
    func checkInternetConnection(complition: @escaping (Bool) -> ()) {
        
//        switch internetConnection.isNetworkAvailable() {
//        case true:
//            complition(true)
//        case false:
//            complition(false)
//        }
        internetConnection.addInternetStatusListener { status in
            print(status)
        }
        
        internetConnection.networkAvailableHandler = { bool in
            switch bool {
            case true:
                complition(true)
            case false:
                complition(false)
            }
        }
    }
}
