//
//  File.swift
//  
//
//  Created by 이상헌 on 11/19/23.
//

import Editor
import RIBsTestSupport

// MARK: - LogEntryEditorBuildableSpy

public final class LogEntryEditorBuildableSpy: LogEntryEditorBuildable {
  
  public var buildHandler: ((_ listener: LogEntryEditorListener) -> LogEntryEditorRouting)?
  
  public var buildCallCount = 0
  public func build(withListener listener: LogEntryEditorListener) -> LogEntryEditorRouting {
    buildCallCount += 1
    
    if let buildHandler = buildHandler {
      return buildHandler(listener)
    }
    
    fatalError()
  }
  
  public init() {}
}

// MARK: - LogEntryEditorRoutingSpy

public final class LogEntryEditorRoutingSpy:
  ViewableRoutingMock,
  LogEntryEditorRouting {
  public var detachCategoryEditorRIBCallCount: Int = 0
  public func detachCategoryEditorRIB() {
    detachCategoryEditorRIBCallCount += 1
  }
  
  public var attachCategoryEditorRIBCallCount: Int = 0
  public func attachCategoryEditorRIB() {
    attachCategoryEditorRIBCallCount += 1
  }
}

