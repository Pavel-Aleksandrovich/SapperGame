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

final class Validation {
    
    private enum Constant {
        static let characters = 6
    }
    
    func createUserValidation(name: String, email: String, password: String, complition: @escaping(ValirationResult) -> ()) {
        
        if isAnyElementEmpty([name, email, password]) {
            complition(.failure(.emptyFields))
        } else {
            if password.count > Constant.characters {
                complition(.success)
            } else {
                complition(.failure(.shortPassword))
            }
        }
    }
    
    func signInValidation(email: String, password: String, complition: @escaping(ValirationResult) -> ()) {
        
        if isAnyElementEmpty([email, password]) {
            complition(.failure(.emptyFields))
        } else {
            if password.count > Constant.characters {
                complition(.success)
            } else {
                complition(.failure(.shortPassword))
            }
        }
    }
    // TODO: Delete complition
    // FIXME:
    // MARK:
//    #warning("Delete complition use return")
    
    // create for each field his own class validator
    // отдельно для емаил , отдельно для пароля и отдельно для имени и все это вызывать в интересторе
    // добавить протоколоы для
    func sendPasswordResetValidation(email: String, complition: @escaping(ValirationResult) -> ()) {
        
        if email.isEmpty {
            complition(.failure(.emptyFields))
        } else {
            complition(.success)
        }
    }
    
    private func isAnyElementEmpty(_ textFields: [String]) -> Bool {
        
        for i in 0..<textFields.count {
            if textFields[i].isEmpty {
                return false
            }
        }
        return true
    }
}

final class PasswordValidator {
    
    func isValid(password: String) -> ValirationResult {
        
        if password.isEmpty {
            return .failure(.emptyFields)
        } else {
            return .success
        }
    }
}
