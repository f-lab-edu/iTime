//
//  File.swift
//  
//
//  Created by 이상헌 on 12/1/23.
//

// MARK: - TimeLogRecord

public struct TimeLogRecord: Equatable
{
  public let id: String
  public let activity: Activity
  public let startTime: String
  public let endTime: String
  public let coordinate: Coordinate2D
  
  public init(
    id: String, 
    activity: Activity,
    startTime: String,
    endTime: String,
    coordinate: Coordinate2D
  ) {
    self.id = id
    self.activity = activity
    self.startTime = startTime
    self.endTime = endTime
    self.coordinate = coordinate
  }
  
  public static func == (lhs: TimeLogRecord, rhs: TimeLogRecord) -> Bool {
    lhs.id == rhs.id
  }
}
