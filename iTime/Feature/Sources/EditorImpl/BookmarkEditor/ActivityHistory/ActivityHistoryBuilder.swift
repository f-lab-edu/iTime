//
//  ActivityHistoryBuilder.swift
//  
//
//  Created by 이상헌 on 12/10/23.
//

import RIBs

import Editor

// MARK: - ActivityHistoryDependency

public protocol ActivityHistoryDependency: Dependency {
  
}

// MARK: - ActivityHistoryComponent

final class ActivityHistoryComponent: Component<ActivityHistoryDependency> {
  
}

// MARK: - ActivityHistoryBuilder

public final class ActivityHistoryBuilder:
  Builder<ActivityHistoryDependency>,
  ActivityHistoryBuildable
{
  
  public override init(dependency: ActivityHistoryDependency) {
    super.init(dependency: dependency)
  }
  
  public func build(withListener listener: ActivityHistoryListener) -> ActivityHistoryRouting {
    let component = ActivityHistoryComponent(dependency: dependency)
    let viewController = ActivityHistoryViewController()
    let interactor = ActivityHistoryInteractor(presenter: viewController)
    interactor.listener = listener
    return ActivityHistoryRouter(
      interactor: interactor,
      viewController: viewController
    )
  }
}
