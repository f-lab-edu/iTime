//
//  LogEntryEditorInterface.swift
//  
//
//  Created by 이상헌 on 11/13/23.
//

import RIBs

import Start

// MARK: - LogEntryEditorBuildable

public protocol LogEntryEditorBuildable: Buildable {
    func build(withListener listener: LogEntryEditorListener) -> LogEntryEditorRouting
}

// MARK: - LogEntryEditorRouting

public protocol LogEntryEditorRouting: ViewableRouting {
  func attachCategoryEditorRIB(with categoryTitle: String)
  func detachCategoryEditorRIB()
}

// MARK: - LogEntryEditorListener

public protocol LogEntryEditorListener: AnyObject {
  func attachTimeLogRunningRIB()
  func detachLogEntryEditorRIB()
}

