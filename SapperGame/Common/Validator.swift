//
//  Validator.swift
//  SapperGame
//
//  Created by pavel mishanin on 11.04.2022.
//

import Foundation

enum ValirationResult {
    case success
    case failure(ErrorMessage)
}

final class Validator {
    
    private enum Constant {
        static let characters = 6
    }
    
    func createUserValidation(name: String, email: String, password: String, complition: @escaping(ValirationResult) -> ()) {
        
        if notEmpty([name, email, password]) {
            if password.count > Constant.characters {
                complition(.success)
            } else {
                complition(.failure(.shortPassword))
            }
        } else {
            complition(.failure(.emptyFields))
        }
    }
    
    func signInValidation(email: String, password: String, complition: @escaping(ValirationResult) -> ()) {
        
        if notEmpty([email, password]) {
            if password.count > Constant.characters {
                complition(.success)
            } else {
                complition(.failure(.shortPassword))
            }
        } else {
            complition(.failure(.emptyFields))
        }
    }
    
    func sendPasswordResetValidation(email: String, complition: @escaping(ValirationResult) -> ()) {
        
        if notEmpty([email]) {
            complition(.success)
        } else {
            complition(.failure(.emptyFields))
        }
    }
    
    private func notEmpty(_ textFields: [String]) -> Bool {
        var amount = Int()
        for i in 0..<textFields.count {
            if !textFields[i].isEmpty {
                amount += 1
            }
        }
       return amount == textFields.count ? true : false
    }
}
