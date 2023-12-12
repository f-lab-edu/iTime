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
  public let startDate: String
  public let endDate: String
  public let coordinate: Coordinate
  
  public init(
    id: String,
    perform: Perform,
    startDate: String,
    endDate: String,
    coordinate: Coordinate
  ) {
    self.id = id
    self.perform = perform
    self.startDate = startDate
    self.endDate = endDate
    self.coordinate = coordinate
  }
  
  public static func == (lhs: TimeLog, rhs: TimeLog) -> Bool {
    lhs.id == rhs.id
  }
}
