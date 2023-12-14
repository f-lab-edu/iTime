//
//  TimeFinishFacade.swift
//  
//
//  Created by 이상헌 on 12/14/23.
//

import XCTest
import Entities
import RepositoryTestSupports
import UsecaseTestSupports
@testable import UsecaseImpl

final class TimeFinishFacadeTests: XCTestCase {

  private var sut: TimeFinishFacade!
  private var locationTracker: LocationTrackerMock!
  private var runningTimeTracker: RunningTimeTrackerMock!
  private var timeLogRecordRepository: TimeLogRecordRepositoryMock!
  private var timeLogRecordModelDataStream: TimeLogRecordModelDataStream!
  
  override func setUp() {
    locationTracker = LocationTrackerMock()
    runningTimeTracker = RunningTimeTrackerMock()
    timeLogRecordRepository = TimeLogRecordRepositoryMock()
    timeLogRecordModelDataStream = TimeLogRecordModelDataStream()
    
    sut = TimeFinishFacade(
      locationTracker: locationTracker,
      runningTimeTracker: runningTimeTracker,
      timeLogRecordRepository: timeLogRecordRepository,
      timeLogRecordModelDataStream: timeLogRecordModelDataStream
    )
  }

}
