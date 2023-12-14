//
//  TimeSuspenseFacade.swift
//  
//
//  Created by 이상헌 on 12/14/23.
//

import XCTest

import UsecaseTestSupports
@testable import UsecaseImpl

final class TimeSuspenseFacadeTests: XCTestCase {

  private var sut: TimeSuspenseFacade!
  private var runningTimeTracker: RunningTimeTrackerMock!
  private var locationTracker: LocationTrackerMock!
  
  override func setUp() {
    runningTimeTracker = RunningTimeTrackerMock()
    locationTracker = LocationTrackerMock()
    
    sut = TimeSuspenseFacade(
      runningTimeTracker: runningTimeTracker,
      locationTracker: locationTracker
    )
  }
  
  
}
