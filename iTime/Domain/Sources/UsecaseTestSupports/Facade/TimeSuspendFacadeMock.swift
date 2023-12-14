//
//  File.swift
//  
//
//  Created by 이상헌 on 12/15/23.
//

import Usecase

public final class TimeSuspendFacadeMock: TimeSuspenseFacade {
  
  public var suspendCallCount: Int = 0
  public func suspend() {
    suspendCallCount += 1
  }

  public init() {}
}
