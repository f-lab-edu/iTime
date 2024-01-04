//
//  ActivityDatePickerTests.swift
//  
//
//  Created by 이상헌 on 1/2/24.
//

import XCTest
import FeatureTestSupports
@testable import StartImpl

final class ActivityDatePickerInteractorTests: XCTestCase {
  
  private var sut: ActivityDatePickerInteractor!
  private var activityDatePickerPresenter: ActivityDatePickerPresentableSpy!
  private var activityDatePickerListener: ActivityDatePickerListenerSpy!

  override func setUp() {
    activityDatePickerPresenter = ActivityDatePickerPresentableSpy()
    activityDatePickerListener = ActivityDatePickerListenerSpy()
    sut = ActivityDatePickerInteractor(presenter: activityDatePickerPresenter)
    sut.listener = activityDatePickerListener
  }
  
  func test_activate() {
    // When
    sut.activate()
    
    // Then
    XCTAssertTrue(sut.isActive)
    XCTAssertEqual(activityDatePickerPresenter.listenerSetCallCount, 1)
  }

}
