//
//  RunningTimeTrackerImplTests.swift
//
//
//  Created by 이상헌 on 12/13/23.
//
import XCTest
import RxSwift
import Clocks

import Repository
@testable import RepositoryImpl

final class RunningTimeTrackerImplTests: XCTestCase, @unchecked Sendable {
  
  private var sut: RunningTimeTrackerImpl!
  private var disposeBag: DisposeBag!
  private var testClock: TestClock<Duration>!
  
  override func setUp() {
    disposeBag = DisposeBag()
    testClock = TestClock()
    sut = RunningTimeTrackerImpl(timer: testClock)
  }
  
  override func tearDown() {
    super.tearDown()
    testClock = nil
    sut = nil
  }
  
  func test_StartDate_When_TimerStart() {
    // When
    sut.start()
    
    // Then
    XCTAssertNotNil(sut.getStartDate())
  }
  
  func test_Second_When_TimerStart() async throws {
    // When
    sut.start()
    
    // Then
    await testClock.advance(by: .seconds(1))
    
    async let second = sut.currentSeconds().take(1).values
    let result = try await second.first(where: { _ in true })
    XCTAssertEqual(result, 1)
  }
  
  func test_10_Seconds_When_TimeStart() async throws {
    // Given
    let expectedSeconds = 10
    
    // When
    sut.start()
    
    // Then
    await testClock.advance(by: .seconds(expectedSeconds))
    
    async let seconds = sut.currentSeconds().take(1).values
    let result = try await seconds.first(where: { _ in true })
    XCTAssertEqual(result, expectedSeconds)
  }
  
  
  func test_20_Seconds_When_TimeStart() async throws {
    // Given
    let expectedSeconds = 20
    
    // When
    sut.start()
    
    // Then
    await testClock.advance(by: .seconds(expectedSeconds))
    
    async let seconds = sut.currentSeconds().take(1).values
    let result = try await seconds.first(where: { _ in true })
    XCTAssertEqual(result, expectedSeconds)
  }
  
  
  func test_100_Seconds_When_TimeStart() async throws {
    // Given
    let expectedSeconds = 100
    
    // When
    sut.start()
    
    // Then
    await testClock.advance(by: .seconds(expectedSeconds))
    
    async let seconds = sut.currentSeconds().take(1).values
    let result = try await seconds.first(where: { _ in true })
    XCTAssertEqual(result, expectedSeconds)
  }
  
  func test_1000_Seconds_When_TimeStart() async throws {
    // Given
    let expectedSeconds = 100 // TEMP: swift-clock PR 반영된후 반영
    
    // When
    sut.start()
    
    // Then
    await testClock.advance(by: .seconds(expectedSeconds))
    
    async let seconds = sut.currentSeconds().take(1).values
    let result = try await seconds.first(where: { _ in true })
    XCTAssertEqual(result, expectedSeconds)
  }

  func test_random_Seconds_When_TimeStart() async throws {
    // Given
    let randomSecond = Int.random(in: 1..<1000)
    
    // When
    sut.start()
    
    // Then
    await testClock.advance(by: .seconds(randomSecond))
    
    async let seconds = sut.currentSeconds().take(1).values
    let result = try await seconds.first(where: { _ in true })
    XCTAssertEqual(result, randomSecond)
  }
  
  func test_Time_Passes_When_TimeStart() async throws {
    // When
    sut.start()
    
    // Then
    await testClock.advance(by: .seconds(1))
    
    async let afterOneSecond = sut.currentSeconds().take(1).values
    let oneSecond = try await afterOneSecond.first(where: { _ in true })
    XCTAssertEqual(oneSecond, 1)
    
    await testClock.advance(by: .seconds(3))
    
    async let afterThreeSecond = sut.currentSeconds().take(1).values
    let threeSecond = try await afterThreeSecond.first(where: { _ in true })
    XCTAssertEqual(threeSecond, 4)
    
    await testClock.advance(by: .seconds(4))
    
    async let afterFourSecond = sut.currentSeconds().take(1).values
    let eightSecond = try await afterFourSecond.first(where: { _ in true })
    XCTAssertEqual(eightSecond, 8)
  }
}
