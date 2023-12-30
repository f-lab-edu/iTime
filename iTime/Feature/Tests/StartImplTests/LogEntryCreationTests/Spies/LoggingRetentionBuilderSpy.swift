//
//  File.swift
//  
//
//  Created by 이상헌 on 12/31/23.
//

import Start
import RIBsTestSupport

class LoggingRetentionBuilderSpy: LoggingRetentionBuildable {
  
  var buildHandler: ((_ listener: LoggingRetentionListener) -> LoggingRetentionRouting)?
  
  func build(withListener listener: Start.LoggingRetentionListener) -> Start.LoggingRetentionRouting {
    if let buildHandler = buildHandler {
      return buildHandler(listener)
    }
    
    fatalError()
  }
  
  
}
