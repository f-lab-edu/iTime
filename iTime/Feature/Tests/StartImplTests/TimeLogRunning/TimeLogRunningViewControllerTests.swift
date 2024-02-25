//
//  TimeLogRunningViewControllerTests.swift
//  
//
//  Created by 이상헌 on 1/23/24.
//

import XCTest
import SnapshotTesting
import ProxyTestSupport
@testable import StartImpl

final class TimeLogRunningViewControllerTests: XCTestCase {
  
  private var sut: TimeLogRunningViewController!

  override func setUp() {
    sut = TimeLogRunningViewController()
  }
  
  func test_TimeLogRunningView_Default() {
    //assertViewControllerImage(matching: sut, named: "test_TimeLogRunningView_Default")
  }

}
