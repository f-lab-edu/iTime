//
//  CurrentTimerTimeInterface.swift
//  
//
//  Created by 이상헌 on 12/17/23.
//

import RIBs

// MARK: - CurrentTimerTimeBuildable

public protocol CurrentTimerTimeBuildable: Buildable {
    func build(withListener listener: CurrentTimerTimeListener) -> CurrentTimerTimeRouting
}

// MARK: - CurrentTimerTimeRouting

public protocol CurrentTimerTimeRouting: ViewableRouting {
}

// MARK: - CurrentTimerTimeListener

public protocol CurrentTimerTimeListener: AnyObject {
}

