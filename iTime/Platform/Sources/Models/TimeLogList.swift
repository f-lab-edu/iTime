//
//  File.swift
//  
//
//  Created by 이상헌 on 11/26/23.
//

import Foundation

// MARK: - TimeLogHistoryList

public struct TimeLogList: Codable {
  public let timeLogs: [TimeLog]
  
  public init(_ timeLogs: [TimeLog]) {
    self.timeLogs = timeLogs
  }
}
