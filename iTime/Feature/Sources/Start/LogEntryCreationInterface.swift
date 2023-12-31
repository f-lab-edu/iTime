//
//  File.swift
//
//
//  Created by 이상헌 on 2023/11/05.
//

import RIBs

// MARK: - LogEntryCreationBuildable

public protocol LogEntryCreationBuildable: Buildable {
    func build(withListener listener: LogEntryCreationListener) -> LogEntryCreationRouting
}

// MARK: - LogEntryCreationRouting

public protocol LogEntryCreationRouting: ViewableRouting {
  func attachLogEntryEditorRIB()
  func detachLogEntryEditorRIB()
  func attachTimeLogRunningRIB()
  func detachTimeLogRunningRIB()
  func attachBookmarkEditorRIB()
  func detachBookmarkEditorRIB()
}

// MARK: - LogEntryCreationListener

public protocol LogEntryCreationListener: AnyObject {
}
