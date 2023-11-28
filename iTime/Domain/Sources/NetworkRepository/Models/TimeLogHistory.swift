//
//  File.swift
//  
//
//  Created by 이상헌 on 11/26/23.
//

import Foundation

// MARK: - TimeLogHistory

public struct TimeLogHistory: 
  Codable,
  Equatable
{
  public let id: String
  let activity: Activity
  let startTime: String
  let endTime: String
  let coordinate: Coordinate2D
  
  public init(id: String, activity: Activity, startTime: String, endTime: String, coordinate: Coordinate2D) {
    self.id = id
    self.activity = activity
    self.startTime = startTime
    self.endTime = endTime
    self.coordinate = coordinate
  }
  
  public static func == (lhs: TimeLogHistory, rhs: TimeLogHistory) -> Bool {
    lhs.id == rhs.id
  }
}
