//
//  CategoryBottomSheetBuilder.swift
//  
//
//  Created by 이상헌 on 11/25/23.
//

import RIBs

import Start

// MARK: - CategoryBottomSheetDependency

public protocol CategoryBottomSheetDependency: Dependency {
  
}

// MARK: - CategoryBottomSheetComponent

final class CategoryBottomSheetComponent: Component<CategoryBottomSheetDependency> {
  
}

// MARK: - CategoryBottomSheetBuilder

public final class CategoryBottomSheetBuilder:
  Builder<CategoryBottomSheetDependency>,
  CategoryBottomSheetBuildable
{
  
  public override init(dependency: CategoryBottomSheetDependency) {
    super.init(dependency: dependency)
  }
  
  public func build(withListener listener: CategoryBottomSheetListener) -> CategoryBottomSheetRouting {
    let component = CategoryBottomSheetComponent(dependency: dependency)
    let viewController = CategoryBottomSheetViewController()
    let interactor = CategoryBottomSheetInteractor(presenter: viewController)
    interactor.listener = listener
    return CategoryBottomSheetRouter(
      interactor: interactor,
      viewController: viewController
    )
  }
}
