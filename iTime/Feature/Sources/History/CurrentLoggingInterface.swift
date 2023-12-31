//
//  CurrentLoggingInterface.swift
//  
//
//  Created by 이상헌 on 12/31/23.
//

import RIBs

// MARK: - CurrentLoggingBuildable

public protocol CurrentLoggingBuildable: Buildable {
    func build(withListener listener: CurrentLoggingListener) -> CurrentLoggingRouting
}

// MARK: - CurrentLoggingRouting

public protocol CurrentLoggingRouting: ViewableRouting {
}

// MARK: - CurrentLoggingListener

public protocol CurrentLoggingListener: AnyObject {
}

