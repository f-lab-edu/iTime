//
//  File.swift
//  
//
//  Created by 이상헌 on 12/1/23.
//

import AppFoundation

// MARK: - TimeLogRecord

public struct TimeLogRecord:
  Equatable,
  PropertyBuilderCompatible
{
  public var id: String
  public var activity: Activity
  public var startDate: String
  public var endDate: String
  public var coordinate: Coordinate2D
  
  public init(
    id: String = String(),
    activity: Activity = .empty,
    startDate: String = String(),
    endDate: String = String(),
    coordinate: Coordinate2D = .zero
  ) {
    self.id = id
    self.activity = activity
    self.startDate = startDate
    self.endDate = endDate
    self.coordinate = coordinate
  }
  
  public static func == (lhs: TimeLogRecord, rhs: TimeLogRecord) -> Bool {
    lhs.id == rhs.id
  }
}
