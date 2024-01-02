//
//  CurrentTimeTimerInteractorTests.swift
//  
//
//  Created by 이상헌 on 1/2/24.
//

import XCTest
import FeatureTestSupports
import RIBsTestSupport
import Entities
import RxTest
@testable import StartImpl

final class CurrentTimeTimerInteractorTests: XCTestCase {
  
  private var sut: CurrentTimerTimeInteractor!
  private var currentTimerTimePresenter: CurrentTimerTimePresentableSpy!
  private var currentTimerTimeListener: CurrentTimerTimeListenerSpy!
  private var currentTimerTimeRouter: CurrentTimerTimeRoutingSpy!
  private var timerInfoModelDataStream: TimerInfoModelDataStream!
  
  override func setUp() {
    currentTimerTimePresenter = CurrentTimerTimePresentableSpy()
    timerInfoModelDataStream = TimerInfoModelDataStream()
    currentTimerTimeRouter = CurrentTimerTimeRoutingSpy(
      interactable: InteractableMock(),
      viewControllable: ViewControllableMock()
    )
    currentTimerTimeListener = CurrentTimerTimeListenerSpy()
    sut = CurrentTimerTimeInteractor(
      presenter: currentTimerTimePresenter,
      timerInfoModelDataStream: timerInfoModelDataStream
    )
    sut.listener = currentTimerTimeListener
    sut.router = currentTimerTimeRouter
  }
  
  func test_activate() {
    // When
    sut.activate()
    
    // Then
    XCTAssertEqual(currentTimerTimePresenter.listenerSetCallCount, 1)
  }
  
  func test_loadCurrentTime() async throws {
    // Given
    let dummyTimerInfo = TimerInfo(
      lastlyForegroundTrackedDate: Date(),
      currentDate: Date(),
      runningTime: 10,
      startTime: 1
    )
    timerInfoModelDataStream.updateTimerInfo(with: dummyTimerInfo)
    
    // When
    sut.loadCurrentTime()
    
    // Then
    async let response = timerInfoModelDataStream.timerInfoModelDataStream.filter { $0 == dummyTimerInfo }.values
    let result = try await response.first(where: { _ in true })
    XCTAssertNotNil(result)
    XCTAssertEqual(currentTimerTimePresenter.currentRunningTimeCallCount, 1)
    XCTAssertFalse(currentTimerTimePresenter.currentRunningTimeSetValue.isEmpty)
  }

}
