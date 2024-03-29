//
//  TimerOperationInteractorTests.swift
//  
//
//  Created by 이상헌 on 1/2/24.
//

import XCTest
import RxTest
import FeatureTestSupports
import UsecaseTestSupports
import RIBsTestSupport
import Start
@testable import StartImpl

final class TimerOperationInteractorTests: XCTestCase {
  
  private var sut: TimerOperationInteractor!
  private var timerUsecase: TimerUsecaseMock!
  private var timerOperationPresenter: TimerOperationPresentableSpy!
  private var timerOperationListener: TimerOperationListenerSpy!
  private var timerOperationRouter: TimerOperationRoutingSpy!
  private var activityLogModelStream: ActivityLogModelStream!
  private var scheduler: TestScheduler!

  override func setUp() {
    scheduler = TestScheduler(initialClock: 0)
    timerUsecase = TimerUsecaseMock()
    timerOperationListener = TimerOperationListenerSpy()
    timerOperationPresenter = TimerOperationPresentableSpy()
    timerOperationRouter = TimerOperationRoutingSpy(
      interactable: InteractableMock(),
      viewControllable: ViewControllableMock()
    )
    activityLogModelStream = ActivityLogModelStream()
    sut = TimerOperationInteractor(
      presenter: timerOperationPresenter,
      timerUsecase: timerUsecase,
      activityLogModelStream: activityLogModelStream,
      observationScheduler: scheduler
    )
    sut.listener = timerOperationListener
    sut.router = timerOperationRouter
  }
  
  func test_activate() {
    // When
    sut.activate()
    
    // Then
    XCTAssertEqual(timerOperationPresenter.listenerSetCallCount, 1)
  }
  
  func test_didTapStartButton() {
    // When
    sut.didTapStartButton()
    
    // Then
    XCTAssertEqual(timerUsecase.startCallCount, 1)
    XCTAssertEqual(timerOperationPresenter.isTimeRunningCallCount, 1)
    XCTAssertTrue(timerOperationPresenter.isTimeRunningSetValue)
  }
  
  func test_didTapPauseButton() {
    // When
    sut.didTapPauseButton()
    
    // Then
    XCTAssertEqual(timerUsecase.suspendCallCount, 1)
    XCTAssertEqual(timerOperationPresenter.isTimeRunningCallCount, 1)
    XCTAssertFalse(timerOperationPresenter.isTimeRunningSetValue)
  }
  
  func test_didTapStopButton() {
    // Given
    let dummyTitle = "foo"
    let dummyActivityLog = ActivityLog(title: dummyTitle, category: .empty)
    activityLogModelStream.updateActivityLog(with: dummyActivityLog)
    
    // When
    sut.activate()
    sut.didTapStopButton()

    // Then
    scheduler.start()
    
    XCTAssertEqual(timerUsecase.finishCallCount, 1)
    XCTAssertEqual(timerUsecase.activityValue.title, dummyTitle)
    XCTAssertEqual(timerOperationListener.detachTimeLogRunningRIBCallCount, 1)
  }
}
