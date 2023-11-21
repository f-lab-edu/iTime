//
//  File.swift
//
//
//  Created by 이상헌 on 11/20/23.
//

import Foundation

import LocalDataBaseRepository

// MARK: - UserDefaultRepositoryImpl

final class UserDefaultRepositoryImpl: WriteUserDefaultRepository, ReadOnlyUserDefaultRepository  {
  func updateUserID(with userID: String) {
    UserDefaults.standard.setValue(isAppBackground, forKey: UserDefaultKey.isAppBackground.rawValue)
  }
  
  func updateIsAppBackground(with isAppBackground: Bool) {
    UserDefaults.standard.setValue(isAppBackground, forKey: UserDefaultKey.isAppBackground.rawValue)
  }
  
  func userID() -> String {
    guard let userID = UserDefaults.standard.string(forKey: UserDefaultKey.userID.rawValue) else {
      assertionFailure(" userID is nil, default value is empty ")
      return String()
    }
    return userID
  }
  
  /// defualt value is false
  func isAppBackground() -> Bool {
    UserDefaults.standard.bool(forKey: UserDefaultKey.isAppBackground.rawValue)
  }
}
