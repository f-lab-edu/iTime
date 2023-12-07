//
//  HistoryInterface.swift
//  
//
//  Created by 이상헌 on 12/7/23.
//

import RIBs

// MARK: - HistoryBuildable

public protocol HistoryBuildable: Buildable {
    func build(withListener listener: HistoryListener) -> HistoryRouting
}

// MARK: - HistoryRouting

public protocol HistoryRouting: ViewableRouting {
}

// MARK: - HistoryListener

public protocol HistoryListener: AnyObject {
}

