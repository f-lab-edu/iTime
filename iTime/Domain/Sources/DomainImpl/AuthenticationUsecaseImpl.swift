//
//  File.swift
//  
//
//  Created by 이상헌 on 2023/10/27.
//

import Foundation

import RxSwift

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
    
    public func appleSignUp(_ presentation: ASAuthorizationContextProviding) -> Observable<Void> {
        return Observable.create { [weak self] observer in
            guard let self else { return Disposables.create() }
            self.addSignInObservers { result in
                switch result {
                    case .success(_):
                        observer.onNext(Void())
                    case let .error(error):
                        observer.onError(error)
                }
            }
            
            self.appleAuthenticationRepository.signInWithApple(presentation)
            return Disposables.create()
        }
    }
    
    public func signOut() -> Observable<Void> {
        return Observable.create { [weak self] observer in
            guard let self else { return Disposables.create() }
            self.addSignOutObservers { result in
                switch result {
                    case .success(_):
                        observer.onNext(Void())
                    case let .error(error):
                        observer.onError(error)
                }
            }
            
            self.appleAuthenticationRepository.signOut()
            return Disposables.create()
        }
    }
    
    public func deleteUser(_ presentation: ASAuthorizationContextProviding) -> Observable<Void> {
        return Observable.create { [weak self] observer in
            guard let self else { return Disposables.create() }
            self.addDeleteUserObservers { result in
                switch result {
                    case .success(_):
                        observer.onNext(Void())
                    case let .error(error):
                        observer.onError(error)
                }
            }
            
            self.appleAuthenticationRepository.deleteCurrentUser(presentation)
            return Disposables.create()
        }
    }
}

// MARK: - Set Authetication Notification

extension AuthenticationUsecaseImpl {
    private func addSignInObservers(_ handleNotification: (ThirdPartyAuthenticationResult) -> Void) {
        NotificationCenter.default.addObserver(
            forName: ThirdPartyAuthenticationResult.AuthenticationSuccess.signIn.notificationName,
            object: nil,
            queue: OperationQueue.current) { _ in
                handleNotification(.success(.signIn))
            }
        
        NotificationCenter.default.addObserver(
            forName: ThirdPartyAuthenticationResult.AuthenticationError.signInError.notificationName,
            object: nil,
            queue: OperationQueue.current) { _ in
                handleNotification(.error(.signInError))
            }
    }
    
    private func addSignOutObservers(_ handleNotification: (ThirdPartyAuthenticationResult) -> Void) {
        NotificationCenter.default.addObserver(
            forName: ThirdPartyAuthenticationResult.AuthenticationSuccess.signOut.notificationName,
            object: nil,
            queue: OperationQueue.current) { _ in
                handleNotification(.success(.signOut))
            }
        
        NotificationCenter.default.addObserver(
            forName: ThirdPartyAuthenticationResult.AuthenticationError.signOutError.notificationName,
            object: nil,
            queue: OperationQueue.current) { _ in
                handleNotification(.error(.signOutError))
            }
    }
    
    private func addDeleteUserObservers(_ handleNotification: (ThirdPartyAuthenticationResult) -> Void) {
        NotificationCenter.default.addObserver(
            forName: ThirdPartyAuthenticationResult.AuthenticationSuccess.deleteUser.notificationName,
            object: nil,
            queue: OperationQueue.current) { _ in
                handleNotification(.success(.deleteUser))
            }
        
        NotificationCenter.default.addObserver(
            forName: ThirdPartyAuthenticationResult.AuthenticationError.deleteUserError.notificationName,
            object: nil,
            queue: OperationQueue.current) { _ in
                handleNotification(.error(.deleteUserError))
            }
    }
}
