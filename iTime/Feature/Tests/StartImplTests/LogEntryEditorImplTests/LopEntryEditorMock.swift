//
//  File.swift
//  
//
//  Created by 이상헌 on 11/19/23.
//

import Start
import RIBsTestSupport

// MARK: - LogEntryEditorBuildableMock

final class LogEntryEditorBuildableMock: LogEntryEditorBuildable {
  
  var buildHandler: ((_ listener: LogEntryEditorListener) -> LogEntryEditorRouting)?
  
  var buildCallCount = 0
  func build(withListener listener: LogEntryEditorListener) -> LogEntryEditorRouting {
    buildCallCount += 1
    
    if let buildHandler = buildHandler {
      return buildHandler(listener)
    }
    
    fatalError()
  }
}

// MARK: - LogEntryEditorRoutingMock

final class LogEntryEditorRoutingMock: ViewableRoutingMock, LogEntryEditorRouting {
}

