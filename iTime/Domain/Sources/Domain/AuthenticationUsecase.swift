//
//  File.swift
//  
//
//  Created by 이상헌 on 2023/10/26.
//

import AuthenticationServices
import FirebaseAuth
import CommonCrypto
import RIBs

// MARK: - AuthenticationUsecase

public protocol AuthenticationUsecase {
    func signInWithApple(_ presentation: ASAuthorizationControllerPresentationContextProviding)
    func signOut()
}

// MARK: - AuthenticationUsecaseImpl

public final class AuthenticationUsecaseImpl: NSObject, AuthenticationUsecase {
    fileprivate var currentNonce: String?
    
    public func signInWithApple(_ presentation: ASAuthorizationControllerPresentationContextProviding) {
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
            //postNotificationSignOutSuccess()
        } catch _ {
            //postNotificationSignOutError()
        }
    }
}

// MARK: - ASAuthorizationControllerDelegate

extension AuthenticationUsecaseImpl: ASAuthorizationControllerDelegate {
    public func authorizationController(
        controller: ASAuthorizationController,
        didCompleteWithAuthorization authorization: ASAuthorization
    ) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
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
            // Initialize a Firebase credential.
            let credential = OAuthProvider.credential(withProviderID: "apple.com",
                                                      idToken: idTokenString,
                                                      rawNonce: nonce)
            // Sign in with Firebase.
            Auth.auth().signIn(with: credential) { [weak self] (authResult, error) in
                guard let self else { return }
                if (error != nil) {
                    // self?.postNotificationSignInError()
                    return
                }
                // self?.postNotificationSignInSuccess()
            }
        }
    }
    
    public func authorizationController(
        controller: ASAuthorizationController,
        didCompleteWithError error: Error
    ) {
        // Handle error.
        print("Sign in with Apple errored: \(error)")
    }
}

// MARK: Create Hash Value

extension AuthenticationUsecaseImpl {
    private func randomNonceString(length: Int = 32) -> String {
        precondition(length > 0)
        let charset: Array<Character> =
        Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
        var result = ""
        var remainingLength = length
        
        while remainingLength > 0 {
            let randoms: [UInt8] = (0 ..< 16).map { _ in
                var random: UInt8 = 0
                let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
                if errorCode != errSecSuccess {
                    assertionFailure("Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)")
                }
                return random
            }
            
            randoms.forEach { random in
                if length == 0 {
                    return
                }
                
                if random < charset.count {
                    result.append(charset[Int(random)])
                    remainingLength -= 1
                }
            }
        }
        
        return result
    }
    
    private func sha256(_ input: String) -> String {
        let inputData = Data(input.utf8)
        let hashedData = hashSHA256(data: inputData)
        let hashString = hashedData!.compactMap {
            return String(format: "%02x", $0)
        }.joined()
        
        return hashString
    }
    
    private func hashSHA256(data:Data) -> Data? {
        var hashData = Data(count: Int(CC_SHA256_DIGEST_LENGTH))
        
        _ = hashData.withUnsafeMutableBytes { digestBytes in
            data.withUnsafeBytes {messageBytes in
                CC_SHA256(messageBytes, CC_LONG(data.count), digestBytes)
            }
        }
        return hashData
    }
}
