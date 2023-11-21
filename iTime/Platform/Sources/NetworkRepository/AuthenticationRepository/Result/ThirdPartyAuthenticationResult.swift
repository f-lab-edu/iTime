//
//  File.swift
//  
//
//  Created by 이상헌 on 2023/10/26.
//

import Foundation

// MARK: - AuthenticationSuccess

public enum AuthenticationSuccess: String {
    case signOut
    case signIn
    case deleteUser
    
    public var notificationName: NSNotification.Name {
        return NSNotification.Name(rawValue: self.rawValue)
    }
}

// MARK: - AuthenticationError

public enum AuthenticationError: String, Error {
    case signOutError
    case signInError
    case deleteUserError
    case osError
    
    public var notificationName: NSNotification.Name {
        return NSNotification.Name(rawValue: self.rawValue)
    }
}
