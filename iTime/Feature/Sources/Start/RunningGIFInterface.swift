//
//  RunningGIFInterface.swift
//  
//
//  Created by 이상헌 on 12/31/23.
//

import RIBs

// MARK: - RunningGIFBuildable

public protocol RunningGIFBuildable: Buildable {
    func build(withListener listener: RunningGIFListener) -> RunningGIFRouting
}

// MARK: - RunningGIFRouting

public protocol RunningGIFRouting: ViewableRouting {
}

// MARK: - RunningGIFListener

public protocol RunningGIFListener: AnyObject {
}

