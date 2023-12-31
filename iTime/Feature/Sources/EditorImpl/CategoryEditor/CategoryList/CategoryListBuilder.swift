//
//  CategoryListBuilder.swift
//  
//
//  Created by 이상헌 on 12/31/23.
//

import RIBs

import CategoryList

// MARK: - CategoryListDependency

public protocol CategoryListDependency: Dependency {
  
}

// MARK: - CategoryListComponent

final class CategoryListComponent: Component<CategoryListDependency> {
  
}

// MARK: - CategoryListBuilder

public final class CategoryListBuilder:
  Builder<CategoryListDependency>,
  CategoryListBuildable
{
  
  public override init(dependency: CategoryListDependency) {
    super.init(dependency: dependency)
  }
  
  public func build(withListener listener: CategoryListListener) -> CategoryListRouting {
    let component = CategoryListComponent(dependency: dependency)
    let viewController = CategoryListViewController()
    let interactor = CategoryListInteractor(presenter: viewController)
    interactor.listener = listener
    return CategoryListRouter(
      interactor: interactor,
      viewController: viewController
    )
  }
}
