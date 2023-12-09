//
//  File.swift
//  
//
//  Created by 이상헌 on 11/26/23.
//

import Foundation

// MARK: - TimeLogHistory

public struct TimeLog: 
  Codable,
  Equatable
{
  public let id: String
  public let perform: Perform
  public let startTime: String
  public let endTime: String
  public let coordinates: [Coordinate]
  
  public init(
    id: String,
    perform: Perform,
    startTime: String,
    endTime: String,
    coordinates: [Coordinate]
  ) {
    self.id = id
    self.perform = perform
    self.startTime = startTime
    self.endTime = endTime
    self.coordinates = coordinates
  }
  
  public static func == (lhs: TimeLog, rhs: TimeLog) -> Bool {
    lhs.id == rhs.id
  }
}
