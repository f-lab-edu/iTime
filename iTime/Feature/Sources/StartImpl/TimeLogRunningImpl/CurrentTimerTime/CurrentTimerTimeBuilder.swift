//
//  CurrentTimerTimeBuilder.swift
//  
//
//  Created by 이상헌 on 12/17/23.
//

import RIBs

import Start

// MARK: - CurrentTimerTimeDependency

public protocol CurrentTimerTimeDependency: Dependency {
  
}

// MARK: - CurrentTimerTimeComponent

final class CurrentTimerTimeComponent: Component<CurrentTimerTimeDependency> {
  
}

// MARK: - CurrentTimerTimeBuilder

public final class CurrentTimerTimeBuilder:
  Builder<CurrentTimerTimeDependency>,
  CurrentTimerTimeBuildable
{
  
  public override init(dependency: CurrentTimerTimeDependency) {
    super.init(dependency: dependency)
  }
  
  public func build(withListener listener: CurrentTimerTimeListener) -> CurrentTimerTimeRouting {
    let component = CurrentTimerTimeComponent(dependency: dependency)
    let viewController = CurrentTimerTimeViewController()
    let interactor = CurrentTimerTimeInteractor(presenter: viewController)
    interactor.listener = listener
    return CurrentTimerTimeRouter(
      interactor: interactor,
      viewController: viewController
    )
  }
}
