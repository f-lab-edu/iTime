//
//  File.swift
//  
//
//  Created by 이상헌 on 2023/10/26.
//

import Foundation

// MARK: - AuthenticationError

enum AuthenticationError: Error {
    case signOutSuccess
    case signOutError
    case signInSuccess
    case signInError
}
