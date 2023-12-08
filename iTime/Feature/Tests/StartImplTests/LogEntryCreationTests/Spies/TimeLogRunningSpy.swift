//
//  File.swift
//  
//
//  Created by 이상헌 on 12/8/23.
//

import Start
import RIBsTestSupport

// MARK: - TimeLogRunningBuildableMock

final class TimeLogRunningBuildableSpy: TimeLogRunningBuildable {
  
  var buildHandler: ((_ listener: TimeLogRunningListener) -> TimeLogRunningRouting)?
  
  var buildCallCount = 0
  func build(withListener listener: Start.TimeLogRunningListener) -> Start.TimeLogRunningRouting {
    
    if let buildHandler = buildHandler {
      return buildHandler(listener)
    }
    
    fatalError()
  }
}

// MARK: - TimeLogRunningRoutingMock

final class TimeLogRunningRoutingSpy:
  ViewableRoutingMock,
  TimeLogRunningRouting {
  
}
