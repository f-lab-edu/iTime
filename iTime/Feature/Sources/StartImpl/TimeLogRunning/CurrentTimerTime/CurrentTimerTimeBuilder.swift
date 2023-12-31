//
//  CurrentTimerTimeBuilder.swift
//  
//
//  Created by 이상헌 on 12/17/23.
//

import RIBs

import Entities
import Start

// MARK: - CurrentTimerTimeDependency

public protocol CurrentTimerTimeDependency: Dependency {
  var timerInfoModelDataStream: TimerInfoModelDataStream { get }
}

// MARK: - CurrentTimerTimeComponent

final class CurrentTimerTimeComponent: Component<CurrentTimerTimeDependency> {
  fileprivate var timerInfoModelDataStream: TimerInfoModelDataStream {
    dependency.timerInfoModelDataStream
  }
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
    let interactor = CurrentTimerTimeInteractor(
      presenter: viewController,
      timerInfoModelDataStream: component.timerInfoModelDataStream
    )
    interactor.listener = listener
    return CurrentTimerTimeRouter(
      interactor: interactor,
      viewController: viewController
    )
  }
}
