//
//  TimeLogRunningRouterTests.swift
//  
//
//  Created by 이상헌 on 1/2/24.
//

import XCTest
import FeatureTestSupports
import RIBs
import RIBsTestSupport
import Start
@testable import StartImpl

final class TimeLogRunningRouterTests: XCTestCase {
  
  private var sut: TimeLogRunningRouter!
  private var currentActivityBuilder: CurrentActivityBuilderSpy!
  private var currentTimerTimeBuilder: CurrentTimerTimeBuilderSpy!
  private var activityDatePickerBuilder: ActivityDatePickerBuilderSpy!
  private var timerOperationBuilder: TimerOperationBuilderSpy!
  private var timeLogRunningInteractable: TimeLogRunningInteractableSpy!
  private var timeLogRunningViewControllable: TimeLogRunningViewControllableSpy!

  override func setUp() {
    currentActivityBuilder = CurrentActivityBuilderSpy()
    currentTimerTimeBuilder = CurrentTimerTimeBuilderSpy()
    activityDatePickerBuilder = ActivityDatePickerBuilderSpy()
    timerOperationBuilder = TimerOperationBuilderSpy()
    timeLogRunningInteractable = TimeLogRunningInteractableSpy()
    timeLogRunningViewControllable = TimeLogRunningViewControllableSpy()
    
    sut = TimeLogRunningRouter(
      interactor: timeLogRunningInteractable,
      viewController: timeLogRunningViewControllable,
      currentActivityBuilder: currentActivityBuilder,
      currentTimerTimeBuilder: currentTimerTimeBuilder,
      activityDatePickerBuilder: activityDatePickerBuilder,
      timerOperationBuilder: timerOperationBuilder
    )
  }
  
  func test_attachCurrentActivityRIB() {
    // Given
    let router = CurrentActivityRoutingSpy(
      interactable: Interactor(),
      viewControllable: ViewControllableMock()
    )
    
    var assignedListener: CurrentActivityListener?
    currentActivityBuilder.buildHandler = { listener in
      assignedListener = listener
      return router
    }
    // When
    sut.attachCurrentActivityRIB()
    
    // Then
    XCTAssert(assignedListener ===  timeLogRunningInteractable)
    XCTAssertEqual(currentActivityBuilder.buildCallCount, 1)
  }

  func test_attachCurrentTimerTimeRIB() {
    // Given
    let router = CurrentTimerTimeRoutingSpy(
      interactable: Interactor(),
      viewControllable: ViewControllableMock()
    )
    
    var assignedListener: CurrentTimerTimeListener?
    currentTimerTimeBuilder.buildHandler = { listener in
      assignedListener = listener
      return router
    }
    // When
    sut.attachCurrentTimerTimeRIB()
    
    // Then
    XCTAssert(assignedListener ===  timeLogRunningInteractable)
    XCTAssertEqual(currentTimerTimeBuilder.buildCallCount, 1)
  }
  
  func test_attachActivityDatePickerRIB() {
    // Given
    let router = ActivityDatePickerRoutingSpy(
      interactable: Interactor(),
      viewControllable: ViewControllableMock()
    )
    
    var assignedListener: ActivityDatePickerListener?
    activityDatePickerBuilder.buildHandler = { listener in
      assignedListener = listener
      return router
    }
    // When
    sut.attachActivityDatePickerRIB()
    
    // Then
    XCTAssert(assignedListener ===  timeLogRunningInteractable)
    XCTAssertEqual(activityDatePickerBuilder.buildCallCount, 1)
  }
  
  func test_attachTimerOperationRIB() {
    // Given
    let router = TimerOperationRoutingSpy(
      interactable: Interactor(),
      viewControllable: ViewControllableMock()
    )
    
    var assignedListener: TimerOperationListener?
    timerOperationBuilder.buildHandler = { listener in
      assignedListener = listener
      return router
    }
    // When
    sut.attachTimerOperationRIB()
    
    // Then
    XCTAssert(assignedListener ===  timeLogRunningInteractable)
    XCTAssertEqual(timerOperationBuilder.buildCallCount, 1)
  }
  
}
