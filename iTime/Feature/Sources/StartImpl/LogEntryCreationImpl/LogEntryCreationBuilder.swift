//
//  LogEntryCreationBuilder.swift
//  
//
//  Created by 이상헌 on 2023/11/05.
//

import RIBs

import Start

// MARK: - LogEntryCreationDependency

protocol LogEntryCreationDependency: Dependency {
}

// MARK: - LogEntryCreationComponent

final class LogEntryCreationComponent: 
  Component<LogEntryCreationDependency>,
  LogEntryEditorDependency,
  BookmarkEditorDependency
{
  fileprivate var logEntryEditorBuilder: LogEntryEditorBuildable {
    LogEntryEditorBuilder(dependency: self)
  }
  
  fileprivate var bookmarkEditorBuilder: BookmarkEditorBuildable {
    BookmarkEditorBuilder(dependency: self)
  }
}

// MARK: - LogEntryCreationBuilder

final class LogEntryCreationBuilder:
  Builder<LogEntryCreationDependency>,
  LogEntryCreationBuildable
{

    override init(dependency: LogEntryCreationDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: LogEntryCreationListener) -> LogEntryCreationRouting {
        let component = LogEntryCreationComponent(dependency: dependency)
        let viewController = LogEntryCreationViewController()
        let interactor = LogEntryCreationInteractor(presenter: viewController)
        interactor.listener = listener
        return LogEntryCreationRouter(
          interactor: interactor,
          viewController: viewController,
          logEntryEditorBuilder: component.logEntryEditorBuilder, 
          bookmarkEditorBuilder: component.bookmarkEditorBuilder
        )
    }
}
