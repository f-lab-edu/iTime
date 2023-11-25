//
//  TimeLogRunningBuilder.swift
//  
//
//  Created by 이상헌 on 11/25/23.
//

import RIBs

import Start

// MARK: - TimeLogRunningDependency

public protocol TimeLogRunningDependency: Dependency {
  
}

// MARK: - TimeLogRunningComponent

final class TimeLogRunningComponent: Component<TimeLogRunningDependency> {
  
}

// MARK: - TimeLogRunningBuilder

public final class TimeLogRunningBuilder:
  Builder<TimeLogRunningDependency>,
  TimeLogRunningBuildable
{
  
  public override init(dependency: TimeLogRunningDependency) {
    super.init(dependency: dependency)
  }
  
  public func build(withListener listener: TimeLogRunningListener) -> TimeLogRunningRouting {
    let component = TimeLogRunningComponent(dependency: dependency)
    let viewController = TimeLogRunningViewController()
    let interactor = TimeLogRunningInteractor(presenter: viewController)
    interactor.listener = listener
    return TimeLogRunningRouter(
      interactor: interactor,
      viewController: viewController
    )
  }
}
