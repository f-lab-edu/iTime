//
//  LoggingRetentionInterface.swift
//  
//
//  Created by 이상헌 on 12/10/23.
//

import RIBs

// MARK: - LoggingRetentionBuildable

public protocol LoggingRetentionBuildable: Buildable {
    func build(withListener listener: LoggingRetentionListener) -> LoggingRetentionRouting
}

// MARK: - LoggingRetentionRouting

public protocol LoggingRetentionRouting: ViewableRouting {
}

// MARK: - LoggingRetentionListener

public protocol LoggingRetentionListener: AnyObject {
}

