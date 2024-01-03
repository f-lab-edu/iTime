//
//  File.swift
//  
//
//  Created by 이상헌 on 1/2/24.
//

import Start

public class TimerOperationListenerSpy: TimerOperationListener {
  
  public var detachTimeLogRunningHandler: (()->())?
  public var detachTimeLogRunningRIBCallCount: Int = 0
  public func detachTimeLogRunningRIB() {
    detachTimeLogRunningRIBCallCount += 1
    detachTimeLogRunningHandler?()
  }
  public init() {}
}
