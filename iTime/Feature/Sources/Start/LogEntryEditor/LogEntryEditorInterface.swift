//
//  LogEntryEditorInterface.swift
//  
//
//  Created by 이상헌 on 11/13/23.
//

import RIBs

// MARK: - LogEntryEditorBuildable

public protocol LogEntryEditorBuildable: Buildable {
    func build(withListener listener: LogEntryEditorListener) -> LogEntryEditorRouting
}

// MARK: - LogEntryEditorRouting

public protocol LogEntryEditorRouting: ViewableRouting {
}

// MARK: - LogEntryEditorListener

public protocol LogEntryEditorListener: AnyObject {
}

