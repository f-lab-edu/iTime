//
//  File 2.swift
//  
//
//  Created by 이상헌 on 12/3/23.
//

import RxSwift

import Entities

public final class MutableTimeLogRecordModelDataStreamMock: MutableTimeLogRecordModelDataStream {
  
  public var timeLogRecords: RxSwift.Observable<[TimeLogRecord]> { .just([]) }
  
  public var updateRecordsCallCount: Int = 0
  public func updateRecords(with timeLogRecords: [TimeLogRecord]) {
    updateRecordsCallCount += 1
  }
  
  public var updateRecordCallCount: Int = 0
  public func updateRecord(with timeLogRecord: TimeLogRecord) {
    updateRecordCallCount += 1
  }
  
  public var appendCallCount: Int = 0
  public func append(_ timeLogRecord: TimeLogRecord) {
    appendCallCount += 1
  }
  
  public var removeCallCount: Int = 0
  public func remove(_ timeLogRecord: TimeLogRecord) {
    removeCallCount += 1
  }
  
  public init() {}
}
