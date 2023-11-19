//
//  LogEntryCreationRouterTests 2.swift
//
//
//  Created by 이상헌 on 11/19/23.
//

import XCTest

import RIBs

import Start
import RIBsTestSupport
@testable import StartImpl

final class LogEntryCreationRouterTests: XCTestCase {
  private var sut: LogEntryCreationRouter!
  private var interactor: LogEntryCreationInteratableMock!
  private var viewController: LogEntryCreationViewControllableMock!
  private var logEntryEditorBuilder: LogEntryEditorBuildableMock!
  private var bookmarkEditorBuilder: BookmarkEditorBuildableMock!
  
  override func setUp() {
    super.setUp()
    
    interactor = LogEntryCreationInteratableMock()
    viewController = LogEntryCreationViewControllableMock()
    logEntryEditorBuilder = LogEntryEditorBuildableMock()
    bookmarkEditorBuilder = BookmarkEditorBuildableMock()
    
    sut = LogEntryCreationRouter(
      interactor: interactor,
      viewController: viewController,
      logEntryEditorBuilder: logEntryEditorBuilder,
      bookmarkEditorBuilder: bookmarkEditorBuilder
    )
  }
  
  // MARK: - Tests
  
  func test_attach_logEntryEditor() {
    // Given
    let router = LogEntryEditorRoutingMock(
      interactable: Interactor(),
      viewControllable: ViewControllableMock()
    )
    
    var assignedListener: LogEntryEditorListener?
    logEntryEditorBuilder.buildHandler = { listener in
      assignedListener = listener
      return router
    }
    
    // When
    sut.attachLogEntryEditorRIB()
    
    // Then
    XCTAssert(assignedListener === interactor)
    XCTAssertEqual(logEntryEditorBuilder.buildCallCount, 1)
    wait(timeout: 1)
    XCTAssertEqual(viewController.presentCallCount, 1)
  }
  
  func test_detach_logEntryEditor() {
    // Given
    let router = LogEntryEditorRoutingMock(
      interactable: Interactor(),
      viewControllable: ViewControllableMock()
    )
    
    var assignedListener: LogEntryEditorListener?
    logEntryEditorBuilder.buildHandler = { listener in
      assignedListener = listener
      return router
    }
    sut.attachLogEntryEditorRIB()
    let expectedChildsCount = sut.children.count - 1
    
    // When
    sut.detachLogEntryEditorRIB()
    
    // Then
    XCTAssertEqual(expectedChildsCount, sut.children.count)
    wait(timeout: 1)
    XCTAssertEqual(viewController.dismissCallCount, 1)
  }
  
  func test_attach_bookmarkEditor() {
    // Given
    let router = BookmarkEditorRoutingMock(
      interactable: Interactor(),
      viewControllable: ViewControllableMock()
    )
    
    var assignedListener: BookmarkEditorListener?
    bookmarkEditorBuilder.buildHandler = { listener in
      assignedListener = listener
      return router
    }
    
    // When
    sut.attachBookmarkEditorRIB()
    
    // Then
    XCTAssertTrue(assignedListener === interactor)
    XCTAssertEqual(bookmarkEditorBuilder.buildCallCount, 1)
    wait(timeout: 1)
    XCTAssertEqual(viewController.presentCallCount, 1)
  }
  
  func test_detach_bookmarkEditor() {
    // Given
    let router = BookmarkEditorRoutingMock(
      interactable: Interactor(),
      viewControllable: ViewControllableMock()
    )
    
    var assignedListener: BookmarkEditorListener?
    bookmarkEditorBuilder.buildHandler = { listener in
      assignedListener = listener
      return router
    }
    sut.attachBookmarkEditorRIB()
    let expectedChildsCount = sut.children.count - 1
    
    // When
    sut.detachBookmarkEditorRIB()
    
    // Then
    XCTAssertEqual(expectedChildsCount, sut.children.count)
    wait(timeout: 1)
    XCTAssertEqual(viewController.dismissCallCount, 1)
  }
  
  
  func wait(timeout: TimeInterval) {
      let expectation = XCTestExpectation(description: "Waiting for \(timeout) seconds")
      XCTWaiter().wait(for: [expectation], timeout: timeout)
  }
}