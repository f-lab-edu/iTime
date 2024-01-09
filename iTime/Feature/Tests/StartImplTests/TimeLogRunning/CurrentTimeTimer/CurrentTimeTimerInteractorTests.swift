//
//  CurrentTimeTimerInteractorTests.swift
//  
//
//  Created by 이상헌 on 1/2/24.
//
import Foundation

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
  private var scheduler: TestScheduler!
  
  override func setUp() {
    scheduler = TestScheduler(initialClock: 0)
    currentTimerTimePresenter = CurrentTimerTimePresentableSpy()
    timerInfoModelDataStream = TimerInfoModelDataStream()
    currentTimerTimeRouter = CurrentTimerTimeRoutingSpy(
      interactable: InteractableMock(),
      viewControllable: ViewControllableMock()
    )
    currentTimerTimeListener = CurrentTimerTimeListenerSpy()
    sut = CurrentTimerTimeInteractor(
      presenter: currentTimerTimePresenter,
      timerInfoModelDataStream: timerInfoModelDataStream,
      observationScheduler: scheduler
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
  
  func test_loadCurrentTime() {
    // When
    sut.activate()
    sut.loadCurrentTime()
    
    
    // Then
    scheduler.start()
    
    XCTAssertEqual(currentTimerTimePresenter.currentRunningTimeCallCount, 1)
    XCTAssertFalse(currentTimerTimePresenter.currentRunningTimeSetValue.isEmpty)
  }

}
