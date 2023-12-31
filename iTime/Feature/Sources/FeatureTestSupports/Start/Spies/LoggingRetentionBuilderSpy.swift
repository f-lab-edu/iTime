//
//  File.swift
//  
//
//  Created by 이상헌 on 12/31/23.
//

import Start
import RIBsTestSupport

public class LoggingRetentionBuilderSpy: LoggingRetentionBuildable {
  
  public var buildHandler: ((_ listener: LoggingRetentionListener) -> LoggingRetentionRouting)?
  
  public func build(withListener listener: Start.LoggingRetentionListener) -> Start.LoggingRetentionRouting {
    if let buildHandler = buildHandler {
      return buildHandler(listener)
    }
    
    fatalError()
  }
  
  public init() {}
}
