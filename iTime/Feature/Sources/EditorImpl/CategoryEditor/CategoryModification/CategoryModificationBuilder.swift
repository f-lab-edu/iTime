//
//  CategoryModificationBuilder.swift
//  
//
//  Created by 이상헌 on 3/10/24.
//

import RIBs

import Editor

// MARK: - CategoryModificationDependency

public protocol CategoryModificationDependency: Dependency {
  var textEntryBuilder: TextEntryBuildable { get }
  var colorPickerBuilder: ColorPickerBuildable { get }
}

// MARK: - CategoryModificationComponent

final class CategoryModificationComponent: Component<CategoryModificationDependency> {
  fileprivate var initialState: CategoryCreationState = .init(categoryText: String(), selectedColor: String())
  
  fileprivate var textEntryBuilder: TextEntryBuildable {
    dependency.textEntryBuilder
  }
  
  fileprivate var colorPickerbuilder: ColorPickerBuildable {
    dependency.colorPickerBuilder
  }
}

// MARK: - CategoryModificationBuilder

public final class CategoryModificationBuilder:
  Builder<CategoryModificationDependency>,
  CategoryModificationBuildable
{
  
  public override init(dependency: CategoryModificationDependency) {
    super.init(dependency: dependency)
  }
  
  public func build(withListener listener: CategoryModificationListener) -> CategoryModificationRouting {
    let component = CategoryModificationComponent(dependency: dependency)
    let viewController = CategoryModificationViewController()
    let interactor = CategoryModificationInteractor(presenter: viewController)
    interactor.listener = listener
    return CategoryModificationRouter(
      interactor: interactor,
      viewController: viewController,
      textEntryBuilder: component.textEntryBuilder,
      colorPickerBuilder: component.colorPickerbuilder
    )
  }
}
