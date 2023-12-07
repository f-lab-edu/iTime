//
//  File.swift
//  
//
//  Created by 이상헌 on 2023/10/29.
//

import AuthenticationServices

import AppFoundation

public final class ASAuthrizationContextProviderMock: NSObject, AuthorizationContextProviding {
    public func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return ASPresentationAnchor.init()
    }
    
    public override init() {}
}
