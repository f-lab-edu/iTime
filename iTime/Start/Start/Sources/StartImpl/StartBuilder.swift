//
//  StartBuilder.swift
//  
//
//  Created by 이상헌 on 11/11/23.
//

import RIBs

import Start

// MARK: - StartDependency

public protocol StartDependency: Dependency {
  
}

// MARK: - StartComponent

final class StartComponent: 
  Component<StartDependency>,
  LogEntryCreationDependency
{
  fileprivate var logEntryCreationBuilder: LogEntryCreationBuildable {
    LogEntryCreationBuilder(dependency: self)
  }
}

// MARK: - StartBuilder

public final class StartBuilder:
  Builder<StartDependency>,
  StartBuildable
{
  
  public override init(dependency: StartDependency) {
    super.init(dependency: dependency)
  }
  
  public func build(withListener listener: StartListener) -> StartRouting {
    let component = StartComponent(dependency: dependency)
    let viewController = StartViewController()
    let interactor = StartInteractor(presenter: viewController)
    interactor.listener = listener
    return StartRouter(
      interactor: interactor,
      viewController: viewController,
      logEntryCreationBuilder: component.logEntryCreationBuilder
    )
  }
}
