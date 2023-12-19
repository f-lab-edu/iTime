//
//  TimerUsecaseImplTests.swift
//  
//
//  Created by 이상헌 on 12/15/23.
//

import XCTest
import Entities
import RxSwift
import RepositoryTestSupports
import UsecaseTestSupports
@testable import UsecaseImpl

final class TimerUsecaseImplTests: XCTestCase {

  private var sut: TimerUsecaseImpl!
  private var timeLogRecordBuilder: TimeLogRecordBuilder!
  private var timeStartFacade: TimeStartFacadeMock!
  private var timeSuspenseFacade: TimeSuspendFacadeMock!
  private var timeFinishFacade: TimeFinishFacadeMock!
  
  override func setUp() {
    timeLogRecordBuilder = TimeLogRecordBuilder(
      locationTracker: LocationTrackerMock(),
      runningTimeTracker: RunningTimeTrackerMock(),
      timerInfoModelDataStream: TimerInfoModelDataStream()
    )
    timeStartFacade = TimeStartFacadeMock()
    timeSuspenseFacade = TimeSuspendFacadeMock()
    timeFinishFacade = TimeFinishFacadeMock()
    
    sut = TimerUsecaseImpl(
      timeLogRecordBuilder: timeLogRecordBuilder,
      timeStartFacade: timeStartFacade,
      timeSuspenseFacade: timeSuspenseFacade,
      timeFinishFacade: timeFinishFacade
    )
    
  }
  
  func test_start() async throws {
    // When
    async let result = sut.start().take(1).values
    
    // Then
    let void: Void? = try await result.first(where: { _ in true })
    XCTAssertNotNil(void)
    XCTAssertEqual(timeStartFacade.startCallCount, 1)
  }
  
  func test_suspend() {
    // When
    sut.suspend()
    
    // Then
    XCTAssertEqual(timeSuspenseFacade.suspendCallCount, 1)
  }
  
  func test_finish() async throws {
    // Given
    let dummyActivity = Activity(
      title: "dummy",
      category: .empty
    )
    
    // When
    async let result = sut.finish(dummyActivity).take(1).values
    
    // Then
    let void: Void? = try await result.first(where: { _ in true })
    XCTAssertNotNil(void)
    XCTAssertEqual(timeFinishFacade.finishCallCount, 1)
    XCTAssertNotNil(timeFinishFacade.record)
    
  }

}
