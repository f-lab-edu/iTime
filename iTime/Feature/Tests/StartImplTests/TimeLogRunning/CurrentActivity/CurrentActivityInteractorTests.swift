//
//  CurrentActivityDatePickerInteractorTests.swift
//  
//
//  Created by 이상헌 on 1/2/24.
//

import XCTest
import FeatureTestSupports
import Start
@testable import StartImpl

final class CurrentActivityInteractorTests: XCTestCase {
  
  private var sut: CurrentActivityInteractor!
  private var currentActivityPresenter: CurrentActivityPresentableSpy!
  private var currentActivityListener: CurrentActivityListenerSpy!
  private var activityLogModelStream: ActivityLogModelStream!

  override func setUp() {
    currentActivityPresenter = CurrentActivityPresentableSpy()
    currentActivityListener = CurrentActivityListenerSpy()
    activityLogModelStream = ActivityLogModelStream()
    sut = CurrentActivityInteractor(
      presenter: currentActivityPresenter,
      activityLogModelStream: activityLogModelStream
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
    let expectation = XCTestExpectation()
    let dummyTitle = "DUMMY"
    let dummyActivityLog = ActivityLog(title: dummyTitle)
    activityLogModelStream.updateActivityLog(with: dummyActivityLog)
    
    // When & Then
    currentActivityPresenter.bindTageViewTitleHandler = {
      XCTAssertEqual(self.currentActivityPresenter.bindTagViewTitleCallCount, 1)
      XCTAssertEqual(self.currentActivityPresenter.bindTagViewTitleSetValue, dummyTitle)
      expectation.fulfill()
    }

    sut.activate()
    sut.loadData()
    
    wait(for: [expectation], timeout: 5)
  }

}
