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
import RxSwift
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
  
  func test_loadCurrentTime() {
    // Given
    let expectation = XCTestExpectation()
    
    // When & Then
    currentTimerTimePresenter.currentRunningTimeHandler = {
      XCTAssertEqual(self.currentTimerTimePresenter.currentRunningTimeCallCount, 1)
      XCTAssertFalse(self.currentTimerTimePresenter.currentRunningTimeSetValue.isEmpty)
      expectation.fulfill()
    }
    
    sut.activate()
    sut.loadCurrentTime()

    wait(for: [expectation], timeout: 5)
  }

}
