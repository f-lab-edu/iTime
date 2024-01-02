//
//  File.swift
//  
//
//  Created by 이상헌 on 1/2/24.
//

import StartImpl

public class TimerOperationPresentableSpy: TimerOperationPresentable {
  
  public var listenerSetCallCount: Int = 0
  public var listener: StartImpl.TimerOperationPresentableListener? { didSet { self.listenerSetCallCount += 1}}
  
  public var isTimeRunningCallCount: Int = 0
  public var isTimeRunningSetValue: Bool = false
  public func isTimeRunning(_ isRunning: Bool) {
    isTimeRunningCallCount += 1
    isTimeRunningSetValue = isRunning
  }
  
  public init() {}
}
