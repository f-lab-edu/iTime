//
//  File.swift
//  
//
//  Created by 이상헌 on 2023/10/26.
//

import AuthenticationServices

// MARK: - ASAuthorizationContextProviding

public protocol ASAuthorizationContextProviding: ASAuthorizationControllerPresentationContextProviding {}

// MARK: - FirebaseAppleLoginRepository

public protocol FirebaseAppleAuthenticationRepository {
    func signInWithApple(_ presentation: ASAuthorizationContextProviding)
    func signOut()
    func deleteCurrentUser(_ presentation: ASAuthorizationContextProviding)
}
