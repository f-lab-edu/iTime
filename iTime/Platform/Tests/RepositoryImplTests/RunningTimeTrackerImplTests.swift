//
//  RunningTimeTrackerImplTests.swift
//
//
//  Created by 이상헌 on 12/13/23.
//
import XCTest
import RxSwift

import Repository
@testable import RepositoryImpl

final class RunningTimeTrackerImplTests: XCTestCase {
  
  private var sut: RunningTimeTrackerImpl!
  private var disposeBag: DisposeBag!
  
  override func setUp() {
    disposeBag = DisposeBag()
    sut = RunningTimeTrackerImpl()
  }
  
  
  func test_StartDate_When_TimerStart() async throws {
    // When
    sut.start()
    
    // Then
    XCTAssertNotNil(sut.getStartDate())
  }
  
  func test_seconds_When_TimerStart() {
    // When
    sut.start()
    
    // Then
    sut.currentSeconds()
      .skip(3)
      .subscribe { seconds in
        XCTAssertGreaterThan(seconds, 2)
      }
      .disposed(by: disposeBag)
    wait(timeout: 5)
  }
  
  func test_suspend() {
    // When
    sut.start()
    sut.suspend()
    
    // Then
    sut.currentSeconds()
      .skip(1)
      .subscribe { _ in
        XCTFail()
      }
      .disposed(by: disposeBag)
    
    wait(timeout: 3)
  }
  
  
  func test_cancel() {
    sut.start()
    sut.cancel()
    
    // Then
    sut.currentSeconds()
      .skip(1)
      .subscribe { _ in
        XCTFail()
      }
      .disposed(by: disposeBag)
    
    wait(timeout: 3)
  }
  
  func wait(timeout: TimeInterval) {
    let expectation = XCTestExpectation(description: "Waiting for \(timeout) seconds")
    XCTWaiter().wait(for: [expectation], timeout: timeout)
  }
  
}
