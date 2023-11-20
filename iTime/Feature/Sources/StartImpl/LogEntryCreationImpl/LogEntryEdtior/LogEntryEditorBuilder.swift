//
//  LogEntryEditorBuilder.swift
//  
//
//  Created by 이상헌 on 11/13/23.
//

import RIBs

import Start

// MARK: - LogEntryEditorDependency

public protocol LogEntryEditorDependency: Dependency {
  
}

// MARK: - LogEntryEditorComponent

final class LogEntryEditorComponent: Component<LogEntryEditorDependency> {
  
}

// MARK: - LogEntryEditorBuilder

public final class LogEntryEditorBuilder:
  Builder<LogEntryEditorDependency>,
  LogEntryEditorBuildable
{
  
  public override init(dependency: LogEntryEditorDependency) {
    super.init(dependency: dependency)
  }
  
  public func build(withListener listener: LogEntryEditorListener) -> LogEntryEditorRouting {
    let _ = LogEntryEditorComponent(dependency: dependency)
    let viewController = LogEntryEditorViewController()
    let interactor = LogEntryEditorInteractor(presenter: viewController)
    interactor.listener = listener
    return LogEntryEditorRouter(
      interactor: interactor,
      viewController: viewController
    )
  }
}
