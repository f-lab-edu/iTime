//
//  File.swift
//  
//
//  Created by 이상헌 on 2023/10/26.
//

import RxSwift

import ProxyPackage

// MARK: ㅡ AuthenticaitonUsecase

public protocol AuthenticationUsecase {
  func appleSignUp(_ presentation: ASAuthorizationContextProviding) -> Observable<Void>
  func signOut() -> Observable<Void>
  func deleteUser(_ presentation: ASAuthorizationContextProviding) -> Observable<Void>
}

// MARK: - ASAuthorizationContextProviding

public protocol ASAuthorizationContextProviding: Platform.ASAuthorizationContextProviding {}
