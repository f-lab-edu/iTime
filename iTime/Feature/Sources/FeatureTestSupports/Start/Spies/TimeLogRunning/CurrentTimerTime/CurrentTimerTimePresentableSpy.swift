//
//  File.swift
//  
//
//  Created by 이상헌 on 1/2/24.
//

import StartImpl

public class CurrentTimerTimePresentableSpy: CurrentTimerTimePresentable {
  public var listenerSetCallCount: Int = 0
  public var listener: StartImpl.CurrentTimerTimePresentableListener? { didSet { self.listenerSetCallCount += 1}}
  
  
  public var currentRunningTimeHandler: (() -> ())?
  public var currentRunningTimeCallCount: Int = 0
  public var currentRunningTimeSetValue: String = String()
  public func currentRunningTime(_ time: String) {
    currentRunningTimeCallCount += 1
    currentRunningTimeSetValue = time
    currentRunningTimeHandler?()
  }
  
  public init() {}
}
