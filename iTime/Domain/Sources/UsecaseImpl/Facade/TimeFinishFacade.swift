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
  private let mutableTimeLogRecordModelDataStream: MutableTimeLogRecordModelDataStream
  
  init(
    locationTracker: LocationTracker,
    runningTimeTracker: RunningTimeTracker,
    timeLogRecordRepository: TimeLogRecordRepository,
    mutableTimeLogRecordModelDataStream: MutableTimeLogRecordModelDataStream
  ) {
    self.locationTracker = locationTracker
    self.runningTimeTracker = runningTimeTracker
    self.timeLogRecordRepository = timeLogRecordRepository
    self.mutableTimeLogRecordModelDataStream = mutableTimeLogRecordModelDataStream
  }
  
  func finish(_ record: TimeLogRecord) -> Observable<Void> {
    runningTimeTracker.resetTimer()
    locationTracker.resetLocationTracking()
    mutableTimeLogRecordModelDataStream.append(record)
    return timeLogRecordRepository.append(record)
      .asObservable() // TODO: Check, asSingle()
      .map { _ in return Void() }
  }
  
}
