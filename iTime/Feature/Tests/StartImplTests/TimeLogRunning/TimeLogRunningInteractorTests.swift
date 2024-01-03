//
//  TimeLogRunningInteractorTests.swift
//  
//
//  Created by 이상헌 on 1/2/24.
//

import XCTest
import FeatureTestSupports
@testable import StartImpl

final class TimeLogRunningInteractorTests: XCTestCase {

  private var sut: TimeLogRunningInteractor!
  private var timeLogRunningPresentable: TimeLogRunningPresentableSpy!
  private var timeLogRunningListener: TimeLogRunningListenerSpy!
  
  override func setUp() {
    timeLogRunningPresentable = TimeLogRunningPresentableSpy()
    timeLogRunningListener = TimeLogRunningListenerSpy()
    sut = TimeLogRunningInteractor(presenter: timeLogRunningPresentable)
    sut.listener = timeLogRunningListener
  }
  
  
  func test_active() {
    // When
    sut.activate()
    
    // Then
    XCTAssertEqual(timeLogRunningPresentable.listenerSetCallCount, 1)
  }
  
  func test_didTapBackButton() {
    // When
    sut.didTapBackButton()
    
    // Then
    XCTAssertEqual(timeLogRunningListener.detachTimeLogRunningCallCount, 1)
  }
  
  func test_detachTimeLogRunningRIB() {
    // When
    sut.detachTimeLogRunningRIB()
    
    // Then
    XCTAssertEqual(timeLogRunningListener.detachTimeLogRunningCallCount, 1)
  }
  
  func test_didTapAddBookmark() { // TODO: 채워넣기
    // Given
    
    // When
    
    // Then
  }
  
  func test_didTapDeleteCurrentLog() { // TODO: 채워넣기
    // Given
    
    // When
    
    // Then
  }

}
