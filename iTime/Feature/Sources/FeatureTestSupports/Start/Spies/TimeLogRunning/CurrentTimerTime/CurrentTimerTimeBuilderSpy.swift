//
//  File.swift
//  
//
//  Created by 이상헌 on 1/2/24.
//

import Start

public final class CurrentTimerTimeBuilderSpy: CurrentTimerTimeBuildable {
  
  public var buildHandler: ((_ listener: CurrentTimerTimeListener) -> CurrentTimerTimeRouting)?
  
  public var buildCallCount: Int = 0
  public func build(withListener listener: Start.CurrentTimerTimeListener) -> Start.CurrentTimerTimeRouting {
    buildCallCount += 1
    if let buildHandler = buildHandler {
      return buildHandler(listener)
    }
    
    fatalError()
  }
  
  public init() {}
}
