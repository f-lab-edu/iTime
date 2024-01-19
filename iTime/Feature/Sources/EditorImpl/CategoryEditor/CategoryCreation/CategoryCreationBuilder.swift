//
//  CategoryCreationBuilder.swift
//  
//
//  Created by 이상헌 on 12/7/23.
//

import RIBs

import Editor

// MARK: - CategoryCreationDependency

public protocol CategoryCreationDependency: Dependency {
  var textEntryBuilder: TextEntryBuildable { get }
  var colorPickerBuilder: ColorPickerBuildable { get }
}

// MARK: - CategoryCreationComponent

final class CategoryCreationComponent: Component<CategoryCreationDependency> {
  fileprivate var textEntryBuilder: TextEntryBuildable {
    dependency.textEntryBuilder
  }
  
  fileprivate var colorPickerbuilder: ColorPickerBuildable {
    dependency.colorPickerBuilder
  }
}

// MARK: - CategoryCreationBuilder

public final class CategoryCreationBuilder:
  Builder<CategoryCreationDependency>,
  CategoryCreationBuildable
{
  
  public override init(dependency: CategoryCreationDependency) {
    super.init(dependency: dependency)
  }
  
  public func build(withListener listener: CategoryCreationListener) -> CategoryCreationRouting {
    let component = CategoryCreationComponent(dependency: dependency)
    let viewController = CategoryCreationViewController()
    let interactor = CategoryCreationInteractor(presenter: viewController)
    interactor.listener = listener
    return CategoryCreationRouter(
      interactor: interactor,
      viewController: viewController,
      textEntryBuilder: component.textEntryBuilder,
      colorPickerBuilder: component.colorPickerbuilder
    )
  }
}
