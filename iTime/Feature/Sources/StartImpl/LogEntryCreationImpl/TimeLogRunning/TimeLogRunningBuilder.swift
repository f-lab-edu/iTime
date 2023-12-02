//
//  TimeLogRunningBuilder.swift
//  
//
//  Created by 이상헌 on 11/25/23.
//

import RIBs

import Start
import AppFoundation

// FIXME: TimeRunning 별도 모듈 분리 필요...!

// MARK: - TimeLogRunningDependency

public protocol TimeLogRunningDependency: Dependency {
  var timeFormatter: TimeFormatter { get }
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
    let _ = TimeLogRunningComponent(dependency: dependency)
    let viewController = TimeLogRunningViewController(timeFormatter: dependency.timeFormatter)
    let interactor = TimeLogRunningInteractor(presenter: viewController)
    interactor.listener = listener
    return TimeLogRunningRouter(
      interactor: interactor,
      viewController: viewController
    )
  }
}
