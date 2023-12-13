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
  
  public var timerState = TimerState.suspended
  private let timerSecondRelay: BehaviorRelay<Int> = .init(value: .zero)
  private var startDate: Date?
  private let timer = DispatchSource.makeTimerSource(queue: .global(qos: .background))
                                                        
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
    startDate = Date()
    setTimer()
    resumed()
  }
  
  public func resumed() {
    guard timerState == .suspended else { return }
    timerState = .resumed
    timer.resume()
  }
  
  public func suspend() {
    guard timerState == .resumed else { return }
    timerState = .suspended
    timer.suspend()
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
    
    timer.schedule(deadline: .now(), repeating: 1)
    timer.setEventHandler(handler: { [weak self] in
      guard let currentSecond = self?.timerSecondRelay.value else { return }
      self?.timerSecondRelay.accept(currentSecond + 1)
    })
  }
  
  private func initTimer() {
    timer.setEventHandler(handler: nil)
  }
  
  private func removeTimer() {
    timer.resume()
    timer.cancel()
    initTimer()
  }
  
  public init() {}
}
