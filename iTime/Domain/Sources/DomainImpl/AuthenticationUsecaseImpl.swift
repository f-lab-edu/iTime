//
//  File.swift
//  
//
//  Created by 이상헌 on 2023/10/27.
//

import Foundation

import Platform
import Domain

// MARK: - AuthenticationUsecaseImpl

public final class AuthenticationUsecaseImpl: AuthenticationUsecase {
    
    // MARK: - Properties
    
    private let appleAuthenticationRepository: FirebaseAppleAuthenticationRepository
    
    // MARK: initialize
    
    public init(appleAuthenticationRepository: FirebaseAppleAuthenticationRepository) {
        self.appleAuthenticationRepository = appleAuthenticationRepository
    }
    
    public func appleSignUp(_ presentation: ASAuthorizationContextProviding) {
        appleAuthenticationRepository.signInWithApple(presentation)
    }
    
    public func signOut() {
        appleAuthenticationRepository.signOut()
    }
    
    public func deleteUser(_ presentation: ASAuthorizationContextProviding) {
        appleAuthenticationRepository.deleteCurrentUser(presentation)
    }
}
