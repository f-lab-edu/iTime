//
//  CategoryListInterface.swift
//  
//
//  Created by 이상헌 on 12/31/23.
//

import RIBs

// MARK: - CategoryListBuildable

public protocol CategoryListBuildable: Buildable {
    func build(withListener listener: CategoryListListener) -> CategoryListRouting
}

// MARK: - CategoryListRouting

public protocol CategoryListRouting: ViewableRouting {
}

// MARK: - CategoryListListener

public protocol CategoryListListener: AnyObject {
  func didTapCategoryCreationLabel()
}

