//
//  CategoryEditorBuilder.swift
//  
//
//  Created by 이상헌 on 11/25/23.
//

import RIBs

import Editor

// MARK: - CategoryEditorDependency

public protocol CategoryEditorDependency: Dependency {
  
}

// MARK: - CategoryEditorComponent

final class CategoryEditorComponent: Component<CategoryEditorDependency> {
  
}

// MARK: - CategoryEditorBuilder

public final class CategoryEditorBuilder:
  Builder<CategoryEditorDependency>,
  CategoryEditorBuildable
{
  
  public override init(dependency: CategoryEditorDependency) {
    super.init(dependency: dependency)
  }
  
  public func build(withListener listener: CategoryEditorListener) -> CategoryEditorRouting {
    let component = CategoryEditorComponent(dependency: dependency)
    let viewController = CategoryEditorViewController()
    let interactor = CategoryEditorInteractor(presenter: viewController)
    interactor.listener = listener
    return CategoryEditorRouter(
      interactor: interactor,
      viewController: viewController
    )
  }
}
