//
//  File.swift
//  
//
//  Created by 이상헌 on 12/3/23.
//

import RxSwift

import Entities
import Repository
import RepositoryTestSupports

public final class TimeLogRecordRepositoryMock: TimeLogRecordRepository {
  
  public let dummy = DummyData.DummyTimeLogRecord.dummyTimeLogRecords
  
  public var updateCallCount: Int = 0
  public func update(with records: [Entities.TimeLogRecord]) -> RxSwift.Single<[Entities.TimeLogRecord]> {
    updateCallCount += 1
    return .just([])
  }
  
  public var appendCallCount: Int = 0
  public func append(_ record: Entities.TimeLogRecord) -> RxSwift.Single<[Entities.TimeLogRecord]> {
    appendCallCount += 1
    return .just([])
  }
  
  public var removeCallCount: Int = 0
  public func remove(with logID: String) -> RxSwift.Single<[Entities.TimeLogRecord]> {
    removeCallCount += 1
    return .just([])
  }
  
  public var timeLogRecordsCallCount: Int = 0
  public func timeLogRecords() -> RxSwift.Single<[Entities.TimeLogRecord]> {
    timeLogRecordsCallCount += 1
    return .just(dummy)
  }
  
  public init() {}
}
