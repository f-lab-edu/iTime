//
//  CurrentActivityDatePickerInteractorTests.swift
//  
//
//  Created by 이상헌 on 1/2/24.
//

import XCTest
import FeatureTestSupports
import Start
import RxTest
@testable import StartImpl

final class CurrentActivityInteractorTests: XCTestCase {
  
  private var sut: CurrentActivityInteractor!
  private var currentActivityPresenter: CurrentActivityPresentableSpy!
  private var currentActivityListener: CurrentActivityListenerSpy!
  private var activityLogModelStream: ActivityLogModelStream!
  private var scheduler: TestScheduler!

  override func setUp() {
    scheduler = TestScheduler(initialClock: 0)
    currentActivityPresenter = CurrentActivityPresentableSpy()
    currentActivityListener = CurrentActivityListenerSpy()
    activityLogModelStream = ActivityLogModelStream()
    sut = CurrentActivityInteractor(
      presenter: currentActivityPresenter,
      activityLogModelStream: activityLogModelStream,
      observationScheduler: scheduler
    )
    sut.listener = currentActivityListener
  }
  
  func test_activate() {
    // When
    sut.activate()
    
    // Then
    XCTAssertTrue(sut.isActive)
    XCTAssertEqual(currentActivityPresenter.listenerSetCallCount, 1)
  }
  
  func test_loadData() {
    // Given
    let dummyTitle = "DUMMY"
    let dummyActivityLog = ActivityLog(title: dummyTitle)
    activityLogModelStream.updateActivityLog(with: dummyActivityLog)
    
    // When
    sut.activate()
    sut.loadData()
    
    // Then
    scheduler.start()
    
    XCTAssertEqual(currentActivityPresenter.bindTagViewTitleCallCount, 1)
    XCTAssertEqual(currentActivityPresenter.bindTagViewTitleSetValue, dummyTitle)
  }

}
