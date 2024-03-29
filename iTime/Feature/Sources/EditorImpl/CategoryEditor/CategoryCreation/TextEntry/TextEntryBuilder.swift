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
  
}

// MARK: - TextEntryBuilder

public final class TextEntryBuilder:
  Builder<TextEntryDependency>,
  TextEntryBuildable
{
  
  public override init(dependency: TextEntryDependency) {
    super.init(dependency: dependency)
  }
  
  public func build(withListener listener: TextEntryListener) -> TextEntryRouting {
    let _ = TextEntryComponent(dependency: dependency)
    let viewController = TextEntryViewController()
    let interactor = TextEntryInteractor(presenter: viewController)
    interactor.listener = listener
    return TextEntryRouter(
      interactor: interactor,
      viewController: viewController
    )
  }
}
