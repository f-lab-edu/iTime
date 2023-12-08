//
//  File.swift
//  
//
//  Created by 이상헌 on 11/19/23.
//

import Editor
import RIBsTestSupport

// MARK: - LogEntryEditorBuildableSpy

final class LogEntryEditorBuildableSpy: LogEntryEditorBuildable {
  
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

// MARK: - LogEntryEditorRoutingSpy

final class LogEntryEditorRoutingSpy:
  ViewableRoutingMock,
  LogEntryEditorRouting {
  func attachCategoryEditorRIB() {
    
  }
}

