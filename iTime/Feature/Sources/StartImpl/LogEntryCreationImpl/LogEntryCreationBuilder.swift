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
  var logEntryEditorBuilder: LogEntryEditorBuildable { get }
  var bookmarkListBuilder: BookmarkListBuildable { get }
  var bookmarkEditorBuilder: BookmarkEditorBuildable { get }
  var mutableBookmarkModelDataStream: MutableBookmarkModelDataStream { get }
  var timeFormatter: TimeFormatter { get }
}

// MARK: - LogEntryCreationComponent

final class LogEntryCreationComponent:
  Component<LogEntryCreationDependency>,
  TimeLogRunningDependency,
    LoggingRetentionDependency
{
  var timeFormatter: TimeFormatter {
    dependency.timeFormatter
  }
  
  var bookmarkEditorBuilder: BookmarkEditorBuildable {
    dependency.bookmarkEditorBuilder
  }
  
  fileprivate var logEntryEditorBuilder: LogEntryEditorBuildable {
    dependency.logEntryEditorBuilder
  }
  
  fileprivate var timeLogRunningBuilder: TimeLogRunningBuildable {
    TimeLogRunningBuilder(dependency: self)
  }
  
  fileprivate var loggingRetentionBuilder: LoggingRetentionBuildable {
    LoggingRetentionBuilder(dependency: self)
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
      presenter: viewController,
      bookmarkModelDataStream: dependency.mutableBookmarkModelDataStream
    )
    interactor.listener = listener
    return LogEntryCreationRouter(
      interactor: interactor,
      viewController: viewController,
      logEntryEditorBuilder: dependency.logEntryEditorBuilder,
      timeLogRunningBuilder: component.timeLogRunningBuilder,
      bookmarkListBuilder: dependency.bookmarkListBuilder,
      loggingRetentionBuilder: component.loggingRetentionBuilder
    )
  }
}
