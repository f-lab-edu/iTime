//
//  File.swift
//  
//
//  Created by 이상헌 on 2023/10/27.
//

import AuthenticationServices
import FirebaseAuth
import CryptoKit

import Platform

// MARK: - FirebaseAppleAuthenticationRepositoryImpl

public final class FirebaseAppleAuthenticationRepositoryImpl:
    NSObject,
    FirebaseAppleAuthenticationRepository
{
    fileprivate var currentNonce: String?
    fileprivate var notificationCenter: Postable
    
    public init(notificationCenter: Postable = NotificationCenter.default) {
        self.notificationCenter = notificationCenter
    }
    
    public func signInWithApple(_ presentation: ASAuthorizationContextProviding) {
        let nonce = randomNonceString()
        currentNonce = nonce
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        request.nonce = sha256(nonce)
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = presentation
        authorizationController.performRequests()
    }
    
    public func signOut() {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            postNotificationSignOutSuccess()
        } catch _ {
            postNotificationSignOutError()
        }
    }
}

// MARK: - Sign In

extension FirebaseAppleAuthenticationRepositoryImpl: ASAuthorizationControllerDelegate {
    public func authorizationController(
        controller: ASAuthorizationController,
        didCompleteWithAuthorization authorization: ASAuthorization
    ) {
        guard let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential else {
            print("Cannnot find appleIDCredential")
            return
        }
        guard let nonce = currentNonce else {
            assertionFailure("Invalid state: A login callback was received, but no login request was sent.")
            return
        }
        guard let appleIDToken = appleIDCredential.identityToken else {
            print("Unable to fetch identity token")
            return
        }
        guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
            print("Unable to serialize token string from data: \(appleIDToken.debugDescription)")
            return
        }
        
        let credential = OAuthProvider.appleCredential(
          withIDToken: idTokenString,
          rawNonce: nonce,
          fullName: appleIDCredential.fullName
        )
        
        signIn(with: credential)
    }
    
    public func authorizationController(
        controller: ASAuthorizationController,
        didCompleteWithError error: Error
    ) {
        postNotificationSignInError()
        print("Sign in with Apple errored: \(error)")
    }
    
    private func signIn(with credential: OAuthCredential) {
        Auth.auth().signIn(with: credential) { [weak self] (authResult, error) in
            guard let self else { return }
            if (error != nil) {
                self.postNotificationSignInError()
                return
            }
            self.postNotificationSignInSuccess()
        }
    }
}

// MARK: - Delete User

extension FirebaseAppleAuthenticationRepositoryImpl {
    public func deleteCurrentUser(_ presentation: ASAuthorizationContextProviding) {
        let nonce = randomNonceString()
        currentNonce = nonce
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        request.nonce = sha256(nonce)
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = presentation
        authorizationController.performRequests()
    }
}

// MARK: Create Hash Value

extension FirebaseAppleAuthenticationRepositoryImpl {
    private func randomNonceString(length: Int = 32) -> String {
        precondition(length > 0)
        var randomBytes = [UInt8](repeating: 0, count: length)
        let errorCode = SecRandomCopyBytes(kSecRandomDefault, randomBytes.count, &randomBytes)
        if errorCode != errSecSuccess {
            assertionFailure(
                "Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)"
            )
        }
        
        let charset: [Character] =
        Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
        
        let nonce = randomBytes.map { byte in
            charset[Int(byte) % charset.count]
        }
        
        return String(nonce)
    }
    
    private func sha256(_ input: String) -> String {
        let inputData = Data(input.utf8)
        let hashedData = SHA256.hash(data: inputData)
        let hashString = hashedData.compactMap {
            String(format: "%02x", $0)
        }.joined()
        
        return hashString
    }
}

// MARK: - Error Notification

extension FirebaseAppleAuthenticationRepositoryImpl {
    private func postNotificationSignInSuccess() {
        notificationCenter.post(
            name: AuthenticationSuccess.signIn.notificationName,
            object: nil
        )
    }
    
    private func postNotificationSignInError() {
        notificationCenter.post(
            name: AuthenticationError.signInError.notificationName,
            object: nil
        )
    }
    
    private func postNotificationSignOutSuccess() {
        notificationCenter.post(
            name: AuthenticationSuccess.signOut.notificationName,
            object: nil
        )
    }
    
    private func postNotificationSignOutError() {
        notificationCenter.post(
            name: AuthenticationError.signOutError.notificationName,
            object: nil
        )
    }
    
    private func postNotificationDeleteUserSuccess() {
        notificationCenter.post(
            name: AuthenticationSuccess.deleteUser.notificationName,
            object: nil
        )
    }
    
    private func postNotificationDeleteUserError() {
        notificationCenter.post(
            name: AuthenticationError.deleteUserError.notificationName,
            object: nil
        )
    }
}
