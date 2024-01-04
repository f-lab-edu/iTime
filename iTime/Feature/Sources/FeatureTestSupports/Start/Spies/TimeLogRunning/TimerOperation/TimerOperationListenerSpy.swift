//
//  File.swift
//  
//
//  Created by 이상헌 on 1/2/24.
//

import Start

public class TimerOperationListenerSpy: TimerOperationListener {
  
  public var detachTimeLogRunningRIBCallCount: Int = 0
  public func detachTimeLogRunningRIB() {
    detachTimeLogRunningRIBCallCount += 1
  }
  public init() {}
}
