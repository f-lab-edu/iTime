//
//  File.swift
//  
//
//  Created by 이상헌 on 1/2/24.
//

import Start

public final class TimerOperationBuilderSpy: TimerOperationBuildable {
  
  public var buildHandler: ((_ listener: TimerOperationListener) -> TimerOperationRouting)?
  
  public var buildCallCount: Int = 0
  public func build(withListener listener: Start.TimerOperationListener) -> Start.TimerOperationRouting {
    buildCallCount += 1
    if let buildHandler = buildHandler {
      return buildHandler(listener)
    }
    
    fatalError()
  }
  
  public init() {}
}
