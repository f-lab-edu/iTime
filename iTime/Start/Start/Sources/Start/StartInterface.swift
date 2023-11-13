//
//  StartInterface.swift
//  
//
//  Created by 이상헌 on 11/11/23.
//

import RIBs

// MARK: - StartBuildable

public protocol StartBuildable: Buildable {
    func build(withListener listener: StartListener) -> StartRouting
}

// MARK: - StartRouting

public protocol StartRouting: ViewableRouting {
  func attachLogEntryCreationRIB()
  func detachLogEntryCreationRIB()
}

// MARK: - StartListener

public protocol StartListener: AnyObject {
}

