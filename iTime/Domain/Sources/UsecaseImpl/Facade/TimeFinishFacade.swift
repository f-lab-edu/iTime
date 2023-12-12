//
//  File.swift
//  
//
//  Created by 이상헌 on 12/11/23.
//

import RxSwift

import Entities
import Repository

final class TimeFinishFacade {
  
  private let locationTracker: LocationTracker
  private let runningTimeTracker: RunningTimeTracker
  private let timeLogRecordRepository: TimeLogRecordRepository
  private let timeLogRecordModelDataStream: TimeLogRecordModelDataStream
  
  init(
    locationTracker: LocationTracker,
    runningTimeTracker: RunningTimeTracker,
    timeLogRecordRepository: TimeLogRecordRepository,
    timeLogRecordModelDataStream: TimeLogRecordModelDataStream
  ) {
    self.locationTracker = locationTracker
    self.runningTimeTracker = runningTimeTracker
    self.timeLogRecordRepository = timeLogRecordRepository
    self.timeLogRecordModelDataStream = timeLogRecordModelDataStream
  }
  
  func finish(_ record: TimeLogRecord) -> Observable<Void> {
    runningTimeTracker.finish()
    locationTracker.resetLocationTracking()
    timeLogRecordModelDataStream.append(record)
    return timeLogRecordRepository.append(record)
      .asObservable() // TODO: Check, asSingle()
      .map { _ in return Void() }
  }
  
}
