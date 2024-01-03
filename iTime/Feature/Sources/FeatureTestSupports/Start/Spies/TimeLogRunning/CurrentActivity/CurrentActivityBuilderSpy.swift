//
//  CurrentActivityBuilderSpy.swift
//  
//
//  Created by 이상헌 on 1/2/24.
//

import Start

public final class CurrentActivityBuilderSpy: CurrentActivityBuildable {
  
  public var buildHandler: ((_ listener: CurrentActivityListener) -> CurrentActivityRouting)?
  
  public var buildCallCount: Int = 0
  public func build(withListener listener: Start.CurrentActivityListener) -> Start.CurrentActivityRouting {
    buildCallCount += 1
    if let buildHandler = buildHandler {
      return buildHandler(listener)
    }
    
    fatalError()
  }
  
  public init() {}
}
