//
//  CategoryListBuilder.swift
//  
//
//  Created by 이상헌 on 12/31/23.
//

import RIBs

import Entities
import Editor

// MARK: - CategoryListDependency

public protocol CategoryListDependency: Dependency {
  var timeLogRecordModelDataStream: TimeLogRecordModelDataStream { get }
}

// MARK: - CategoryListComponent

final class CategoryListComponent: Component<CategoryListDependency> {
  fileprivate let initialState: CategoryListState = CategoryListState()
  
  fileprivate var timeLogRecordModelDataStream: TimeLogRecordModelDataStream {
    dependency.timeLogRecordModelDataStream
  }
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
    let interactor = CategoryListInteractor(
      initialState: .init(value: component.initialState),
      presenter: viewController,
      timeLogRecordModelDataStream: component.timeLogRecordModelDataStream
    )
    interactor.listener = listener
    return CategoryListRouter(
      interactor: interactor,
      viewController: viewController
    )
  }
}
