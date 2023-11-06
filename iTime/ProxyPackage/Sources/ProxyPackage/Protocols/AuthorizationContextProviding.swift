//
//  File.swift
//  
//
//  Created by 이상헌 on 2023/11/06.
//

import UIKit
import AuthenticationServices

// MARK: - ASAuthorizationContextProviding

public protocol AuthorizationContextProviding: ASAuthorizationControllerPresentationContextProviding {}

extension UIApplication: AuthorizationContextProviding {
  public func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
    let scenes = UIApplication.shared.connectedScenes.first as? UIWindowScene
    let window = scenes?.windows.first ?? .init()
    return window
  }
}
