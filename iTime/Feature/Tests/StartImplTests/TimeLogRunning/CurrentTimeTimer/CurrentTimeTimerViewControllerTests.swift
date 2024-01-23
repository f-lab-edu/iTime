//
//  CurrentTimeTimerViewControllerTests.swift
//  
//
//  Created by 이상헌 on 1/23/24.
//

import XCTest
import SnapshotTesting
import ProxyTestSupport
@testable import StartImpl

final class CurrentTimeTimerViewControllerTests: XCTestCase {
  
  private var sut: CurrentTimerTimeViewController!
  

  override func setUp() {
    sut = CurrentTimerTimeViewController()
  }
  
  func test_CurrentTimeTimer_With_Empty() {
    verifyViewControllerImage(matching: sut, named: "CurrentTimeTimerViewController")
  }
  
  func test_CurrentTimeTimer_With_FullTimeLabel() {
    // Given
    let timeString = "9:99:99"
    // When
    sut.currentRunningTime(timeString)
    
    // Then
    verifyViewControllerImage(matching: sut, named: "CurrentTimeTimerViewController")
  }

}
