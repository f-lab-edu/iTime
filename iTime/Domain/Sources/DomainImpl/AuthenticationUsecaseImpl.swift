//
//  File.swift
//  
//
//  Created by 이상헌 on 2023/10/27.
//

import Foundation

import RxSwift

import Domain
import Platform
import ProxyPackage

// MARK: - AuthenticationUsecaseImpl

public final class AuthenticationUsecaseImpl: AuthenticationUsecase {
    
    // MARK: - Properties
    
    private let appleAuthenticationRepository: FirebaseAppleAuthenticationRepository
    fileprivate var notificationCenter: Addable
    
    // MARK: initialize
    
    public init(
        appleAuthenticationRepository: FirebaseAppleAuthenticationRepository,
        notificationCenter: Addable = NotificationCenter.default
    ) {
        self.appleAuthenticationRepository = appleAuthenticationRepository
        self.notificationCenter = notificationCenter
    }
    
    public func appleSignUp(_ presentation: Platform.ASAuthorizationContextProviding) -> Observable<Void> {
        Observable.create(with: self) { this, observer in
            this.addSignInObservers { result in
                switch result {
                    case .success(_):
                        observer.onNext(Void())
                    case let .failure(error):
                        observer.onError(error)
                }
            }
            
            this.appleAuthenticationRepository.signInWithApple(presentation)
            return Disposables.create()
        }
    }
    
    public func signOut() -> Observable<Void> {
        Observable.create(with: self) { this, observer in
            this.addSignOutObservers { result in
                switch result {
                    case .success(_):
                        observer.onNext(Void())
                    case let .failure(error):
                        observer.onError(error)
                }
            }
            
            this.appleAuthenticationRepository.signOut()
            return Disposables.create()
        }
    }
    
    public func deleteUser(_ presentation: Platform.ASAuthorizationContextProviding) -> Observable<Void> {
        Observable.create(with: self) { this, observer in
            this.addDeleteUserObservers { result in
                switch result {
                    case .success(_):
                        observer.onNext(Void())
                    case let .failure(error):
                        observer.onError(error)
                }
            }
            this.appleAuthenticationRepository.deleteCurrentUser(presentation)
            return Disposables.create()
        }
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
