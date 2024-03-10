//
//  CategoryCreationInterface.swift
//  
//
//  Created by 이상헌 on 12/7/23.
//

import RIBs

// MARK: - CategoryCreationBuildable

public protocol CategoryCreationBuildable: Buildable {
    func build(withListener listener: CategoryCreationListener) -> CategoryCreationRouting
}

// MARK: - CategoryCreationRouting

public protocol CategoryCreationRouting: ViewableRouting {
}

// MARK: - CategoryCreationListener

public protocol CategoryCreationListener: AnyObject {
  func detachCategoryCreationRIB()
}

