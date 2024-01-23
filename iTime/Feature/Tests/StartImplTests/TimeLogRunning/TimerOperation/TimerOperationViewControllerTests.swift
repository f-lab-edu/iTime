//
//  TimerOperationViewControllerTests.swift
//  
//
//  Created by 이상헌 on 1/23/24.
//

import XCTest
import SnapshotTesting
@testable import StartImpl

final class TimerOperationViewControllerTests: XCTestCase {
  
  private var sut: TimerOperationViewController!

  override func setUp() {
    sut = TimerOperationViewController()
  }
  
  func test_Default() {
    assertSnapshot(of: sut, as: .image(size: .init(width: 200, height: 100)))
  }

}
