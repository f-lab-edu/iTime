//
//  File.swift
//  
//
//  Created by 이상헌 on 2023/10/26.
//

import Foundation

// MARK: - ThirdPartyAuthenticationResult

public enum ThirdPartyAuthenticationResult: String, Error {
    case signOutSuccess
    case signOutError
    case signInSuccess
    case signInError
    
    case deleteUserSuccess
    case deleteUserError
    
    case osError
    
    public var notificationName: NSNotification.Name {
        return NSNotification.Name(rawValue: self.rawValue)
    }
}
