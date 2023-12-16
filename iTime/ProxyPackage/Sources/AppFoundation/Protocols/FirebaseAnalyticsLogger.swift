//
//  File.swift
//  
//
//  Created by 이상헌 on 12/16/23.
//

import FirebaseAnalytics

// MARK: - LogEventName

public enum LogEventName {
  static let preLoadAllData = "preLoadAllData"
}

// MARK: - FirebaseAnalyticsLogger

public protocol FirebaseAnalyticsLogger {
  func LogPreLoadAllData()
}

