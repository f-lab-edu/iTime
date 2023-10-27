//
//  File.swift
//  
//
//  Created by 이상헌 on 2023/10/26.
//

import Platform

// MARK: ㅡ AuthenticaitonUsecase

public protocol AuthenticationUsecase {
    func appleSignUp(_ presentation: ASAuthorizationContextProviding)
    func signOut()
    func deleteUser(_ presentation: ASAuthorizationContextProviding)
}
