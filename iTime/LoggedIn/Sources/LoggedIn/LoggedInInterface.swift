//
//  File.swift
//  
//
//  Created by 이상헌 on 2023/11/02.
//

import RIBs

// MARK: - LoggedInRouting

public protocol LoggedInRouting: ViewableRouting {
}

// MARK: - LoggedInListener

public protocol LoggedInListener: AnyObject {
}

// MARK: - LoggedInBuildable

public protocol LoggedInBuildable: Buildable {
    func build(withListener listener: LoggedInListener) -> LoggedInRouting
}
