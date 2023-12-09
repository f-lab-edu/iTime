//
//  File.swift
//  
//
//  Created by 이상헌 on 12/9/23.
//

import Foundation

import RxSwift
import RxRelay

final class RunningTimeTracker {
  
  private let timerTimeRelay: BehaviorRelay<Int> = .init(value: .zero)
  private let isTimerRunning: BehaviorRelay = BehaviorRelay(value: false)
  private var startDate: Date?
  
  private let disposeBag = DisposeBag()
  
  func currentTimerTime() -> Observable<Int> {
    return timerTimeRelay.asObservable()
  }
  
  func initiateTimerIfNeeded() {
    guard timerTimeRelay.value == .zero else { return }
    startTimer()
    
    isTimerRunning
      .filter { $0 }
      .flatMapLatest { _ in Observable<Int>.interval(.seconds(1), scheduler: ConcurrentDispatchQueueScheduler(qos: .background)) }
      .subscribe(with: self) { owner, interval in
        if interval == 1 { owner.startDate = Date() }
        owner.timerTimeRelay.accept(interval)
      }
      .disposed(by: disposeBag)
  }
  
  func getStartDate() -> Date? {
    startDate
  }
  
  func startTimer() {
    isTimerRunning.accept(true)
  }
  
  func stopTimer() {
    isTimerRunning.accept(false)
  }
  
  func resetTimer() {
    isTimerRunning.accept(false)
    timerTimeRelay.accept(.zero)
  }
  
}
