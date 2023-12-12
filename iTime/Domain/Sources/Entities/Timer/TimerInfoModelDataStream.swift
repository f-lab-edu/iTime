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

public final class TimerInfoModelDataStream {
  
  // MARK: - Properties
  
  public var timerInfoModelDataStream: RxSwift.Observable<TimerInfo> { timerInfoModelDataRelay.asObservable() }
  private let timerInfoModelDataRelay = BehaviorRelay<TimerInfo>(value: TimerInfo())
  private var timerInfoModelRelayBuilder: PropertyBuilder<TimerInfo> { timerInfoModelDataRelay.value.builder }
  
  private let isRunningRelay = BehaviorRelay(value: false)
  
  // MARK: - Internal Methods
  
  public func updateTimerInfo(with info: TimerInfo) {
    timerInfoModelDataRelay.accept(info)
  }
  
  public func updateLastlyForegroundTrackedDate(with date: Date) {
    timerInfoModelDataRelay.accept(
      timerInfoModelRelayBuilder
        .lastlyForegroundTrackedDate(date)
    )
  }
  
  public func updateCurrentDate(with date: Date) {
    timerInfoModelDataRelay.accept(
      timerInfoModelRelayBuilder
        .currentDate(date)
    )
  }
  
  public func updateRunningTime(with time: Int) {
    timerInfoModelDataRelay.accept(
      timerInfoModelRelayBuilder
        .runningTime(time)
    )
  }
  
  public func updateStartTime(with time: Int) {
    timerInfoModelDataRelay.accept(
      timerInfoModelRelayBuilder
        .startTime(time)
    )
  }
  
  public init() {}
}
