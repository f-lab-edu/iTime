//
//  File.swift
//  
//
//  Created by 이상헌 on 2023/10/26.
//

import RIBs

// MARK: - LoggedOutRouting

public protocol LoggedOutRouting: ViewableRouting {}

// MARK: - LoggedOutListener

public protocol LoggedOutListener: AnyObject {}

// MARK: - LoggedOutBuildDependency

public struct LoggedOutBuildDependency {
    public let listener: LoggedOutListener
    
    public init(listener: LoggedOutListener) {
        self.listener = listener
    }
}

// MARK: - LoggedOutBuildable

public protocol LoggedOutBuildable: Buildable {
    func build(with listener: LoggedOutListener) -> LoggedOutRouting
}
