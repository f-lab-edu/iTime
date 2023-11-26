//
//  File.swift
//  
//
//  Created by 이상헌 on 11/26/23.
//

import RIBs

// MARK: - AppRootBuildable

public protocol AppRootBuildable: Buildable {
  func build() -> LaunchRouting
}

// MARK: - AppRootRouting

public  protocol AppRootRouting: ViewableRouting {
  func attachLoggedOut()
  func detachLoggedOut(_ completion: (() -> Void)?)
  func attachLoggedIn()
  func detachLoggedIn()
}

// MARK: - AppRootListener

public protocol AppRootListener: AnyObject {
}
