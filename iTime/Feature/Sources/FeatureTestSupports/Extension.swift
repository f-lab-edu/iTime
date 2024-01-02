//
//  File.swift
//  
//
//  Created by 이상헌 on 1/2/24.
//

import XCTest

extension XCTestCase {
  public func wait(timeout: TimeInterval) {
      let expectation = XCTestExpectation(description: "Waiting for \(timeout) seconds")
      XCTWaiter().wait(for: [expectation], timeout: timeout)
  }
}
