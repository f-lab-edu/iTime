//
//  File.swift
//  
//
//  Created by 이상헌 on 2023/11/03.
//

import RIBs

// MARK: - Builder

public protocol StartBuildable: Buildable {
    func build(withListener listener: StartListener) -> StartRouting
}

// MARK: - StartRouting

public protocol StartRouting: Routing {
  func cleanupViews()
}

// MARK: - StartListener

public protocol StartListener: AnyObject {
  
}
