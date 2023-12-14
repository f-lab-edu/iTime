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

final class TimeFinishFacadeImpltests: XCTestCase {

  private var sut: TimeFinishFacadeImpl!
  private var locationTracker: LocationTrackerMock!
  private var runningTimeTracker: RunningTimeTrackerMock!
  private var timeLogRecordRepository: TimeLogRecordRepositoryMock!
  private var timeLogRecordModelDataStream: TimeLogRecordModelDataStream!
  
  override func setUp() {
    locationTracker = LocationTrackerMock()
    runningTimeTracker = RunningTimeTrackerMock()
    timeLogRecordRepository = TimeLogRecordRepositoryMock()
    timeLogRecordModelDataStream = TimeLogRecordModelDataStream()
    
    sut = TimeFinishFacadeImpl(
      locationTracker: locationTracker,
      runningTimeTracker: runningTimeTracker,
      timeLogRecordRepository: timeLogRecordRepository,
      timeLogRecordModelDataStream: timeLogRecordModelDataStream
    )
  }
  
  func test_finish() async throws {
    // Given
    let dummyTimeLogRecord = DummyData.DummyTimeLogRecord.dummyTimeLogRecord
    timeLogRecordModelDataStream.updateRecords(with: [])
    
    // When
    async let void = sut.finish(dummyTimeLogRecord).take(1).values
    async let timeLogRecords = timeLogRecordModelDataStream.timeLogRecords.values
    
    // Then
    let result: Void? = try await void.first(where: { _ in true })
    let record = try await timeLogRecords.first(where: { _ in true })
    XCTAssertNotNil(result)
    XCTAssertEqual(record, [dummyTimeLogRecord])
    XCTAssertEqual(timeLogRecordRepository.appendCallCount, 1)
    XCTAssertEqual(runningTimeTracker.finishCallCount, 1)
    XCTAssertEqual(locationTracker.resetLocationTrackingCallCount, 1)
  }

}
