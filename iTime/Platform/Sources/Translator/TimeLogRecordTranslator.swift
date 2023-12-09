//
//  File.swift
//
//
//  Created by 이상헌 on 12/1/23.
//

import Models
import Entities

// MARK: - TimeLogRecordTranslatorImpl

public final class TimeLogRecordTranslator {
  public func translateToTimeLogRecords(by timeLog: [TimeLog]) -> [TimeLogRecord] {
    timeLog.map {
      TimeLogRecord(
        id: $0.id,
        activity: Activity(
          title: $0.perform.title,
          category: Category(
            title: $0.perform.classification.title,
            color: $0.perform.classification.color
          )
        ),
        startTime: $0.startTime,
        endTime: $0.endTime,
        coordinates: $0.coordinates.map {
          Coordinate2D(
            latitude: $0.latitude,
            longitude: $0.longitude
          )
        }
      )
    }
  }
  
  public func translateToTimeLogList(by timeLogRecords: [TimeLogRecord]) -> TimeLogList {
    .init(
      timeLogRecords.map {
        TimeLog(
          id: $0.id,
          perform: Perform(
            title: $0.activity.title,
            classification: Classification(
              title: $0.activity.category.title,
              color: $0.activity.category.color
            )
          ),
          startTime: $0.startTime,
          endTime: $0.endTime,
          coordinates: $0.coordinates.map {
            Coordinate(
              latitude: $0.latitude,
              longitude: $0.longitude
            )
          }
        )
      }
    )
  }
  public init() {}
}
