//
//  TimerOperationInterface.swift
//  
//
//  Created by 이상헌 on 12/17/23.
//

import RIBs

// MARK: - TimerOperationBuildable

public protocol TimerOperationBuildable: Buildable {
    func build(withListener listener: TimerOperationListener) -> TimerOperationRouting
}

// MARK: - TimerOperationRouting

public protocol TimerOperationRouting: ViewableRouting {
}

// MARK: - TimerOperationListener

public protocol TimerOperationListener: AnyObject {
  func detachTimeLogRunningRIB()
}

