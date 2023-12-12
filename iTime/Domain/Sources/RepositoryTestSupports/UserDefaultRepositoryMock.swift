//
//  File.swift
//  
//
//  Created by 이상헌 on 11/23/23.
//

import Repository

public final class UserDefaultRepositoryMock: UserDefaultRepository {
  
  public var dummyUserID: String = String()
  public var dummyIsAppBackground: Bool = false
  public var dummyLastlyTrackTime: Int = 12
  
  public var updateUserIDCallCount: Int = 0
  public func updateUserID(with userID: String) {
    updateUserIDCallCount += 1
    dummyUserID = userID
  }
  
  public var userIDCallCount: Int = 0
  public func userID() -> String {
    userIDCallCount += 1
    return dummyUserID
  }
  
  public var lastlyTrackedTimeCallCount: Int = 0
  public func lastlyTrackedTime() -> Int {
    lastlyTrackedTimeCallCount += 1
    return dummyLastlyTrackTime
  }
  
  public var updateLastlyTrackedTimeCallCount: Int = 0
  public func updateLastlyTrackedTime(with time: Int) {
    updateLastlyTrackedTimeCallCount += 1
    dummyLastlyTrackTime += 1
  }
  
  public init() {}
}
