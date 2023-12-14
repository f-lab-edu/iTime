//
//  TimeSuspenseFacade.swift
//  
//
//  Created by 이상헌 on 12/14/23.
//

import XCTest

import UsecaseTestSupports
@testable import UsecaseImpl

final class TimeSuspenseFacadeImplTests: XCTestCase {

  private var sut: TimeSuspenseFacadeImpl!
  private var runningTimeTracker: RunningTimeTrackerMock!
  private var locationTracker: LocationTrackerMock!
  
  override func setUp() {
    runningTimeTracker = RunningTimeTrackerMock()
    locationTracker = LocationTrackerMock()
    
    sut = TimeSuspenseFacadeImpl(
      runningTimeTracker: runningTimeTracker,
      locationTracker: locationTracker
    )
  }
  
  func test_suspend() {
    // When
    sut.suspend()
    
    // Then
    XCTAssertEqual(runningTimeTracker.suspendCallCount, 1)
    XCTAssertEqual(locationTracker.stopLocationTrackingCallCount, 1)
  }
  
}
