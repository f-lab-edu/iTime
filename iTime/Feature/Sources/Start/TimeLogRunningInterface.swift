//
//  TimeLogRunningInterface.swift
//  
//
//  Created by 이상헌 on 11/25/23.
//

import RIBs

// MARK: - TimeLogRunningBuildable

public protocol TimeLogRunningBuildable: Buildable {
    func build(withListener listener: TimeLogRunningListener) -> TimeLogRunningRouting
}

// MARK: - TimeLogRunningRouting

public protocol TimeLogRunningRouting: ViewableRouting {
}

// MARK: - TimeLogRunningListener

public protocol TimeLogRunningListener: AnyObject {
}

