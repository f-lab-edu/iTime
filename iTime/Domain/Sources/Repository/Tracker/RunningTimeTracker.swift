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
  case resumed
  case suspended
  case finished
}

public protocol RunningTimeTracker {
  var timerState: TimerState { get }
  
  func start()
  func resume()
  func suspend()
  func finish()
  
  func currentSeconds() -> Observable<Int>
  func getStartDate() -> Date?
}

