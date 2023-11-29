//
//  File.swift
//  
//
//  Created by 이상헌 on 11/26/23.
//

import Foundation

// MARK: - TimeLogHistoryList

public struct TimeLogHistoryList: Codable {
  public let timeLogHistories: [TimeLogHistory]
  
  public init(_ timeLogHistories: [TimeLogHistory]) {
    self.timeLogHistories = timeLogHistories
  }
}
