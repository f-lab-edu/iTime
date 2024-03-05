//
//  CategoryEditorInterface.swift
//  
//
//  Created by 이상헌 on 11/25/23.
//

import RIBs

import Entities

// MARK: - CategoryEditorBuildable

public protocol CategoryEditorBuildable: Buildable {
  func build(with listener: CategoryEditorListener, category: Category) -> CategoryEditorRouting
}

// MARK: - CategoryEditorRouting

public protocol CategoryEditorRouting: ViewableRouting {
  func attachCategoryCreationRIB()
}

// MARK: - CategoryEditorListener

public protocol CategoryEditorListener: AnyObject {
  func detachCategoryEditorRIB()
}

