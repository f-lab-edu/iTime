//
//  CurrentActivityBuilder.swift
//  
//
//  Created by 이상헌 on 12/17/23.
//

import RIBs

import Start

// MARK: - CurrentActivityDependency

public protocol CurrentActivityDependency: Dependency {
  
}

// MARK: - CurrentActivityComponent

final class CurrentActivityComponent: Component<CurrentActivityDependency> {
  
}

// MARK: - CurrentActivityBuilder

public final class CurrentActivityBuilder:
  Builder<CurrentActivityDependency>,
  CurrentActivityBuildable
{
  
  public override init(dependency: CurrentActivityDependency) {
    super.init(dependency: dependency)
  }
  
  public func build(withListener listener: CurrentActivityListener) -> CurrentActivityRouting {
    let component = CurrentActivityComponent(dependency: dependency)
    let viewController = CurrentActivityViewController()
    let interactor = CurrentActivityInteractor(presenter: viewController)
    interactor.listener = listener
    return CurrentActivityRouter(
      interactor: interactor,
      viewController: viewController
    )
  }
}
