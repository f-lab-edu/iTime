//
//  File.swift
//  
//
//  Created by 이상헌 on 1/2/24.
//

import Foundation
import Start

public final class TimeLogRunningListenerSpy: TimeLogRunningListener {
  
  public var detachTimeLogRunningCallCount: Int = 0
  public func detachTimeLogRunningRIB() {
    detachTimeLogRunningCallCount += 1
  }
  
  public init() {} 
}
