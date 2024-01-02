//
//  File.swift
//  
//
//  Created by 이상헌 on 12/8/23.
//

import Start
import RIBsTestSupport

// MARK: - TimeLogRunningBuildableMock

public final class TimeLogRunningBuildableSpy: TimeLogRunningBuildable {
  
  public var buildHandler: ((_ listener: TimeLogRunningListener) -> TimeLogRunningRouting)?
  
  public var buildCallCount = 0
  public func build(withListener listener: Start.TimeLogRunningListener) -> Start.TimeLogRunningRouting {
    
    if let buildHandler = buildHandler {
      return buildHandler(listener)
    }
    
    fatalError()
  }
  
  public init() {}
}

// MARK: - TimeLogRunningRoutingMock

public final class TimeLogRunningRoutingSpy:
  ViewableRoutingMock,
  TimeLogRunningRouting {
  
}
