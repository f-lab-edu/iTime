//
//  File.swift
//
//
//  Created by 이상헌 on 11/20/23.
//

import Foundation

// MARK: - UserDefaultRepository

public protocol UserDefaultRepository: ReadOnlyUserIDRepository, ReadOnlyLastlyTrackedTimeRepository, WriteUserIDRepository, WriteLastlyTrackedTimeRepository {}

// MARK: - ReadOnlyUserDefaultRepository

public protocol ReadOnlyUserIDRepository {
  func userID() -> String
}

public protocol ReadOnlyLastlyTrackedTimeRepository {
  func lastlyTrackedTime() -> Int
}

// MARK: - WriteUserDefaultRepository

public protocol WriteUserIDRepository {
    func updateUserID(with userID: String)
}

public protocol WriteLastlyTrackedTimeRepository {
    func updateLastlyTrackedTime(with time: Int)
}

// MARK: - UserDefaultKey

public enum UserDefaultKey: String {
  case userID
  case lastlyTrackedTime
}
