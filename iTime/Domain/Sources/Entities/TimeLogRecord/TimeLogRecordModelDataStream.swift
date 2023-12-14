//
//  File.swift
//
//
//  Created by 이상헌 on 12/2/23.
//

import RxSwift
import RxRelay

// MARK: - TimeLogRecordModelData

struct TimeLogRecordModelData: Equatable {
  let models: [TimeLogRecord]
  let modelByID: [String: TimeLogRecord]
  
  init(
    models: [TimeLogRecord] = [],
    modelByID: [String : TimeLogRecord] = [:]
  ) {
    self.models = models
    self.modelByID = modelByID
  }
}

// MARK: - TimeLogRecordModelDataStreamImpl

public final class TimeLogRecordModelDataStream {
  
  // MARK: - Properties
  
  public var timeLogRecords: Observable<[TimeLogRecord]> { timeLogRecordsDataRelay.asObservable().map(\.models) }
  private let timeLogRecordsDataRelay = BehaviorRelay<TimeLogRecordModelData>(value: TimeLogRecordModelData())
  
  // MARK: - Internal Methods
  
  public func updateRecords(with timeLogRecords: [TimeLogRecord]) {
    let modelByID = timeLogRecords.reduce(into: [String: TimeLogRecord]()) { $0[$1.id] = $1 }
    let data = TimeLogRecordModelData(models: timeLogRecords, modelByID: modelByID)
    timeLogRecordsDataRelay.accept(data)
  }
  
  public func updateRecord(with timeLogRecord: TimeLogRecord) {
    var modelByID = timeLogRecordsDataRelay.value.modelByID
    modelByID[timeLogRecord.id] = timeLogRecord
    
      let data = TimeLogRecordModelData(models: modelByID.., modelByID: modelByID)
    timeLogRecordsDataRelay.accept(data)
  }
  
  public func append(_ timeLogRecord: TimeLogRecord) {
    var newTimeLogRecords: [TimeLogRecord] {
      var records = timeLogRecordsDataRelay.value.models
      records.append(timeLogRecord)
      return records
    }
    
    var newTimeLogRecordsModelByID: [String: TimeLogRecord] {
      var modelByID = timeLogRecordsDataRelay.value.modelByID
      modelByID[timeLogRecord.id] = timeLogRecord
      return modelByID
    }
    let data = TimeLogRecordModelData(models: newTimeLogRecords, modelByID: newTimeLogRecordsModelByID)
    timeLogRecordsDataRelay.accept(data)
  }
  
  public func remove(_ timeLogRecord: TimeLogRecord) {
    var newTimeLogRecords: [TimeLogRecord] {
      let records = timeLogRecordsDataRelay.value.models.filter { $0 != timeLogRecord }
      return records
    }
    
    var newTimeLogRecordsModelByID: [String: TimeLogRecord] {
      var modelByID = timeLogRecordsDataRelay.value.modelByID
      modelByID.removeValue(forKey: timeLogRecord.id)
      return modelByID
    }
    let data = TimeLogRecordModelData(models: newTimeLogRecords, modelByID: newTimeLogRecordsModelByID)
    timeLogRecordsDataRelay.accept(data)
  }
  
  public init() {}
}
