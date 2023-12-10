//
//  ActivityHistoryInterface.swift
//  
//
//  Created by 이상헌 on 12/10/23.
//

import RIBs

// MARK: - ActivityHistoryBuildable

public protocol ActivityHistoryBuildable: Buildable {
    func build(withListener listener: ActivityHistoryListener) -> ActivityHistoryRouting
}

// MARK: - ActivityHistoryRouting

public protocol ActivityHistoryRouting: ViewableRouting {
}

// MARK: - ActivityHistoryListener

public protocol ActivityHistoryListener: AnyObject {
}

