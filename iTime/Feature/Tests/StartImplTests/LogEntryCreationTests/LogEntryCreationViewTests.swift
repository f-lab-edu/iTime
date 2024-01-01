//
//  LogEntryCreationViewTests.swift
//  
//
//  Created by 이상헌 on 12/9/23.
//

import XCTest
import Foundation
import RepositoryTestSupports
import ProxyTestSupport
import Entities
import SnapshotTesting
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
    // assertSnapshot(of: sut, as: .image(on: .iPhone13ProMax))
    // snapShot 테스트 본격적으로 작성시 같이 반영 -TODO: 
  }
  
}
