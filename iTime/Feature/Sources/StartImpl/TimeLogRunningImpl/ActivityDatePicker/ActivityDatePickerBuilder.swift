//
//  ActivityDatePickerBuilder.swift
//  
//
//  Created by 이상헌 on 12/17/23.
//

import RIBs

import Start

// MARK: - ActivityDatePickerDependency

public protocol ActivityDatePickerDependency: Dependency {
  
}

// MARK: - ActivityDatePickerComponent

final class ActivityDatePickerComponent: Component<ActivityDatePickerDependency> {
  
}

// MARK: - ActivityDatePickerBuilder

public final class ActivityDatePickerBuilder:
  Builder<ActivityDatePickerDependency>,
  ActivityDatePickerBuildable
{
  
  public override init(dependency: ActivityDatePickerDependency) {
    super.init(dependency: dependency)
  }
  
  public func build(withListener listener: ActivityDatePickerListener) -> ActivityDatePickerRouting {
    let component = ActivityDatePickerComponent(dependency: dependency)
    let viewController = ActivityDatePickerViewController()
    let interactor = ActivityDatePickerInteractor(presenter: viewController)
    interactor.listener = listener
    return ActivityDatePickerRouter(
      interactor: interactor,
      viewController: viewController
    )
  }
}
