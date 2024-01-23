//
//  LogEntryCreationViewTests.swift
//  
//
//  Created by 이상헌 on 12/9/23.
//

import XCTest
import ProxyTestSupport
import SnapshotTesting
import FeatureTestSupports
@testable import StartImpl

final class LogEntryCreationViewTests: XCTestCase {
  
  private var sut: LogEntryCreationViewController!
  private var listener: LogEntryCreationPresentableListenerStub!
  
  override func setUp() {
    sut = LogEntryCreationViewController()
    listener = LogEntryCreationPresentableListenerStub()
    sut.listener = listener
  }

  func test_LogEntryCreation() {
    
    // Then
    assertSnapshot(of: sut, as: .image)
  }
  
}
