//
//  CurrentActivityBuilder.swift
//  
//
//  Created by 이상헌 on 12/17/23.
//

import RIBs

import Start

// MARK: - CurrentActivityDependency

public protocol CurrentActivityDependency: Dependency {
  var activityLogModelStream: ActivityLogModelStream { get }
}

// MARK: - CurrentActivityComponent

final class CurrentActivityComponent: Component<CurrentActivityDependency> {
  fileprivate var activityLogModelStream: ActivityLogModelStream {
    dependency.activityLogModelStream
  }
}

// MARK: - CurrentActivityBuilder

public final class CurrentActivityBuilder:
  Builder<CurrentActivityDependency>,
  CurrentActivityBuildable
{
  
  public override init(dependency: CurrentActivityDependency) {
    super.init(dependency: dependency)
  }
  
  public func build(withListener listener: CurrentActivityListener) -> CurrentActivityRouting {
    let component = CurrentActivityComponent(dependency: dependency)
    let viewController = CurrentActivityViewController()
    let interactor = CurrentActivityInteractor(
      presenter: viewController, 
      activityLogModelStream: component.activityLogModelStream
    )
    interactor.listener = listener
    return CurrentActivityRouter(
      interactor: interactor,
      viewController: viewController
    )
  }
}
