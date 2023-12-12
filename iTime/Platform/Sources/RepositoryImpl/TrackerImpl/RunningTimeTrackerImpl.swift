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

public final class RunningTimeTrackerImpl: RunningTimeTracker {
  
  public var timerState = TimerState.canceled
  private var timers = DispatchSource.makeTimerSource()
  private let timerSecondRelay: BehaviorRelay<Int> = .init(value: .zero)
  private var startDate: Date?
                                                        
  deinit {
    removeTimer()
  }
  
  public func currentSeconds() -> Observable<Int> {
    timerSecondRelay.asObservable()
  }
  
  public func getStartDate() -> Date? {
    return startDate
  }
  
  public func start() {
    guard timerState == .canceled else {
      resumed()
      return
    }
    startDate = Date()
    setTimer()
    resumed()
  }
  
  public func resumed() {
    guard timerState == .suspended else { return }
    timerState = .resumed
    timers.resume()
  }
  
  public func suspend() {
    guard timerState == .resumed else { return }
    timerState = .suspended
    timers.suspend()
  }
  
  public func cancel() {
    timerState = .canceled
    initTimer()
  }
  
  public func finish() {
    timerState = .finished
    cancel()
  }
  
  // MARK: - Private
  
  private func setTimer() {
    initTimer()
    
    timers.schedule(deadline: .now(), repeating: 1)
    timers.setEventHandler(handler: { [weak self] in
      guard let currentSecond = self?.timerSecondRelay.value else { return }
      self?.timerSecondRelay.accept(currentSecond + 1)
    })
  }
  
  private func initTimer() {
    timers.setEventHandler(handler: nil)
  }
  
  private func removeTimer() {
    timers.resume()
    timers.cancel()
    initTimer()
  }
  
}
