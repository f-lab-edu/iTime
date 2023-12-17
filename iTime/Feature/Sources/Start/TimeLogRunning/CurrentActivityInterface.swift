//
//  CurrentActivityInterface.swift
//  
//
//  Created by 이상헌 on 12/17/23.
//

import RIBs

// MARK: - CurrentActivityBuildable

public protocol CurrentActivityBuildable: Buildable {
    func build(withListener listener: CurrentActivityListener) -> CurrentActivityRouting
}

// MARK: - CurrentActivityRouting

public protocol CurrentActivityRouting: ViewableRouting {
}

// MARK: - CurrentActivityListener

public protocol CurrentActivityListener: AnyObject {
}

