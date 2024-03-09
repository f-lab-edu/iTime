//
//  LoggingRetentionBuilder.swift
//  
//
//  Created by 이상헌 on 12/10/23.
//

import RIBs

import Start

// MARK: - LoggingRetentionDependency

public protocol LoggingRetentionDependency: Dependency {
  
}

// MARK: - LoggingRetentionComponent

final class LoggingRetentionComponent: Component<LoggingRetentionDependency> {
  
}

// MARK: - LoggingRetentionBuilder

public final class LoggingRetentionBuilder:
  Builder<LoggingRetentionDependency>,
  LoggingRetentionBuildable
{
  
  public override init(dependency: LoggingRetentionDependency) {
    super.init(dependency: dependency)
  }
  
  public func build(withListener listener: LoggingRetentionListener) -> LoggingRetentionRouting {
    let _ = LoggingRetentionComponent(dependency: dependency)
    let viewController = LoggingRetentionViewController()
    let interactor = LoggingRetentionInteractor(presenter: viewController)
    interactor.listener = listener
    return LoggingRetentionRouter(
      interactor: interactor,
      viewController: viewController
    )
  }
}
