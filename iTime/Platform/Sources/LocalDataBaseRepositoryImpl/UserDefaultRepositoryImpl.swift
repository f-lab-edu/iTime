//
//  File.swift
//  
//
//  Created by 이상헌 on 11/20/23.
//

import Foundation

import LocalDataBaseRepository

// MARK: - UserDefaultRepositoryImpl

final class UserDefaultRepositoryImpl: UserDefaultRepository  {
  @UserDefaultWrapper(key: UserDefaultKey.userID.rawValue, defaultValue: String())
  var userID: String
  
  @UserDefaultWrapper(key: UserDefaultKey.isAppBackground.rawValue, defaultValue: false)
  var isAppBackground: Bool
}
// MARK: - UserDefaultWrapper

@propertyWrapper
struct UserDefaultWrapper<T: Codable> {
  private let key: String
  private let defaultValue: T
  
  init(key: String, defaultValue: T) {
    self.key = key
    self.defaultValue = defaultValue
  }
  
  var wrappedValue: T {
    get {
      if let savedData = UserDefaults.standard.object(forKey: key) as? Data {
        let decoder = JSONDecoder()
        if let lodedObejct = try? decoder.decode(T.self, from: savedData) {
          return lodedObejct
        }
      }
      return defaultValue
    }
    set {
      let encoder = JSONEncoder()
      if let encoded = try? encoder.encode(newValue) {
        UserDefaults.standard.setValue(encoded, forKey: key)
      }
    }
  }
}
