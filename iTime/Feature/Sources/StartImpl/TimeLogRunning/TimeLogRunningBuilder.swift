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
  var currentActivityBuilder: CurrentActivityBuildable { get }
  var currentTimerTimeBuilder: CurrentTimerTimeBuildable { get }
  var activityDatePickerBuilder: ActivityDatePickerBuildable { get }
  var timerOperationBuilder: TimerOperationBuildable { get }
}

// MARK: - TimeLogRunningComponent

final class TimeLogRunningComponent: Component<TimeLogRunningDependency> {
  fileprivate var currentActivityBuilder: CurrentActivityBuildable {
    dependency.currentActivityBuilder
  }
  
  fileprivate var currentTimerTimeBuilder: CurrentTimerTimeBuildable {
    dependency.currentTimerTimeBuilder
  }
  
  fileprivate var activityDatePickerBuilder: ActivityDatePickerBuildable {
    dependency.activityDatePickerBuilder
  }
  
  fileprivate var timerOperationBuilder: TimerOperationBuildable {
    dependency.timerOperationBuilder
  }
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
      viewController: viewController,
      currentActivityBuilder: component.currentActivityBuilder,
      currentTimerTimeBuilder: component.currentTimerTimeBuilder,
      activityDatePickerBuilder: component.activityDatePickerBuilder,
      timerOperationBuilder: component.timerOperationBuilder
    )
  }
}
