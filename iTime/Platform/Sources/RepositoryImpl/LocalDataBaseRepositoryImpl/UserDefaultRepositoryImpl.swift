//
//  File.swift
//
//
//  Created by 이상헌 on 11/20/23.
//

import Foundation

import Repository

// MARK: - UserDefaultRepositoryImpl

public final class UserDefaultRepositoryImpl: UserDefaultRepository {
  public func updateUserID(with userID: String) {
    UserDefaults.standard.setValue(userID, forKey: UserDefaultKey.userID.rawValue)
  }

  public func updateLastlyTrackedTime(with time: Int) {
    UserDefaults.standard.setValue(time, forKey: UserDefaultKey.lastlyTrackedTime.rawValue)
  }
  
  public func userID() -> String {
    guard let userID = UserDefaults.standard.string(forKey: UserDefaultKey.userID.rawValue) else {
      assertionFailure(" userID is nil, default value is empty ")
      return String()
    }
    return userID
  }
  
  public func lastlyTrackedTime() -> Int {
    UserDefaults.standard.integer(forKey: UserDefaultKey.lastlyTrackedTime.rawValue)
  }

  public init() {}
}
