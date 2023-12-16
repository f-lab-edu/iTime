//
//  File.swift
//  
//
//  Created by 이상헌 on 12/16/23.
//

import FirebaseAnalytics

// MARK: - FirebaseAnalyticsLoggerImpl

public final class FirebaseAnalyticsLoggerImpl: FirebaseAnalyticsLogger {
  
  private let userID: () -> String
  
  public init(
    userID: @escaping () -> String
  ) {
    self.userID = userID
    setUserID()
  }
  
  private func setUserID() {
    Analytics.setUserID(userID())
  }
  
  public func LogPreLoadAllData() {
    Analytics.logEvent(LogEventName.preLoadAllData, parameters: [:])
  }
}
