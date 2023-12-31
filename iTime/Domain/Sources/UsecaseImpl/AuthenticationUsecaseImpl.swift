//
//  File.swift
//  
//
//  Created by 이상헌 on 2023/10/27.
//

import AuthenticationServices

import RxSwift

import Usecase
import Repository
import AppFoundation

// MARK: - AuthenticationUsecaseImpl

public final class AuthenticationUsecaseImpl: AuthenticationUsecase {
  
  // MARK: - Properties
  
  private let appleAuthenticationRepository: AuthenticationRepository
  private let authorizationContextProvider: AuthorizationContextProviding
  private let userDefaultRepository: WriteUserIDRepository
  
  fileprivate var notificationCenter: Addable
  
  // MARK: initialize
  
  public init(
    appleAuthenticationRepository: AuthenticationRepository,
    notificationCenter: Addable = NotificationCenter.default,
    authorizationContextProvider: AuthorizationContextProviding,
    userDefaultRepository: WriteUserIDRepository
  ) {
    self.appleAuthenticationRepository = appleAuthenticationRepository
    self.notificationCenter = notificationCenter
    self.authorizationContextProvider = authorizationContextProvider
    self.userDefaultRepository = userDefaultRepository
  }
  
  public func signIn() -> Single<Void> {
    Single<Void>.create(with: self) { this, observer in
      this.addSignInObservers { result in
        switch result {
          case .success(_):
            observer(.success(Void()))
          case let .failure(error):
            observer(.failure(error))
        }
      }
      this.appleAuthenticationRepository.signIn(this.authorizationContextProvider)
      guard let userID = this.appleAuthenticationRepository.userID() else {
        return Disposables.create()
      }
      this.userDefaultRepository.updateUserID(with: userID)
      return Disposables.create()
    }
  }
  
  public func signOut() -> Single<Void> {
    Single<Void>.create(with: self) { this, observer in
      this.addSignOutObservers { result in
        switch result {
          case .success(_):
            observer(.success(Void()))
          case let .failure(error):
            observer(.failure(error))
        }
      }
      
      this.appleAuthenticationRepository.signOut()
      return Disposables.create()
    }
  }
  
  public func deleteCurrentUser() -> Single<Void> {
    Single<Void>.create(with: self) { this, observer in
      this.addDeleteUserObservers { result in
        switch result {
          case .success(_):
            observer(.success(Void()))
          case let .failure(error):
            observer(.failure(error))
        }
      }
      this.appleAuthenticationRepository.deleteCurrentUser()
      return Disposables.create()
    }
  }
  
  public func isLoggedIn() -> Bool {
    return appleAuthenticationRepository.isLoggedIn()
  }
}

// MARK: - Set Authetication Notification

extension AuthenticationUsecaseImpl {
  typealias ThirdPartyAuthenticationResult = (Result<AuthenticationSuccess, AuthenticationError>) -> Void
  
  private func addSignInObservers(_ handleNotification: @escaping ThirdPartyAuthenticationResult) {
    notificationCenter.addObserver(
      forName: AuthenticationSuccess.signIn.notificationName,
      object: nil,
      queue: OperationQueue.current) { _ in
        handleNotification(.success(.signIn))
      }
    
    notificationCenter.addObserver(
      forName: AuthenticationError.signInError.notificationName,
      object: nil,
      queue: OperationQueue.current) { _ in
        handleNotification(.failure(.signInError))
      }
  }
  
  private func addSignOutObservers(_ handleNotification: @escaping ThirdPartyAuthenticationResult) {
    notificationCenter.addObserver(
      forName: AuthenticationSuccess.signOut.notificationName,
      object: nil,
      queue: OperationQueue.current) { _ in
        handleNotification(.success(.signOut))
      }
    
    notificationCenter.addObserver(
      forName: AuthenticationError.signOutError.notificationName,
      object: nil,
      queue: OperationQueue.current) { _ in
        handleNotification(.failure(.signOutError))
      }
  }
  
  private func addDeleteUserObservers(_ handleNotification: @escaping ThirdPartyAuthenticationResult) {
    notificationCenter.addObserver(
      forName: AuthenticationSuccess.deleteUser.notificationName,
      object: nil,
      queue: OperationQueue.current) { _ in
        handleNotification(.success(.deleteUser))
      }
    
    notificationCenter.addObserver(
      forName: AuthenticationError.deleteUserError.notificationName,
      object: nil,
      queue: OperationQueue.current) { _ in
        handleNotification(.failure(.deleteUserError))
      }
  }
}
