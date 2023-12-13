//
//  File.swift
//  
//
//  Created by 이상헌 on 12/13/23.
//
import Foundation
import RxSwift

import Repository

public final class RunningTimeTrackerMock: RunningTimeTracker {
  
  public var timerState: TimerState = .suspended
  
  public var startCallCount: Int = 0
  public func start() {
    startCallCount += 1
  }
  
  public var resumeCallCount: Int = 0
  public func resume() {
    resumeCallCount += 1
  }
  
  public var suspendCallCount: Int = 0
  public func suspend() {
    suspendCallCount += 1
  }
  
  public var cancelCallCount: Int = 0
  public func cancel() {
    cancelCallCount += 1
  }
  
  public var finishCallCount: Int = 0
  public func finish() {
    finishCallCount += 1
  }
  
  public func currentSeconds() -> Observable<Int> {
    return Observable<Int>.interval(.seconds(1), scheduler: MainScheduler.asyncInstance)
  }
  
  public func getStartDate() -> Date? {
    return Date()
  }
  
  
  public init() {}
}
