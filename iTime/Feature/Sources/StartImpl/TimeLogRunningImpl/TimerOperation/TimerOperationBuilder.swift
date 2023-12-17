//
//  TimerOperationBuilder.swift
//  
//
//  Created by 이상헌 on 12/17/23.
//

import RIBs

import Start

// MARK: - TimerOperationDependency

public protocol TimerOperationDependency: Dependency {
  
}

// MARK: - TimerOperationComponent

final class TimerOperationComponent: Component<TimerOperationDependency> {
  
}

// MARK: - TimerOperationBuilder

public final class TimerOperationBuilder:
  Builder<TimerOperationDependency>,
  TimerOperationBuildable
{
  
  public override init(dependency: TimerOperationDependency) {
    super.init(dependency: dependency)
  }
  
  public func build(withListener listener: TimerOperationListener) -> TimerOperationRouting {
    let component = TimerOperationComponent(dependency: dependency)
    let viewController = TimerOperationViewController()
    let interactor = TimerOperationInteractor(presenter: viewController)
    interactor.listener = listener
    return TimerOperationRouter(
      interactor: interactor,
      viewController: viewController
    )
  }
}
