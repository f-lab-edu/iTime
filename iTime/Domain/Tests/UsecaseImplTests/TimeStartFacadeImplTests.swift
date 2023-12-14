//
//  TimerStartFacadeTests.swift
//  
//
//  Created by 이상헌 on 12/13/23.
//

import XCTest

import Entities
import UsecaseTestSupports
import RepositoryTestSupports

@testable import UsecaseImpl

final class TimeStartFacadeImplTests: XCTestCase {
  
  private var sut: TimeStartFacadeImpl!
  private var locationTracker: LocationTrackerMock!
  private var runningTimeTracker: RunningTimeTrackerMock!
  private var timerInfoModelDataStream: TimerInfoModelDataStream!
  private var userDefaultRepository: UserDefaultRepositoryMock!
  

  override func setUp() {
    locationTracker = LocationTrackerMock()
    runningTimeTracker = RunningTimeTrackerMock()
    timerInfoModelDataStream = TimerInfoModelDataStream()
    userDefaultRepository = UserDefaultRepositoryMock()
    
    sut = TimeStartFacadeImpl(
      locationTracker: locationTracker,
      runningTimeTracker: runningTimeTracker,
      timerInfoModelDataStream: timerInfoModelDataStream,
      userDefaultRepository: userDefaultRepository
    )
  }
  
  func test_start() async throws {
    // Given
    let dummyLastlyTrackTime = userDefaultRepository.dummyLastlyTrackTime + 1
    
    // When
    async let start = sut.start().take(1).values
    async let modelStream = timerInfoModelDataStream.timerInfoModelDataStream.map(\.runningTime).filter { $0 != Int() }.take(1).values
    
    // Then
    let void: Void? = try await start.first(where: { _ in true })
    let runningTime = try await modelStream.first(where: { _ in true })
    XCTAssertNotNil(void)
    XCTAssertEqual(locationTracker.startLocationTrackingCallCount, 1)
    XCTAssertEqual(runningTime, 1)
    XCTAssertEqual(userDefaultRepository.updateLastlyTrackedTimeCallCount, 1)
    XCTAssertEqual(dummyLastlyTrackTime, userDefaultRepository.lastlyTrackedTime())
  }
  

}
