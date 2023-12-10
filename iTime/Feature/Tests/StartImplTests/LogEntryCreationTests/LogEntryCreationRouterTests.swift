//
//  LogEntryCreationRouterTests 2.swift
//
//
//  Created by 이상헌 on 11/19/23.
//

import XCTest

import RIBs

import Start
import Editor
import RIBsTestSupport
@testable import StartImpl

final class LogEntryCreationRouterTests: XCTestCase {
  private var sut: LogEntryCreationRouter!
  private var interactor: LogEntryCreationInteratableSpy!
  private var viewController: LogEntryCreationViewControllableSpy!
  private var logEntryEditorBuilder: LogEntryEditorBuildableSpy!
  private var bookmarkEditorBuilder: BookmarkEditorBuildableSpy!
  private var timeLogRunningBuilder: TimeLogRunningBuildableSpy!
  
  override func setUp() {
    super.setUp()
    
    interactor = LogEntryCreationInteratableSpy()
    viewController = LogEntryCreationViewControllableSpy()
    logEntryEditorBuilder = LogEntryEditorBuildableSpy()
    bookmarkEditorBuilder = BookmarkEditorBuildableSpy()
    timeLogRunningBuilder = TimeLogRunningBuildableSpy()
    
    sut = LogEntryCreationRouter(
      interactor: interactor,
      viewController: viewController,
      logEntryEditorBuilder: logEntryEditorBuilder,
      bookmarkEditorBuilder: bookmarkEditorBuilder, 
      timeLogRunningBuilder: timeLogRunningBuilder
    )
  }
  
  // MARK: - Tests
  
  func test_attach_logEntryEditor() {
    // Given
    let router = LogEntryEditorRoutingSpy(
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
    let router = LogEntryEditorRoutingSpy(
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
