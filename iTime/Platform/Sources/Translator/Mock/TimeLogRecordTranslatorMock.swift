//
//  File.swift
//  
//
//  Created by 이상헌 on 12/1/23.
//

import Models
import Entities

public class TimeLogRecordTranslatorMock: TimeLogRecordTranslator {
  public func translateToTimeLogRecords(by timeLog: [TimeLog]) -> [TimeLogRecord] {
    []
  }
  
  public func translateToTimeLogList(by timeLogRecords: [TimeLogRecord]) -> TimeLogList {
    .init([])
  }
  
  public init () {}
}

