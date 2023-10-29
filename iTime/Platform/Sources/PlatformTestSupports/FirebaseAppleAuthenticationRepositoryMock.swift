//
//  File.swift
//  
//
//  Created by 이상헌 on 2023/10/29.
//

import Platform

// MARK: - FirebaseAppleAuthenticationRepositoryMock

public final class FirebaseAppleAuthenticationRepositoryMock: FirebaseAppleAuthenticationRepository {
    
    public var signWithAppleCallCount = 0
    public var signWithPresentation: ASAuthorizationContextProviding?
    public func signInWithApple(_ presentation: Platform.ASAuthorizationContextProviding) {
        signWithAppleCallCount += 1
        signWithPresentation = presentation
    }
    
    public var signOutCallCount = 0
    public func signOut() {
        signOutCallCount += 1
    }
    
    public var deleteCurrentUserCallCount = 0
    public func deleteCurrentUser(_ presentation: Platform.ASAuthorizationContextProviding) {
        deleteCurrentUserCallCount += 1
    }
}
