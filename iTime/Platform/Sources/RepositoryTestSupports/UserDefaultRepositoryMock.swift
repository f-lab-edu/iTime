//
//  File.swift
//  
//
//  Created by 이상헌 on 11/23/23.
//

import LocalDataBaseRepository

public final class UserDefaultRepositoryMock: WriteUserDefaultRepository, ReadOnlyUserDefaultRepository {
  
  public var dummyUserID: String = String()
  public var dummyIsAppBackground: Bool = false
  
  public var updateUserIDCallCount: Int = 0
  public func updateUserID(with userID: String) {
    updateUserIDCallCount += 1
    dummyUserID = userID
  }
  
  public var updateIsAppBackgroundCallCount: Int = 0
  public func updateIsAppBackground(with isAppBackground: Bool) {
    updateIsAppBackgroundCallCount += 1
    dummyIsAppBackground = true
  }
  
  public var userIDCallCount: Int = 0
  public func userID() -> String {
    userIDCallCount += 1
    return dummyUserID
  }
  
  public var isAppBackgroundCallCount: Int = 0
  public func isAppBackground() -> Bool {
    isAppBackgroundCallCount += 1
    return dummyIsAppBackground
  }
}
