//
//  File.swift
//
//
//  Created by 이상헌 on 11/20/23.
//

import Foundation

// MARK: - ReadOnlyUserDefaultRepository

public protocol ReadOnlyUserIDRepository {
  func userID() -> String
}

public protocol ReadOnlyIsAppBackgroundRepository {
  func isAppBackground() -> Bool
}

// MARK: - WriteUserDefaultRepository

public protocol WriteUserIDRepository {
    func updateUserID(with userID: String)
}

public protocol WriteIsAppBackgroundRepository {
    func updateIsAppBackground(with isAppBackground: Bool)
}

// MARK: - UserDefaultKey

public enum UserDefaultKey: String {
  case userID
  case isAppBackground
}
