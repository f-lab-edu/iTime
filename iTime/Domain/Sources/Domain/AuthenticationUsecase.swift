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
  func signIn() -> Single<Void>
  func signOut() -> Single<Void>
  func deleteCurrentUser() -> Single<Void>
  func isLoggedIn() -> Bool
}
