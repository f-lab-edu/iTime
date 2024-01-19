//
//  CategoryEditorBuilder.swift
//  
//
//  Created by 이상헌 on 11/25/23.
//

import RIBs

import Editor
import Start

// MARK: - CategoryEditorDependency

public protocol CategoryEditorDependency: Dependency {
  var currentActivityBuilder: CurrentActivityBuildable { get }
  var categoryListBuilder: CategoryListBuildable { get }
  var categoryCreationBuilder: CategoryCreationBuilder { get }
}

// MARK: - CategoryEditorComponent

final class CategoryEditorComponent: Component<CategoryEditorDependency> {
  fileprivate var currentActivityBuilder: CurrentActivityBuildable {
    dependency.currentActivityBuilder
  }
  
  fileprivate var categoryListBuilder: CategoryListBuildable {
    dependency.categoryListBuilder
  }
  
  fileprivate var categoryCreationBuilder: CategoryCreationBuilder {
    dependency.categoryCreationBuilder
  }
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
      viewController: viewController,
      currentActivityBuilder: component.currentActivityBuilder,
      categoryListBuilder: component.categoryListBuilder,
      categoryCreationBuilder: component.categoryCreationBuilder
    )
  }
}
