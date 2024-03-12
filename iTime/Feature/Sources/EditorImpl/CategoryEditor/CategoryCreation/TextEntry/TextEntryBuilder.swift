//
//  TextEntryBuilder.swift
//  
//
//  Created by 이상헌 on 12/31/23.
//

import RIBs

import Editor

// MARK: - TextEntryDependency

public protocol TextEntryDependency: Dependency {
  
}

// MARK: - TextEntryComponent

final class TextEntryComponent: Component<TextEntryDependency> {
  fileprivate var intialState: TextEntryState {
    .init(currentCategoryText: String())
  }
  
  private let payload: TextEntryComponentDependency
  
  public init(
    dependency: TextEntryDependency,
    payload: TextEntryComponentDependency
  ) {
    self.payload = payload
    super.init(dependency: dependency)
  }
  
}

// MARK: - TextEntryBuilder

public final class TextEntryBuilder:
  Builder<TextEntryDependency>,
  TextEntryBuildable
{
  
  public override init(dependency: TextEntryDependency) {
    super.init(dependency: dependency)
  }
  
  public func build(
    withListener listener: TextEntryListener,
    payload: TextEntryComponentDependency
  ) -> TextEntryRouting {
    let component = TextEntryComponent(
      dependency: dependency,
      payload: payload
    )
    let viewController = TextEntryViewController()
    let interactor = TextEntryInteractor(
      initalState: component.intialState,
      presenter: viewController
    )
    interactor.listener = listener
    return TextEntryRouter(
      interactor: interactor,
      viewController: viewController
    )
  }
}
