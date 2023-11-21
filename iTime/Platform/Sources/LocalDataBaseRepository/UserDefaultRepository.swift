//
//  File.swift
//
//
//  Created by 이상헌 on 11/20/23.
//

import Foundation

// MARK: - ReadOnlyUserDefaultRepository

public protocol ReadOnlyUserDefaultRepository {
  func userID() -> String
  func isAppBackground() -> Bool
}

// MARK: - WriteUserDefaultRepository

public protocol WriteUserDefaultRepository {
  func updateUserID(with userID: String)
  func updateIsAppBackground(with isAppBackground: Bool)
}

// MARK: - UserDefaultKey

public enum UserDefaultKey: String {
  case userID
  case isAppBackground
}
