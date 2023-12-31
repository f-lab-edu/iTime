//
//  File.swift
//  
//
//  Created by 이상헌 on 12/12/23.
//

import Foundation

import RxSwift
import RxRelay

import Repository
import Clocks

// MARK: - RunningTimeTrackerImpl

public final class RunningTimeTrackerImpl: RunningTimeTracker {
  
  public var timerState = TimerState.suspended
  private let timerSecondRelay: BehaviorRelay<Int> = .init(value: .zero)
  private var startDate: Date?
  private let timer: any Clock<Duration>
  private var timerTask: Task<Void, Error>?
  
  public init(timer: any Clock<Duration>) {
    self.timer = timer
  }
  
  public func currentSeconds() -> Observable<Int> {
    timerSecondRelay.asObservable()
  }
  
  public func getStartDate() -> Date? {
    return startDate
  }
  
  public func start() {
    guard timerState == .suspended else { return }
    startDate = Date()
    resume()
  }
  
  public func resume() {
    guard timerState == .suspended else { return }
    timerState = .resumed
    setTimer()
  }
  
  public func suspend() {
    guard timerState == .resumed else { return }
    timerState = .suspended
    initTimer()
  }
  
  public func finish() {
    timerState = .finished
    initTimer()
  }
  
  // MARK: - Private
  
  private func setTimer() {
    initTimer()
    timerTask = Task {
      for await _ in self.timer.timer(interval: .seconds(1)) {
        let currentSecond = self.timerSecondRelay.value
        self.timerSecondRelay.accept(currentSecond + 1)
      }
    }
  }
  
  private func initTimer() {
    timerTask?.cancel()
    timerTask = nil
  }
}
