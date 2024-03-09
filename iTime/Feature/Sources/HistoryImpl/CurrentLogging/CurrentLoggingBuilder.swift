//
//  CurrentLoggingBuilder.swift
//  
//
//  Created by 이상헌 on 12/31/23.
//

import RIBs

import History

// MARK: - CurrentLoggingDependency

public protocol CurrentLoggingDependency: Dependency {
  
}

// MARK: - CurrentLoggingComponent

final class CurrentLoggingComponent: Component<CurrentLoggingDependency> {
  
}

// MARK: - CurrentLoggingBuilder

public final class CurrentLoggingBuilder:
  Builder<CurrentLoggingDependency>,
  CurrentLoggingBuildable
{
  
  public override init(dependency: CurrentLoggingDependency) {
    super.init(dependency: dependency)
  }
  
  public func build(withListener listener: CurrentLoggingListener) -> CurrentLoggingRouting {
    _ = CurrentLoggingComponent(dependency: dependency)
    let viewController = CurrentLoggingViewController()
    let interactor = CurrentLoggingInteractor(presenter: viewController)
    interactor.listener = listener
    return CurrentLoggingRouter(
      interactor: interactor,
      viewController: viewController
    )
  }
}
