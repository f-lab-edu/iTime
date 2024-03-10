//
//  CategoryModificationInterface.swift
//  
//
//  Created by 이상헌 on 3/10/24.
//

import RIBs

// MARK: - CategoryModificationBuildable

public protocol CategoryModificationBuildable: Buildable {
    func build(withListener listener: CategoryModificationListener) -> CategoryModificationRouting
}

// MARK: - CategoryModificationRouting

public protocol CategoryModificationRouting: ViewableRouting {
}

// MARK: - CategoryModificationListener

public protocol CategoryModificationListener: AnyObject {
  func detachCategoryModificationRIB()
}

