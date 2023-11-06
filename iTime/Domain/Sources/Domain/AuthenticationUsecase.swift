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
  func signIn() -> Observable<Void>
  func signOut() -> Observable<Void>
  func deleteCurrentUser() -> Observable<Void>
  func isLoggedIn() -> Observable<Bool>
}
