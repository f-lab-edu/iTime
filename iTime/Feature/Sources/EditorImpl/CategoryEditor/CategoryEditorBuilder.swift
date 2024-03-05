//
//  CategoryEditorBuilder.swift
//  
//
//  Created by 이상헌 on 11/25/23.
//

import RIBs

import Editor
import Usecase
import Start

// MARK: - CategoryEditorDependency

public protocol CategoryEditorDependency: Dependency {
  var currentActivityBuilder: CurrentActivityBuildable { get }
  var categoryListBuilder: CategoryListBuildable { get }
  var categoryCreationBuilder: CategoryCreationBuilder { get }
  var timerUsecase: TimerUsecase { get }
}

// MARK: - CategoryEditorComponentDependency

struct CategoryEditorComponentDependency {
  let categoryTitle: String
}

// MARK: - CategoryEditorComponent

final class CategoryEditorComponent: Component<CategoryEditorDependency> {
  fileprivate var initalState: CategoryEditorState {
    CategoryEditorState(categoryTitle: self.payload.categoryTitle)
  }
  
  fileprivate var timerUsecase: TimerUsecase {
    dependency.timerUsecase
  }
  
  fileprivate var currentActivityBuilder: CurrentActivityBuildable {
    dependency.currentActivityBuilder
  }
  
  fileprivate var categoryListBuilder: CategoryListBuildable {
    dependency.categoryListBuilder
  }
  
  fileprivate var categoryCreationBuilder: CategoryCreationBuilder {
    dependency.categoryCreationBuilder
  }
  
  private let payload: CategoryEditorComponentDependency
  
  public init(
    dependency: CategoryEditorDependency,
    payload: CategoryEditorComponentDependency
  ) {
    self.payload = payload
    super.init(dependency: dependency)
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
  
  public func build(with listener: CategoryEditorListener, title: String) -> CategoryEditorRouting {
    let component = CategoryEditorComponent(dependency: dependency, payload: .init(categoryTitle: title))
    let viewController = CategoryEditorViewController()
    let interactor = CategoryEditorInteractor(
      initialState: component.initalState,
      timerUsecase: component.timerUsecase,
      presenter: viewController
    )
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
