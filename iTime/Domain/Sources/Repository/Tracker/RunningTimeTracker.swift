//
//  File.swift
//
//
//  Created by 이상헌 on 12/9/23.
//

import Foundation

import RxSwift
import RxRelay

public enum TimerState {
  case suspended
  case resumed
  case canceled
  case finished
}

public protocol RunningTimeTracker {
  var timerState: TimerState { get }
  
  func start()
  func resumed()
  func suspend()
  func cancel()
  func finish()
  
  func currentSeconds() -> Observable<Int>
  func getStartDate() -> Date?
}

