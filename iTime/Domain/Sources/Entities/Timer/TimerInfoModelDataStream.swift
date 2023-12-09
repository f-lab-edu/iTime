//
//  File.swift
//
//
//  Created by 이상헌 on 12/9/23.
//

import Foundation

import RxSwift
import RxRelay

import AppFoundation

// MARK: - TimerInfoModelDataStream

public protocol TimerInfoModelDataStream {
  var timerInfoModelDataStream: Observable<TimerInfo> { get }
}

// MARK: - MutatableTimeInfoModelDataStream

public protocol MutableTimerInfoModelDataStream: TimerInfoModelDataStream {
  func updateTimerInfo(with info: TimerInfo)
  func updateLastlyForegroundTrackedDate(with date: Date)
  func updateCurrentDate(with date: Date)
  func updateRunningTime(with time: Int)
  func updateStartTime(with time: Int)
}

final class TimerInfoModelStreamImpl: MutableTimerInfoModelDataStream {
  
  // MARK: - Properties
  
  var timerInfoModelDataStream: RxSwift.Observable<TimerInfo> { timerInfoModelDataRelay.asObservable() }
  private let timerInfoModelDataRelay = BehaviorRelay<TimerInfo>(value: TimerInfo())
  private var timerInfoModelRelayBuilder: PropertyBuilder<TimerInfo> { timerInfoModelDataRelay.value.builder }
  
  private let isRunningRelay = BehaviorRelay(value: false)
  
  // MARK: - Internal Methods
  
  func updateTimerInfo(with info: TimerInfo) {
    timerInfoModelDataRelay.accept(info)
  }
  
  func updateLastlyForegroundTrackedDate(with date: Date) {
    timerInfoModelDataRelay.accept(
      timerInfoModelRelayBuilder
        .lastlyForegroundTrackedDate(date)
    )
  }
  
  func updateCurrentDate(with date: Date) {
    timerInfoModelDataRelay.accept(
      timerInfoModelRelayBuilder
        .currentDate(date)
    )
  }
  
  func updateRunningTime(with time: Int) {
    timerInfoModelDataRelay.accept(
      timerInfoModelRelayBuilder
        .runningTime(time)
    )
  }
  
  func updateStartTime(with time: Int) {
    timerInfoModelDataRelay.accept(
      timerInfoModelRelayBuilder
        .startTime(time)
    )
  }
}
