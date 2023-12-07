//
//  LogEntryCreationBuilder.swift
//  
//
//  Created by 이상헌 on 2023/11/05.
//

import RIBs

import Start
import Editor
import Entities
import AppFoundation

// MARK: - LogEntryCreationDependency

protocol LogEntryCreationDependency: Dependency {
  var bookmarkEditorBuilder: BookmarkEditorBuildable { get }
  var logEntryEditorBuilder: LogEntryEditorBuildable { get }
  var mutableBookmarkModelDataStream: MutableBookmarkModelDataStream { get }
  var timeFormatter: TimeFormatter { get }
}

// MARK: - LogEntryCreationComponent

final class LogEntryCreationComponent:
  Component<LogEntryCreationDependency>,
  TimeLogRunningDependency
{
  var timeFormatter: TimeFormatter {
    dependency.timeFormatter
  }
  
  fileprivate var logEntryEditorBuilder: LogEntryEditorBuildable {
      dependency.logEntryEditorBuilder
  }
  
  fileprivate var timeLogRunningBuilder: TimeLogRunningBuildable {
    TimeLogRunningBuilder(dependency: self)
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
      let interactor = LogEntryCreationInteractor(
        initialState: LogEntryCreationPresentableState(),
        presenter: viewController,
        bookmarkModelDataStream: dependency.mutableBookmarkModelDataStream
      )
        interactor.listener = listener
        return LogEntryCreationRouter(
          interactor: interactor,
          viewController: viewController,
          logEntryEditorBuilder: dependency.logEntryEditorBuilder,
          bookmarkEditorBuilder: dependency.bookmarkEditorBuilder,
          timeLogRunningBuilder: component.timeLogRunningBuilder
        )
    }
}
