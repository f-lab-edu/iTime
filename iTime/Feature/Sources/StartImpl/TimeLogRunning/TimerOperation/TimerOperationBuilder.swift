//
//  TimerOperationBuilder.swift
//
//
//  Created by 이상헌 on 12/17/23.
//

import RIBs

import Usecase
import Start

// MARK: - TimerOperationDependency

public protocol TimerOperationDependency: Dependency {
  var timerUsecase: TimerUsecase { get }
  var activityLogModelStream: ActivityLogModelStream { get }
}

// MARK: - TimerOperationComponent

final class TimerOperationComponent: Component<TimerOperationDependency> {
  fileprivate var timerUsecase: TimerUsecase {
    dependency.timerUsecase
  }
  
  fileprivate var activityLogModelStream: ActivityLogModelStream {
    dependency.activityLogModelStream
  }
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
    let interactor = TimerOperationInteractor(
      presenter: viewController,
      timerUsecase: component.timerUsecase,
      activityLogModelStream: component.activityLogModelStream
    )
    interactor.listener = listener
    return TimerOperationRouter(
      interactor: interactor,
      viewController: viewController
    )
  }
}
