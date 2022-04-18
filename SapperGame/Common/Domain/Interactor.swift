//
//  AuthInteractor.swift
//  SapperGame
//
//  Created by pavel mishanin on 05.04.2022.
//

import Foundation

protocol Interactor {
    func sendPasswordReset(email: String, complition: @escaping (ValirationResult) -> ())
    func signIn(email: String, password: String, complition: @escaping (ErrorMessage) -> ())
    func signOut(complition: @escaping (ErrorMessage) -> ())
    func createUser(name: String, email: String, password: String, complition: @escaping (ErrorMessage) -> ())
    func checkInternetConnection(complition: @escaping (Bool) -> ())
    func playSound(sound: Sound)
}

final class InteractorImpl: Interactor {
    
    private let firebase: CustomFirebase
    private let internetConnection = InternetConnection()
    private let validator = Validation()
    private let player = SapperAVAudioPlayer()
    
    init(firebase: CustomFirebase) {
        self.firebase = firebase
    }
    
    func sendPasswordReset(email: String, complition: @escaping (ValirationResult) -> ()) {
        
        validator.sendPasswordResetValidation(email: email) { [ weak self ] validationState in
            switch validationState {
            case .success:
                self?.firebase.sendPasswordReset(email: email, complition: complition)
            case .failure(let error):
                complition(.failure(error))
            }
        }
    }
    
    func signIn(email: String, password: String, complition: @escaping (ErrorMessage) -> ()) {
        
        validator.signInValidation(email: email, password: password) { [ weak self ] validationState in
            switch validationState {
            case .success:
                self?.firebase.signIn(email: email, password: password, complition: complition)
            case .failure(let error):
                complition(error)
            }
        }
    }
    
    func signOut(complition: @escaping (ErrorMessage) -> ()) {
        firebase.signOut(complition: complition)
    }
    
    func createUser(name: String, email: String, password: String, complition: @escaping (ErrorMessage) -> ()) {
        
        validator.createUserValidation(name: name, email: email, password: password) { [ weak self ] validationState in
            switch validationState {
            case .success:
                self?.firebase.createUser(name: name, email: email, password: password, complition: complition)
            case .failure(let error):
                complition(error)
            }
        }
    }
    
    func checkInternetConnection(complition: @escaping (Bool) -> ()) {
        
        internetConnection.setInternetStatusListener(complition: complition)
    }
    
    func playSound(sound: Sound) {
        player.playSound(sound: sound)
    }
}
