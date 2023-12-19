//
//  LogEntryEditorBuilder.swift
//  
//
//  Created by 이상헌 on 11/13/23.
//

import RIBs

import Editor
import Start

// MARK: - LogEntryEditorDependency

public protocol LogEntryEditorDependency: Dependency {
  var categoryEditorBuilder: CategoryEditorBuildable { get }
  var activityLogModelStream: ActivityLogModelStream { get }
}

// MARK: - LogEntryEditorComponent

final class LogEntryEditorComponent: Component<LogEntryEditorDependency> {
  fileprivate var activityLogModelStream: ActivityLogModelStream {
    dependency.activityLogModelStream
  }
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
    let component = LogEntryEditorComponent(dependency: dependency)
    let viewController = LogEntryEditorViewController()
    let interactor = LogEntryEditorInteractor(
      presenter: viewController,
      activityLogModelStream: component.activityLogModelStream
    )
    interactor.listener = listener
    return LogEntryEditorRouter(
      interactor: interactor,
      viewController: viewController,
      categoryEditorBuilder: dependency.categoryEditorBuilder
    )
  }
}
